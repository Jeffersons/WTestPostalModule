import CSV
import Alamofire
import RealmSwift

typealias FetchPostalCodeSuccess = ((_ response: [PostalCodeViewModel]) -> Void)
typealias PostalCodeError = ((_ error: CodeErros) -> Void)
typealias ZipCodeIndexed = ((_ response: String) -> Void)
typealias DownloadFileSuccess = ((_ response: Bool) -> Void)
typealias DownloadFileProgress = ((_ response: CGFloat) -> Void)

protocol PostalCodeWorkerProtocol {
    func fechPostalCode(success: @escaping FetchPostalCodeSuccess, failure: @escaping PostalCodeError)
    func searchInformation(info: String, result: @escaping FetchPostalCodeSuccess)
    func updateZipCodeDataBase(success: @escaping ZipCodeIndexed, failure: @escaping PostalCodeError)
    func downloadFileAsync(finished: @escaping DownloadFileSuccess, downloadFileProgress: @escaping DownloadFileProgress, failure: @escaping PostalCodeError)
}

final class PostalCodeWorker {
    private func savePostalCodeEntity(postalcode: PostalCodeEntity) {
        guard let realm = Realm.safeInit() else {
            return
        }
        let searchDuplicates = realm.objects(PostalCodeEntity.self).filter("postalnumber == '\(postalcode.postalnumber)'")
        if searchDuplicates.count == 0 {
            realm.safeWrite {
                realm.add(postalcode)
            }
        }
    }
    
    private func verifyFileExists()-> URL? {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(Constants.postalCodeFileName)
            let filePath = fileURL.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: filePath) {
                return fileURL
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}

extension PostalCodeWorker: PostalCodeWorkerProtocol {
    func searchInformation(info: String, result: @escaping FetchPostalCodeSuccess) {
        guard let realm = Realm.safeInit() else {
            return
        }
        var dataSource: [PostalCodeViewModel] = []
        let query = "postalnumber CONTAINS[c] '\(info)' OR location CONTAINS[c] '\(info)'"
        let searchResult = realm.objects(PostalCodeEntity.self).filter(query)
        if searchResult.count > 0 {
            for i in 0..<searchResult.count {
                dataSource.append(PostalCodeViewModel(
                        postalText: searchResult[i].postalnumber,
                        locationText: searchResult[i].location
                    )
                )
            }
        }
        result(dataSource)
    }
    
    func updateZipCodeDataBase(success: @escaping ZipCodeIndexed, failure: @escaping PostalCodeError) {
        if let fileURL = verifyFileExists() {
            do {
                let csvString = try String(contentsOf: fileURL, encoding: .utf8)
                let csv = try CSVReader(string: csvString, hasHeaderRow: true)
                DispatchQueue.global(qos: .background).async { [weak self] in
                    while csv.next() != nil {
                        let postalcode = PostalCodeEntity()
                        if let location = csv["desig_postal"], let codPostal = csv["ext_cod_postal"], let numCodPostal = csv["num_cod_postal"] {
                            let postalNumber = String(numCodPostal) + "-" + String(codPostal).leadingZeros(3)
                            postalcode.postalnumber = postalNumber
                            postalcode.location = location
                            self?.savePostalCodeEntity(postalcode: postalcode)
                            success("\(postalNumber), \(location)")
                        }
                    }
                }
            } catch {
                failure(.unknownError)
            }
        } else {
            failure(.fileNotFound)
        }
    }
    
    func downloadFileAsync(finished: @escaping DownloadFileSuccess, downloadFileProgress: @escaping DownloadFileProgress, failure: @escaping PostalCodeError) {
        let fileName = Constants.postalCodeFileName
        var url = API.baseUrl
        url.append(fileName)
        guard let urlFile = URL(string: url) else {
            return
        }
        let urlRequest = URLRequest(url: urlFile)
        URLCache.shared.removeCachedResponse(for: urlRequest)
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        AF.download(url, method: .get, to: destination)
            .downloadProgress(closure: { (progress) in
                let percent = (CGFloat(progress.completedUnitCount) * 100)/CGFloat(Constants.postalCodeSizeEstimated)
                downloadFileProgress(percent / 100)
            }).response(completionHandler: { (DefaultDownloadResponse) in
                if DefaultDownloadResponse.response?.statusCode == 200 {
                    finished(true)
                }
            }
        )
    }
    
    func fechPostalCode(success: @escaping FetchPostalCodeSuccess, failure: @escaping PostalCodeError) {
        guard let realm = Realm.safeInit() else {
            return
        }
        let postalCodeEntity = realm.objects(PostalCodeEntity.self)
        if postalCodeEntity.count > 0 {
            var dataSource: [PostalCodeViewModel] = []
            var limiteRowNumber = 50
            if postalCodeEntity.count < 50 {
                limiteRowNumber = postalCodeEntity.count
            }
            for i in 0..<limiteRowNumber {
                dataSource.append(PostalCodeViewModel(
                        postalText: postalCodeEntity[i].postalnumber,
                        locationText: postalCodeEntity[i].location
                    )
                )
            }
            success(dataSource)
        } else {
            failure(.emptyDataBase)
        }
    }
}

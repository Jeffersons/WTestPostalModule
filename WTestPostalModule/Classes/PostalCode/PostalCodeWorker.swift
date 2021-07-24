import CSV
import Alamofire

class PostalCodeWorker {
    func fetchPostalCodes() -> [PostalCodeViewModel] {
        loadFileAsync()
        var dataSource = [PostalCodeViewModel(postalText: "3750-364", locationText: "Belazaima do Chão")]
        dataSource.append(PostalCodeViewModel(postalText: "3780-425", locationText: "Avelãs de Cima"))
        dataSource.append(PostalCodeViewModel(postalText: "7300-238", locationText: "Portalegre"))
        dataSource.append(PostalCodeViewModel(postalText: "4925-413", locationText: "Lanheses"))
        dataSource.append(PostalCodeViewModel(postalText: "2695-650", locationText: "São João da Talha"))
        return dataSource
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func loadFileAsync() {
        let fileName = "codigos_postais.csv"
        var url = "https://github.com/centraldedados/codigos_postais/raw/master/data/"
        url.append(fileName)
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory)
        AF.download(url, method: .get, to: destination)
            .downloadProgress(closure: { (progress) in
                print(progress.fileCompletedCount ?? "NIL")
            }).response(completionHandler: { (DefaultDownloadResponse) in
                if DefaultDownloadResponse.response?.statusCode == 200 {
                    self.parseCSV()
                }
            })
    }
    
    func parseCSV() {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent("codigos_postais.csv")
            do {
                let csvString = try String(contentsOf: fileURL, encoding: .utf8)
                let csv = try CSVReader(string: csvString, hasHeaderRow: true)
                while csv.next() != nil {
                    print("\(csv["desig_postal"]!)")
                }
            } catch {
                print("DeuRuim")
            }
        }
    }
}

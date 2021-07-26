import UIKit

protocol PostalCodeBusinessLogic {
    func fetchPostalCodes()
    func searchInformation(info: String)
}

final class PostalCodeInteractor {
    let presenter: PostalCodePresentationLogic
    let worker: PostalCodeWorkerProtocol
    
    init(worker: PostalCodeWorkerProtocol, presenter: PostalCodePresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}
// MARK: BusinessLogic Implementation
extension PostalCodeInteractor: PostalCodeBusinessLogic {
    func searchInformation(info: String) {
        worker.searchInformation(info: info, result: { [weak self] response in
            self?.presenter.presentPostalCodes(response: response)
        })
    }
    
    func fetchPostalCodes() {
        worker.fechPostalCode(success: { [weak self] response in
            self?.presenter.presentPostalCodes(response: response)
        }, failure: { [weak self] error in
            if error == .emptyDataBase {
                self?.downloadPostalCodeFile()
            }
        })
    }
}
// MARK: BusinessLogic Implementation
private extension PostalCodeInteractor {
    func downloadPostalCodeFile() {
        worker.downloadFileAsync(finished: { [weak self] response in
            self?.updateZipCodeDataBase()
        }, downloadFileProgress: { [weak self] progress in
            self?.presenter.presentProgressStatus(response: progress)
        }, failure: { error in
            debugPrint("ERROR: \(error.hashValue)")
        })
    }
    
    func updateZipCodeDataBase() {
        worker.updateZipCodeDataBase(success: { [weak self] response in
            self?.presenter.presentUpdateZipCodeIndexed(response: response)
        }, failure: { error in
            debugPrint("ERROR: \(error.hashValue)")
        })
    }
}

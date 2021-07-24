import UIKit

protocol PostalCodeBusinessLogic {
    func fetchPostalCodes()
}

final class PostalCodeInteractor {
    let presenter: PostalCodePresentationLogic
    let worker: PostalCodeWorker
    
    init(worker: PostalCodeWorker, presenter: PostalCodePresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}
// MARK: BusinessLogic Implementation
extension PostalCodeInteractor: PostalCodeBusinessLogic {
    func fetchPostalCodes() {
        let response = worker.fetchPostalCodes()
        presenter.presentPostalCodes(response: response)
    }
}

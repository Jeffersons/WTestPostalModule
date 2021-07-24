import UIKit

protocol SampleBusinessLogic {
    func doSomething()
}

class SampleInteractor: SampleBusinessLogic {
    var presenter: SamplePresentationLogic?
    var worker: SampleWorker
    
    init(worker: SampleWorker, presenter: SamplePresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
    
    // MARK: Do something
    func doSomething() {
        let response = worker.doSomeWork()
        presenter?.presentSomething(response: response)
    }
}

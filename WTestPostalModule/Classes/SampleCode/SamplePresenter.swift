import Foundation

protocol SamplePresentationLogic {
    func presentSomething(response: SampleModel)
}

class SamplePresenter: SamplePresentationLogic {
    weak var viewController: SampleDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: SampleModel) {
        viewController?.displaySomething(viewModel: response)
    }
}

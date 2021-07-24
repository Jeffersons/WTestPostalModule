import UIKit

public final class SampleBuild {
    public init() {}
    
    public func build() -> UIViewController {
        let presenter = SamplePresenter()
        let worker = SampleWorker()
        let interactor = SampleInteractor(
            worker: worker,
            presenter: presenter
        )
        let controller = SampleViewController(interactor: interactor)
        controller.view.frame = UIScreen.main.bounds

        presenter.viewController = controller
        return controller
    }
}

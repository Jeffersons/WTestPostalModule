import UIKit

public final class PostalCodeBuild {
    public init() {}
    
    public func build() -> UIViewController {
        let presenter = PostalCodePresenter()
        let worker = PostalCodeWorker()
        let interactor = PostalCodeInteractor(
            worker: worker,
            presenter: presenter
        )
        let controller = PostalCodeViewController(interactor: interactor)
        presenter.viewController = controller
        return controller
    }
}

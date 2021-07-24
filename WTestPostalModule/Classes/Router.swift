import UIKit

public final class Router: NSObject {
    public static func rootViewController() -> UIViewController {
        let viewController: UIViewController = SampleBuild()
            .build()
        return viewController
    }
}

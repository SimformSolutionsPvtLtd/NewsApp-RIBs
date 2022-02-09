import RIBs
import RxSwift
import UIKit

protocol RootPresentableListener: AnyObject {}

final class RootViewController: UINavigationController, RootPresentable {
    weak var listener: RootPresentableListener?
}

// MARK: - RootViewControllable

extension RootViewController: RootViewControllable {
    func pushViewController(_ viewController: ViewControllable, animated: Bool) {
        self.navigationBar.isHidden = true
        pushViewController(viewController.uiviewController, animated: true)
    }
}

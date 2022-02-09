import RIBs

protocol RootInteractable: Interactable, TabbarListener {
    var router: RootRouting? { get set }
    var listener: RootListener? { get set }
}

protocol RootViewControllable: ViewControllable {
    func pushViewController(_ viewController: ViewControllable, animated: Bool)
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {

    // MARK: - Properties

    private let tabbarBuilder: TabbarBuilder

    // MARK: - Initialization

    init(tabbarBuilder: TabbarBuilder, interactor: RootInteractable, viewController: RootViewControllable) {
        self.tabbarBuilder = tabbarBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    // MARK: - Overridden: LaunchRouter

    override func didLoad() {
        super.didLoad()
        attachTabbarRIB()
    }

    // MARK: - Private methods

    private func attachTabbarRIB() {
        let router = tabbarBuilder.build(withListener: interactor)
        attachChild(router)
        viewController.pushViewController(router.viewControllable, animated: false)
    }
}

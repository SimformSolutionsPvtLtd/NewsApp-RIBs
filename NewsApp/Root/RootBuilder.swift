import RIBs

protocol RootDependency: Dependency {}

final class RootComponent: Component<RootDependency> {

    let rootViewController: RootViewController

    init(dependency: RootDependency, rootViewController: RootViewController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}

extension RootComponent: TabbarDependency {
    var newsNetworkService: NetworkService {
        return NetworkService()
    }
}

// MARK: - Builder

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {

    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let viewController = RootViewController()
        let component = RootComponent(dependency: dependency, rootViewController: viewController)
        let interactor = RootInteractor(presenter: viewController)
        let tabBarBuilder = TabbarBuilder(dependency: component)
        return RootRouter(tabbarBuilder: tabBarBuilder, interactor: interactor, viewController: viewController)
    }
}

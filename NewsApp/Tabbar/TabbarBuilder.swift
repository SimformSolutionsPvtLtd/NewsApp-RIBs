//
//  TabbarBuilder.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 04/02/22.
//

import RIBs

protocol TabbarDependency: Dependency {
    var newsNetworkService: NetworkService { get  }
}

final class TabbarComponent: Component<TabbarDependency> {
    var newsService: NewsService {
        return dependency.newsNetworkService
    }
}
extension TabbarComponent: ListingViewDependency, GridViewDependency {}

// MARK: - Builder

protocol TabbarBuildable: Buildable {
    func build(withListener listener: TabbarListener) -> TabbarRouting
}

final class TabbarBuilder: Builder<TabbarDependency>, TabbarBuildable {

    override init(dependency: TabbarDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: TabbarListener) -> TabbarRouting {
        let viewController = TabbarViewController()
        let component = TabbarComponent(dependency: dependency)
        let interactor = TabbarInteractor(presenter: viewController, newsService: component.newsService)
        interactor.listener = listener
        let listBuilder = ListingViewBuilder(dependency: component)
        let gridBuilder = GridViewBuilder(dependency: component)
        return  TabbarRouter(interactor: interactor, viewController: viewController, listBuilder: listBuilder, gridBuilder: gridBuilder)
    }
}

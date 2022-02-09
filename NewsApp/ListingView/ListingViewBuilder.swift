//
//  ListingViewBuilder.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 07/02/22.
//

import RIBs

protocol ListingViewDependency: Dependency {}

final class ListingViewComponent: Component<ListingViewDependency> {}
extension ListingViewComponent: DetailNewsDependency {}

// MARK: - Builder

protocol ListingViewBuildable: Buildable {
    func build(withListener listener: ListingViewListener) -> ListingViewRouting
}

final class ListingViewBuilder: Builder<ListingViewDependency>, ListingViewBuildable {

    override init(dependency: ListingViewDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ListingViewListener) -> ListingViewRouting {
        let component = ListingViewComponent(dependency: dependency)
        let viewController = ListingViewViewController()
        let interactor = ListingViewInteractor(presenter: viewController)
        interactor.listener = listener

        let detailBuilder = DetailNewsBuilder(dependency: component)
        return ListingViewRouter(interactor: interactor, viewController: viewController, detailBuilder: detailBuilder)
    }
}

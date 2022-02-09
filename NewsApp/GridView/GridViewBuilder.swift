//
//  GridViewBuilder.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 07/02/22.
//

import RIBs

protocol GridViewDependency: Dependency {}

final class GridViewComponent: Component<GridViewDependency> {}

// MARK: - Builder

protocol GridViewBuildable: Buildable {
    func build(withListener listener: GridViewListener) -> GridViewRouting
}

final class GridViewBuilder: Builder<GridViewDependency>, GridViewBuildable {

    override init(dependency: GridViewDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: GridViewListener) -> GridViewRouting {
        _ = GridViewComponent(dependency: dependency)
        let viewController = GridViewViewController()
        let interactor = GridViewInteractor(presenter: viewController)
        interactor.listener = listener
        return GridViewRouter(interactor: interactor, viewController: viewController)
    }
}

//
//  ListViewBuilder.swift
//  RIBDemo
//
//  Created by Shilpesh Shah on 04/02/22.
//

import RIBs

protocol ListViewDependency: Dependency {}

final class ListViewComponent: Component<ListViewDependency> {}

// MARK: - Builder

protocol ListViewBuildable: Buildable {
    func build(withListener listener: ListViewListener) -> ListViewRouting
}

final class ListViewBuilder: Builder<ListViewDependency>, ListViewBuildable {

    override init(dependency: ListViewDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ListViewListener) -> ListViewRouting {
        let component = ListViewComponent(dependency: dependency)
        let viewController = ListViewViewController()
        let interactor = ListViewInteractor(presenter: viewController)
        interactor.listener = listener
        return ListViewRouter(interactor: interactor, viewController: viewController)
    }
}

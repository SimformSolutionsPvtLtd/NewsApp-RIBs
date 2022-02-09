//
//  DetailNewsBuilder.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 07/02/22.
//

import RIBs

protocol DetailNewsDependency: Dependency {}

final class DetailNewsComponent: Component<DetailNewsDependency> {}

// MARK: - Builder

protocol DetailNewsBuildable: Buildable {
    func build(withListener listener: DetailNewsListener, newsDetail: Article) -> DetailNewsRouting
}

final class DetailNewsBuilder: Builder<DetailNewsDependency>, DetailNewsBuildable {

    override init(dependency: DetailNewsDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: DetailNewsListener, newsDetail: Article) -> DetailNewsRouting {
        _ = DetailNewsComponent(dependency: dependency)
        let viewController = DetailNewsViewController()
        let interactor = DetailNewsInteractor(presenter: viewController, newsDetail: newsDetail)
        interactor.listener = listener
        return DetailNewsRouter(interactor: interactor, viewController: viewController)
    }
}

//
//  ListingViewRouter.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 07/02/22.
//

import RIBs

protocol ListingViewInteractable: Interactable, DetailNewsListener {
    var router: ListingViewRouting? { get set }
    var listener: ListingViewListener? { get set }
}

protocol ListingViewViewControllable: ViewControllable {
    func pushViewController(_ viewController: ViewControllable, animated: Bool)
    func popViewController(animated: Bool)
}

final class ListingViewRouter: ViewableRouter<ListingViewInteractable, ListingViewViewControllable>, ListingViewRouting {

    // MARK: - Properties

    var newsBuildable: DetailNewsBuildable
    private var detailNewsRouter: DetailNewsRouting?

    // MARK: - Initialization

    init(interactor: ListingViewInteractable, viewController: ListingViewViewControllable, detailBuilder: DetailNewsBuilder) {
        self.newsBuildable = detailBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    func routeToDetail(for newsDetail: Article) {
        let detailRouting = newsBuildable.build(withListener: interactor, newsDetail: newsDetail)
        attachChild(detailRouting)
        detailNewsRouter = detailRouting
        viewController.pushViewController(detailRouting.viewControllable, animated: true)
    }
}

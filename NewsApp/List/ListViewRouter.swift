//
//  ListViewRouter.swift
//  RIBDemo
//
//  Created by Shilpesh Shah on 04/02/22.
//

import RIBs

protocol ListViewInteractable: Interactable {
    var router: ListViewRouting? { get set }
    var listener: ListViewListener? { get set }
}

protocol ListViewViewControllable: ViewControllable {}

final class ListViewRouter: ViewableRouter<ListViewInteractable, ListViewViewControllable>, ListViewRouting {

    override init(interactor: ListViewInteractable, viewController: ListViewViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}

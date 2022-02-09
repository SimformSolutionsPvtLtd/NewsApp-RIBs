//
//  GridViewRouter.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 07/02/22.
//

import RIBs
import SafariServices
protocol GridViewInteractable: Interactable {
    var router: GridViewRouting? { get set }
    var listener: GridViewListener? { get set }
}

protocol GridViewViewControllable: ViewControllable {}

final class GridViewRouter: ViewableRouter<GridViewInteractable, GridViewViewControllable>, GridViewRouting {

    // MARK: - Initialization

    override init(interactor: GridViewInteractable, viewController: GridViewViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    func redirectToNewsInWeb(url: String) {
        if let url = URL(string: url) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let safariVC = SFSafariViewController(url: url, configuration: config)
            viewController.uiviewController.present(safariVC, animated: true, completion: nil)
        }
    }
}

//
//  DetailNewsRouter.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 07/02/22.
//

import RIBs
import SafariServices

protocol DetailNewsInteractable: Interactable {
    var router: DetailNewsRouting? { get set }
    var listener: DetailNewsListener? { get set }
}

protocol DetailNewsViewControllable: ViewControllable {}

final class DetailNewsRouter: ViewableRouter<DetailNewsInteractable, DetailNewsViewControllable>, DetailNewsRouting {

    // MARK: - Initialization

    override init(interactor: DetailNewsInteractable, viewController: DetailNewsViewControllable) {
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

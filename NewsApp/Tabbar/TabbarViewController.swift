//
//  TabbarViewController.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 04/02/22.
//

import RIBs
import RxSwift
import UIKit

protocol TabbarPresentableListener: AnyObject {
    func fetchNews(isRefresh: Bool)
}

final class TabbarViewController: UITabBarController, TabbarPresentable {

    // MARK: - Properties

    weak var listener: TabbarPresentableListener?
    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

    // MARK: - View Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        DispatchQueue.main.async { [weak self] in
            self?.listener?.fetchNews(isRefresh: false)
        }
    }

    // MARK: - TabbarPresentable

    func showActivityIndicator(_ isLoading: Bool) {
        if isLoading {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    func showErrorAlert(error:String) {
        self.showErrorAlert(with: error)
    }

}

// MARK: - TabbarViewControllable

extension TabbarViewController:TabbarViewControllable {
    func present(viewControllers: [UIViewController]) {
        setViewControllers(viewControllers, animated: false)
    }
}

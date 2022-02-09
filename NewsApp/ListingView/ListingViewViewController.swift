//
//  ListingViewViewController.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 07/02/22.
//

import RIBs
import RxSwift
import UIKit
import RxCocoa
protocol ListingViewPresentableListener: AnyObject {
    var newsList: BehaviorRelay<News> { get}
    func setNewsData()
    func didSelect(_ newsDetail: Article)
    func refreshNews()
}

final class ListingViewViewController: UIViewController, ListingViewPresentable {

    // MARK: - Outlets

    @IBOutlet weak var tblView: UITableView!

    // MARK: - Propertiels

    weak var listener: ListingViewPresentableListener?
    private let refreshControl = UIRefreshControl()

    // MARK: - View Cycle

    override func viewDidLoad() {
        setupView()
    }
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.refreshData, object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.setNewsData(notification:)), name: NSNotification.refreshData, object: nil)
    }

    // MARK: - Private Methods

    private func setupView() {
        self.navigationItem.title = R.string.localization.newsTitle()
        tblView.estimatedRowHeight = 250
        tblView.rowHeight = UITableView.automaticDimension
        tblView.register(R.nib.newsListCell)
        tblView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refreshNewsData(_:)), for: .valueChanged)
    }

    @objc func setNewsData(notification: Notification) {
        listener?.setNewsData()
    }
    @objc private func refreshNewsData(_ sender: Any) {
        listener?.refreshNews()
    }

    // MARK: - ListingViewPresentable

    func refreshData() {
        DispatchQueue.main.async { [weak self] in
            self?.refreshControl.endRefreshing()
            self?.tblView.reloadData()
        }
    }
}

// MARK: - ListingViewControllable

extension ListingViewViewController:ListingViewViewControllable {
    func pushViewController(_ viewController: ViewControllable, animated: Bool) {
        viewController.uiviewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController.uiviewController, animated: animated)
    }

    func popViewController(animated: Bool) {
        self.navigationController?.popViewController(animated: animated)
    }
}

// MARK: - Tableview Datasource

extension ListingViewViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listener?.newsList.value.articles.count ?? 1
    }
}

// MARK: - Tableview Delegate

extension ListingViewViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell =  tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.newsListCell.identifier) as? NewsListCell else {
            return UITableViewCell()
        }
        guard let article =  listener?.newsList.value.articles[indexPath.item] else {
            return cell
        }
        cell.setupCell(news: article)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let article =  listener?.newsList.value.articles[indexPath.item] else {
            return
        }
        listener?.didSelect(article)
    }
}

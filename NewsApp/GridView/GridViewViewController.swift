//
//  GridViewViewController.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 07/02/22.
//

import RIBs
import RxSwift
import UIKit
import RxCocoa
protocol GridViewPresentableListener: AnyObject {
    var newsList: BehaviorRelay<News> { get}
    func setNewsData()
    func refreshNews()
    func redirectToWebNews(newsUrl: String)
}
protocol WebDelegate: AnyObject {
   func redirectedToWebView (newsDetail : Article)
}
final class GridViewViewController: UIViewController, GridViewPresentable, GridViewViewControllable,WebDelegate {

    // MARK: - Outlets

    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Properties

    weak var listener: GridViewPresentableListener?

    // MARK: - View Cycle

    override func viewDidLoad() {
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshNewsData))
        self.navigationItem.rightBarButtonItem = refreshButton
        collectionView.register(R.nib.newsGridCell)
        listener?.setNewsData()
    }

    @objc private func refreshNewsData(_ sender: Any) {
        listener?.refreshNews()
    }

    func redirectedToWebView(newsDetail: Article) {
        listener?.redirectToWebNews(newsUrl: newsDetail.url ?? "")
    }

    // MARK: - GridViewPresentable

    func refreshData() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

// MARK: - CollectionView Datasource and Delegates

extension GridViewViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listener?.newsList.value.articles.count ?? 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.newsGridCell.identifier, for: indexPath) as?  NewsGridCell else {
            return UICollectionViewCell()
        }
        guard let article =  listener?.newsList.value.articles[indexPath.item] else {
            return cell
        }
        cell.setupCell(news: article)
        cell.webDelegate = self
        return cell
    }
}

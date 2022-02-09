//
//  ListingViewInteractor.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 07/02/22.
//

import RIBs
import RxSwift
import RxCocoa
protocol ListingViewRouting: ViewableRouting {
    func routeToDetail(for image: Article)
}

protocol ListingViewPresentable: Presentable {
    var listener: ListingViewPresentableListener? { get set }
    func refreshData()
}

protocol ListingViewListener: AnyObject {
    var newsList: BehaviorRelay<News> { get set }
    func fetchNews(isRefresh: Bool)
}

final class ListingViewInteractor: PresentableInteractor<ListingViewPresentable>, ListingViewInteractable, ListingViewPresentableListener {

    // MARK: - Properties

    var newsList: BehaviorRelay<News>
    weak var router: ListingViewRouting?
    weak var listener: ListingViewListener?

    // MARK: - Intialization

    override init(presenter: ListingViewPresentable) {
        self.newsList = BehaviorRelay<News>(value: News(status: "", totalResults: 0, articles: []))
        super.init(presenter: presenter)
        presenter.listener = self

    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }

    // MARK: - ListingViewPresentableListener

    func setNewsData() {
        self.newsList = listener?.newsList ?? BehaviorRelay<News>(value: News(status: "", totalResults: 0, articles: []))
        presenter.refreshData()
    }

    func refreshNews() {
        listener?.fetchNews(isRefresh: true)
    }

    // MARK: - DetailNewsListener

    func didSelect(_ newsDetail: Article) {
        router?.routeToDetail(for: newsDetail)
    }
}

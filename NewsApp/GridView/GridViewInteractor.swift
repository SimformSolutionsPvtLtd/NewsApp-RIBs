//
//  GridViewInteractor.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 07/02/22.
//

import RIBs
import RxSwift
import RxRelay

protocol GridViewRouting: ViewableRouting {
    func redirectToNewsInWeb(url: String)
}

protocol GridViewPresentable: Presentable {
    var listener: GridViewPresentableListener? { get set }
    func refreshData()
}

protocol GridViewListener: AnyObject {

    var newsList: BehaviorRelay<News> { get set }
    func fetchNews(isRefresh: Bool)
}

final class GridViewInteractor: PresentableInteractor<GridViewPresentable>, GridViewInteractable, GridViewPresentableListener {

    // MARK: - Properties

    var newsList: BehaviorRelay<News>
    weak var router: GridViewRouting?
    weak var listener: GridViewListener?

    // MARK: - Intialization

    override init(presenter: GridViewPresentable) {
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

    // MARK: - GridViewPresentableListener

    func setNewsData() {
        self.newsList = listener?.newsList ?? BehaviorRelay<News>(value: News(status: "", totalResults: 0, articles: []))
        presenter.refreshData()
    }

    func refreshNews() {
        listener?.fetchNews(isRefresh: false)
    }

    // MARK: - WebViewListener

    func redirectToWebNews(newsUrl: String) {
        router?.redirectToNewsInWeb(url: newsUrl)
    }
}

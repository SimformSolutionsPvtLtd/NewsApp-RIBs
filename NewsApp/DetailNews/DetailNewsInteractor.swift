//
//  DetailNewsInteractor.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 07/02/22.
//

import RIBs
import RxSwift

protocol DetailNewsRouting: ViewableRouting {
    func redirectToNewsInWeb(url: String)
}

protocol DetailNewsPresentable: Presentable {
    var listener: DetailNewsPresentableListener? { get set }
}

protocol DetailNewsListener: AnyObject {}

final class DetailNewsInteractor: PresentableInteractor<DetailNewsPresentable>, DetailNewsInteractable, DetailNewsPresentableListener {

    // MARK: - Properties

    var newsDetail: Article
    weak var router: DetailNewsRouting?
    weak var listener: DetailNewsListener?

    // MARK: - Intialization

    init(presenter: DetailNewsPresentable, newsDetail: Article) {
        self.newsDetail = newsDetail
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }

    // MARK: - WebViewListener

    func redirectToWebNews(newsUrl: String) {
        router?.redirectToNewsInWeb(url: newsUrl)
    }
}

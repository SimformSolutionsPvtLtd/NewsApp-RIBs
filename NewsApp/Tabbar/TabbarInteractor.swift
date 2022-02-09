//
//  TabbarInteractor.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 04/02/22.
//

import RIBs
import RxCocoa

protocol TabbarRouting: ViewableRouting {}

protocol TabbarPresentable: Presentable {
    var listener: TabbarPresentableListener? { get set }
    func showActivityIndicator(_ isLoading: Bool)
    func showErrorAlert(error:String)
}

protocol TabbarListener: AnyObject {}

final class TabbarInteractor: PresentableInteractor<TabbarPresentable>, TabbarInteractable, TabbarPresentableListener {

    // MARK: - Properties

    weak var router: TabbarRouting?
    weak var listener: TabbarListener?
    var newsList: BehaviorRelay<News>
    private let newsService: NewsService

    // MARK: - Initialization

    init(presenter: TabbarPresentable, newsService: NewsService) {
        self.newsService = newsService
        newsList = BehaviorRelay<News>(value: News(status: "", totalResults: 0, articles: []))
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }

    // MARK: - TabbarPresentableListener

    func fetchNews(isRefresh: Bool) {
        if !isRefresh {
            presenter.showActivityIndicator(true)
        }
        let params = [APIConstant.RequestParameters.country : APIConstant.RequestParameters.countryValue,
                      APIConstant.RequestParameters.apiKey : APIConstant.RequestParameters.apiKeyValue]
        newsService.fetchNews(type: .newsFetch, parameters: params)
            .done { [weak self] news in
                self?.newsList.accept(news)
                self?.presenter.showActivityIndicator(false)
                NotificationCenter.default.post(name: NSNotification.refreshData, object: nil)
            }
            .catch { error in
                self.presenter.showActivityIndicator(false)
                self.presenter.showErrorAlert(error:error.localizedDescription)
                print(error)
            }
            .finally {
                self.presenter.showActivityIndicator(false)
            }
    }
}

//
//  TabbarRouter.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 04/02/22.
//

import RIBs
import UIKit

protocol TabbarInteractable: Interactable, ListingViewListener, GridViewListener {
    var router: TabbarRouting? { get set }
    var listener: TabbarListener? { get set }
}

protocol TabbarViewControllable: ViewControllable {
    func present(viewControllers: [UIViewController])
}

final class TabbarRouter: ViewableRouter<TabbarInteractable, TabbarViewControllable>, TabbarRouting {

    // MARK: - Properties

    private let listBuilder: ListingViewBuildable
    private var newsList: ViewableRouting?
    private let gridBuilder: GridViewBuildable
    private var gridNewsList: ViewableRouting?
    private var listNavigationVC: UINavigationController?

    // MARK: - Intialization

    init(interactor: TabbarInteractable,
         viewController: TabbarViewControllable,
         listBuilder: ListingViewBuildable,
         gridBuilder: GridViewBuildable) {
        self.listBuilder = listBuilder
        self.gridBuilder = gridBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    // MARK: - Overridden: LaunchRouter

    override func didLoad() {
        setTabBar()
    }

    // MARK: Private methods

    private func setTabBar() {
        setnewsList()
        setnewsGrid()

        self.listNavigationVC = UINavigationController(rootViewController: newsList!.viewControllable.uiviewController)
        let gridNavigationVC = UINavigationController(rootViewController: gridNewsList!.viewControllable.uiviewController)
        viewController.present(viewControllers: [listNavigationVC!, gridNavigationVC])
    }

    private func setnewsList() {
        let newsList = listBuilder.build(withListener: interactor)
        self.newsList = newsList
        attachChild(newsList)
        newsList.viewControllable.uiviewController.tabBarItem = UITabBarItem(title:R.string.localization.list(), image:   R.image.ic_list(), tag: 0)
    }

    private func setnewsGrid() {
        let gridList = gridBuilder.build(withListener: interactor)
        self.gridNewsList = gridList
        attachChild(gridList)

        gridList.viewControllable.uiviewController.tabBarItem = UITabBarItem(title:R.string.localization.grid(), image: R.image.ic_grid(), tag: 1)
    }
}

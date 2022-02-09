//
//  ListViewInteractor.swift
//  RIBDemo
//
//  Created by Shilpesh Shah on 04/02/22.
//

import RIBs
import RxSwift

protocol ListViewRouting: ViewableRouting {
}

protocol ListViewPresentable: Presentable {
    var listener: ListViewPresentableListener? { get set }
}

protocol ListViewListener: AnyObject {
}

final class ListViewInteractor: PresentableInteractor<ListViewPresentable>, ListViewInteractable, ListViewPresentableListener {

    weak var router: ListViewRouting?
    weak var listener: ListViewListener?

    override init(presenter: ListViewPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
    }
}

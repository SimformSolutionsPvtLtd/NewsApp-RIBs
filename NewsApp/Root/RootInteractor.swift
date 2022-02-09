import RIBs
import RxSwift

/// Declare methods the interactor can invoke to manage sub-tree via the router.
protocol RootRouting: ViewableRouting {}

/// Declare methods the interactor can invoke the presenter to present data.
protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
}

/// Declare methods the interactor can invoke to communicate with other RIBs.
protocol RootListener: AnyObject {}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener {

    // MARK: - Properties

    weak var router: RootRouting?
    weak var listener: RootListener?

    // MARK: - Initialization

    override init(presenter: RootPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

}

//
//  DetailNewsViewController.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 07/02/22.
//

import RIBs
import RxSwift
import UIKit
import Kingfisher
protocol DetailNewsPresentableListener: AnyObject {
    var newsDetail: Article {get}
    func redirectToWebNews(newsUrl: String)
}

final class DetailNewsViewController: UIViewController, DetailNewsPresentable, DetailNewsViewControllable {

    // MARK: - Outlets

    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgNews: UIImageView!

    // MARK: - Properties

    weak var listener: DetailNewsPresentableListener?

    // MARK: - View Cycle

    override func viewDidLoad() {
        setupView()
    }

    // MARK: - Private Methods

    private func setupView() {
        guard let newsDetail = listener?.newsDetail else { return }
        lblTitle.text = newsDetail.title
        lblDescription.text = newsDetail.description
        guard let url = URL(string: newsDetail.urlToImage ?? "") else {
            return
        }
        imgNews.kf.setImage(with: url, placeholder: R.image.ic_placeHolder(), options: nil, progressBlock: nil, completionHandler: nil)
    }

    // MARK: - Action

    @IBAction func btnWebTapped(_ sender: UIButton) {
        guard let newsDetail = listener?.newsDetail else { return }
        listener?.redirectToWebNews(newsUrl:newsDetail.url ?? "")
    }

}

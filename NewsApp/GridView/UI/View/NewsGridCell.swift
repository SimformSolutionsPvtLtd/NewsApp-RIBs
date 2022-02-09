//
//  NewsGridCellCell.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 07/02/22.
//

import UIKit
import Kingfisher
class NewsGridCell: UICollectionViewCell {

    // MARK: - Outlets

    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var btnWeb: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTitle: UILabel!

    // MARK: - Properties

    var webDelegate:WebDelegate?
    var newsDetail:Article?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imgNews.image = nil
        lblDescription.text = nil
        lblTitle.text = nil
    }

    // MARK: - Methods

    func setupCell(news: Article) {
        newsDetail = news
        DispatchQueue.main.async { [weak self] in
            self?.lblTitle.text = news.title
            self?.lblDescription.text = news.description
            guard let url = URL(string: news.urlToImage ?? "") else {
                return
            }
            self?.imgNews.kf.setImage(with: url, placeholder: UIImage(named: "ic_placeHolder"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }

    // MARK: - Actions

    @IBAction func btnWebTapped(_ sender: Any) {
        guard let newsDetail = self.newsDetail else {
            return
        }
        webDelegate?.redirectedToWebView(newsDetail: newsDetail)
    }

}

//
//  NewsListCell.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 07/02/22.
//

import UIKit
import Kingfisher
class NewsListCell: UITableViewCell {

    // MARK: - Outlets

    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lblDescription: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        imgNews.image = nil
        titleLabel.text = nil
        lblDescription.text = nil
    }

    // MARK: - Methods

    func setupCell(news: Article) {
        DispatchQueue.main.async {[weak self] in
            self?.titleLabel.text = news.title
            self?.lblDescription.text = news.description
            guard let url = URL(string: news.urlToImage ?? "") else {
                return
            }
            self?.imgNews.kf.setImage(with: url, placeholder: R.image.ic_placeHolder(), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
}

//
//  Article.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 07/02/22.
//

import Foundation
// MARK: - Article
struct Article: Codable {
    
    let source: Source?
    let author, title, description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case source, author, title, description
        case url, urlToImage, publishedAt, content
    }
    
}

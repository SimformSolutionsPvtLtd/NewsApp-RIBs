//
//  News.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 07/02/22.
//

import Foundation

// MARK: - News
struct News: Codable {
    
    let status: String?
    let totalResults: Int?
    let articles: [Article?]
    
}

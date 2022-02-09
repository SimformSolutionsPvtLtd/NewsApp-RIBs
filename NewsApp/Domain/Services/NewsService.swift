//
//  NewsService.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 07/02/22.
//

import PromiseKit

protocol NewsService {
    func fetchNews(type:RequestItemType, parameters: [String: String]) -> Promise<News>
}

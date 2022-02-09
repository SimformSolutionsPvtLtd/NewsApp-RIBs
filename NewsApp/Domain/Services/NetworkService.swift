//
//  NetworkService.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 05/02/22.
//

import Foundation
import PromiseKit

class NetworkService: NewsService {
    func fetchNews(type:RequestItemType,parameters: [String: String]) -> Promise<News> {
        var urlComponents = URLComponents(string: type.url)

        urlComponents?.queryItems = parameters.map { key, value in URLQueryItem(name: key, value: value) }

        return Promise { resolver in
            guard let url = urlComponents?.url?.absoluteURL else {
                resolver.reject(ServiceParsingError.inValidURL)
                return
            }
            URLSession.shared.dataTask(with: url) { data, _, error in
                guard error == nil else {
                    resolver.reject(ServiceNetworkError.httpError(error!))
                    return
                }
                guard let data = data else {
                    resolver.reject(ServiceNetworkError.noData)
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let imageData = try decoder.decode(News.self, from: data)
                    resolver.resolve(.fulfilled(imageData))
                } catch  DecodingError.dataCorrupted(_) {
                    resolver.reject(ServiceParsingError.dataCorrupted)
                } catch  DecodingError.keyNotFound(_, _) {
                    resolver.reject(ServiceParsingError.keyNotFound)
                } catch DecodingError.valueNotFound(_,_) {
                    resolver.reject(ServiceParsingError.valueNotFound)
                } catch  DecodingError.typeMismatch(_, _) {
                    resolver.reject(ServiceParsingError.typeMismatch)
                } catch {
                    resolver.reject(ServiceParsingError.generalError(error))
                }
            }.resume()
        }
    }
}

enum ServiceNetworkError: Error {
    case noData
    case httpError(_ error: Error)
}

enum ServiceParsingError: Error {
    case dataCorrupted
    case keyNotFound
    case valueNotFound
    case typeMismatch
    case generalError(_ error: Error)
    case inValidURL
}

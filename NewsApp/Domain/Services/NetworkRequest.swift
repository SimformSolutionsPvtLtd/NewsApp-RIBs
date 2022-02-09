//
//  NetworkRequest.swift
//  NewsApp
//
//  Created by Shilpesh Shah on 09/02/22.
//

import Foundation

enum RequestItemType {
    case newsFetch
}

protocol EndPointType {
    var baseURL:String { get }
    var version:String { get }
    var path:String { get }
    var url:String { get }
}

extension RequestItemType:EndPointType {
    var baseURL: String {
        return "https://newsapi.org/"
    }

    var version: String {
        return "v2/"
    }

    var path: String {
        switch self {
        case .newsFetch:
            return "top-headlines"
        }
    }

    var url: String {
        switch self {
        case .newsFetch:
            return  baseURL + version + path
        }
    }
}

struct APIConstant {
    struct RequestParameters {
        static var apiKey = "apiKey"
        static var country = "country"
        static var apiKeyValue = "bea1dbf8fb654682b56cc8d28ff282a1"
        static var countryValue = "us"
    }
}

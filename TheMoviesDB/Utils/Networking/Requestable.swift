//
//  Requestable.swift
//  TheMoviesDB
//
//  Created by Lang Troyan on 01/11/2020.
//

import Foundation
import Alamofire

enum Requestable: URLRequestConvertible {
    
    private struct Constants {
        static let apiKey: String = "c6aeee577586ba38e487b74dfede5deb"
        static let baseUrl: String = "https://api.themoviedb.org/3"
    }
    
    case getPopularTVShows(page: Int)
    case getGenres
    
    
    private var method: HTTPMethod {
        switch self {
        case .getPopularTVShows, .getGenres:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getPopularTVShows:
            return "/tv/popular"
        case .getGenres:
            return "/genre/tv/list"
        }
    }
    
    private var language: String {
        let currentDeviceLanguage = Locale.current.languageCode
        switch currentDeviceLanguage {
        case "es":
            return "es-ES"
        default:
            return "en-US"
        }
    }
    
    private var parameters: Parameters {
        var params: Parameters = [
            "api_key" : Constants.apiKey,
            "language" : language
        ]
        switch self {
        case .getPopularTVShows(let page):
            params["page"] = page
        default:
            break
        }
        return params
    }
    
    
    func asURLRequest() throws -> URLRequest {
        let baseUrl = try Constants.baseUrl.asURL()
        var urlRequest = URLRequest(url: baseUrl.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        let encodedUrlString = try URLEncoding.queryString.encode(urlRequest, with: parameters)
        
        #if DEBUG
        print("\nURL REQUEST:     \(encodedUrlString)")
        print("URL METHOD:      \(method)")
        print("URL PARAMETERS:  \(parameters)")
        #endif
        
        return encodedUrlString
    }
    
    
}

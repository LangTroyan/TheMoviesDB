//
//  NetworkManager.swift
//  TheMoviesDB
//
//  Created by Lang Troyan on 01/11/2020.
//

import Foundation
import Alamofire
import ObjectMapper

protocol NetworkProtocol {
    static func request<T: Mappable>(with requestable: Requestable, completion: @escaping (Result<T, Error>) -> Void)
}

class NetworkManager: NetworkProtocol {
    static func request<T>(with requestable: Requestable, completion: @escaping (Result<T, Error>) -> Void) where T : Mappable {
        do {
            try AF.request(requestable.asURLRequest()).responseJSON(completionHandler: { (response) in
                guard let data = response.data, response.error == nil else {
                    switch response.error {
                    case .sessionTaskFailed(_):
                        completion(.failure(NetworkError.noInternet))
                        return
                    default:
                        break
                    }
                    
                    switch response.error?.responseCode {
                    case 401:
                        completion(.failure(NetworkError.unauthorized))
                    case 404:
                        completion(.failure(NetworkError.notFound))
                    default:
                        completion(.failure(NetworkError.unknow))
                    }
                    return
                }
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any], let mappedResponse = T(JSON: json) {
                        completion(.success(mappedResponse))
                    }
                    else {
                        completion(.failure(NetworkError.unknow))
                    }
                }
                catch {
                    completion(.failure(NetworkError.unknow))
                }
            })
        }
        catch {
            completion(.failure(NetworkError.unknow))
        }
        
    }
}

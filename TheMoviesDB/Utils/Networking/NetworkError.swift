//
//  NetworkError.swift
//  TheMoviesDB
//
//  Created by Lang Troyan on 01/11/2020.
//

import Foundation

enum NetworkError: Error {
    case noInternet
    case unauthorized
    case notFound
    case unknow
}

//
//  BaseResponse.swift
//  TheMoviesDB
//
//  Created by Lang Troyan on 01/11/2020.
//

import Foundation
import ObjectMapper

class BaseResponse<T: Mappable>: Pagination {
    var results: [T]?
    
    required init?(map: Map) {
        super.init(map: map)
        results <- map["results"]
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        results <- map["results"]
    }
}

//
//  Pagination.swift
//  TheMoviesDB
//
//  Created by Lang Troyan on 01/11/2020.
//

import Foundation
import ObjectMapper

class Pagination: Mappable {
    
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    
    
    required init?(map: Map) {
        page <- map["pages"]
        totalResults <- map["total_results"]
        totalPages <- map["total_pages"]
    }
    
    init() {}
    
    convenience init(page: Int, totalResults: Int, totalPages: Int) {
        self.init()
        self.page = page
        self.totalResults = totalResults
        self.totalPages = totalPages
    }
    
    func mapping(map: Map) {
        page <- map["pages"]
        totalResults <- map["total_results"]
        totalPages <- map["total_pages"]
    }
    
    open class var firstPage: Int {
        return 1
    }
    
    var nextPage: Int? {
        guard let page = page, let totalPages = totalPages else { return nil }
        if page + 1 <= totalPages {
            return page + 1
        }
        else {
            return nil
        }
    }
}

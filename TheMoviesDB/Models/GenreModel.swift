//
//  GenreModel.swift
//  TheMoviesDB
//
//  Created by Lang Troyan on 01/11/2020.
//

import Foundation
import ObjectMapper
import CoreData

class Genres: Mappable {
    var genres: [Genre]?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        genres <- map["genres"]
    }
}

class Genre: NSManagedObject, Mappable {
    
    @NSManaged var id: NSNumber?
    @NSManaged var name: String?
    
    required init?(map: Map) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: String(describing: Genre.self), in: context)
        super.init(entity: entity!, insertInto: context)
        
        mapping(map: map)
    }
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        id <- map["id"]
    }
    
}

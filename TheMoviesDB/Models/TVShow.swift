//
//  TVShowModel.swift
//  TheMoviesDB
//
//  Created by Lang Troyan on 01/11/2020.
//

import Foundation
import ObjectMapper
import CoreData

class TVShow: NSManagedObject, Mappable {
    
    struct Constants {
        static let baseImagePath: String = "https://image.tmdb.org/t/p/w500"
    }
    
    @NSManaged var posterPath: String?
    @NSManaged var popularity: NSNumber?
    @NSManaged var id: NSNumber?
    @NSManaged var backdropPath: String?
    @NSManaged var voteAverage: NSNumber?
    @NSManaged var overview: String?
    @NSManaged var firstAirDate: String?
    @NSManaged var originCountry: [String]?
    @NSManaged var genreIds: [Int]?
    @NSManaged var originalLanguage: String?
    @NSManaged var voteCount: NSNumber?
    @NSManaged var title: String?
    @NSManaged var originalTitle: String?
    
    required init?(map: Map) {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: String(describing: TVShow.self), in: context)
        super.init(entity: entity!, insertInto: context)
        
        mapping(map: map)
    }
    
    convenience init() {
        self.init()
    }
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
    }
    
    func mapping(map: Map) {
        posterPath <- map["poster_path"]
        popularity <- map["popularity"]
        id <- map["id"]
        backdropPath <- map["backdrop_path"]
        voteAverage <- map["vote_average"]
        overview <- map["overview"]
        firstAirDate <- map["first_air_date"]
        originCountry <- map["origin_country"]
        genreIds <- map["genre_ids"]
        originalLanguage <- map["original_language"]
        voteCount <- map["vote_count"]
        title <- map["name"]
        originalTitle <- map["original_name"]
    }

}

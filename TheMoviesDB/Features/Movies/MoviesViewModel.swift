//
//  MoviesViewModel.swift
//  TheMoviesDB
//
//  Created by Lang Troyan on 02/11/2020.
//

import Foundation
import CoreData

class MoviesViewModel {
    
    var movies: [TVShow]?
    var pagination: Pagination?
    
    init(completion: ((Error?) -> Void)? = nil) {
        if let movies: [TVShow] = PersistenceManager.fetch(from: String(describing: TVShow.self)), movies.count > 0 {
            self.movies = movies
        }
        else {
            loadMovies(in: Pagination.firstPage, completion: completion)
        }
    }
    
    func getMoviesCount() -> Int {
        return movies?.count ?? 0
    }
    
    func getCurrentPage() -> Int {
        return pagination?.page ?? Pagination.firstPage
    }
    
    func hasNextPage() -> Bool {
        guard let pagination = pagination else  { return true }
        return pagination.nextPage != nil
    }
    
    func loadNextPage(completion: ((Error?) -> Void)? = nil) {
        guard hasNextPage() else { return }
        loadMovies(in: pagination?.nextPage ?? (getMoviesCount() / 20) + 1, completion: completion)
    }
    
    func getMovie(for indexPath: IndexPath) -> TVShow? {
        guard let movies = movies, indexPath.row < movies.count else { return nil }
        return movies[indexPath.row]
    }
    
    func loadMovies(in page: Int, completion: ((Error?) -> Void)? = nil) {
        NetworkManager.request(with: .getPopularTVShows(page: page)) { (response: Result<BaseResponse<TVShow>, Error>) in
            switch response {
            case .success(let baseResponse):
                if let page = baseResponse.page, let totalResults = baseResponse.totalResults, let totalPages = baseResponse.totalPages {
                    PersistenceManager.save()
                    self.pagination = Pagination(page: page, totalResults: totalResults, totalPages: totalPages)
                }
                if self.movies == nil {
                    self.movies = [TVShow]()
                }
                if let tvShows = baseResponse.results {
                    self.movies?.append(contentsOf: tvShows)
                }
                completion?(nil)
            case .failure(let error):
                switch error {
                case NetworkError.unauthorized, NetworkError.notFound:
                    completion?(error)
                default:
                    completion?(error)
                }
            }
        }
    }
}

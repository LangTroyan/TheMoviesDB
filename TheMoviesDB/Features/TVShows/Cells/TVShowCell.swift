//
//  MovieCell.swift
//  TheMoviesDB
//
//  Created by Lang Troyan on 01/11/2020.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    
    struct Constants {
        static let identifier = "movieCell"
    }
    
    var movie: TVShow? {
        didSet {
            if let posterPath = movie?.posterPath,
               let imageUrl = URL(string: TVShow.Constants.baseImagePath + posterPath) {
                posterImageView.kf.setImage(with: imageUrl)
            }
            titleLabel.text = movie?.title
            genreLabel.text = "\(movie?.genreIds?.first ?? 0)"
            averageLabel.text = "\(movie?.voteAverage ?? 0)"
        }
    }
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
}

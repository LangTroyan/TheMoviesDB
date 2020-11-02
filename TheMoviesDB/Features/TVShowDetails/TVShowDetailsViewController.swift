//
//  MovieDetailsViewController.swift
//  TheMoviesDB
//
//  Created by Lang Troyan on 01/11/2020.
//

import UIKit
import Alamofire
import Kingfisher

class TVShowDetailsViewController: BaseViewController {

    // MARK: - Properties -
    
    var tvshow: TVShow?
    
    // MARK: Outlets
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var originalTitleValueLabel: UILabel!
    @IBOutlet weak var originalLanguageLabel: UILabel!
    @IBOutlet weak var originalLanguageValueLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var firstAirdateLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    
    // MARK: Public
    // MARK: Private

    // MARK: - Inits -
    
    // MARK: - Methods -
    
    // MARK: Public
    // MARK: Private
    
    // MARK: - UIViewController -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let tvshow = tvshow else {
            return
        }
        if let backdropPath = tvshow.backdropPath,
           let imageUrl = URL(string: TVShow.Constants.baseImagePath + backdropPath) {
            backdropImageView.kf.setImage(with: imageUrl)
        }
        
        titleLabel.text = tvshow.title
        originalTitleLabel.text = LocalizableKeys.tvshowOriginalTitleLabel.localized
        originalTitleValueLabel.text = tvshow.originalTitle
        originalLanguageLabel.text = LocalizableKeys.tvshowOriginalLanguageLabel.localized
        originalLanguageValueLabel.text = tvshow.originalLanguage
        overviewLabel.text = tvshow.overview
        firstAirdateLabel.text = tvshow.firstAirDate
        voteAverageLabel.text = "\(tvshow.voteAverage ?? 0) / 10"
        
    }


}

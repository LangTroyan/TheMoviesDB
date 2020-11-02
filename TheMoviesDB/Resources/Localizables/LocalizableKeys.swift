//
//  LocalizableKeys.swift
//  TheMoviesDB
//
//  Created by Lang Troyan on 01/11/2020.
//

import Foundation

enum LocalizableKeys: String {
    
    var localized: String {
        get {
            return self.rawValue.localized
        }
    }
    
    case yes
    case no
    case ok
    case error
    case defaultErrorMessage = "default_error_message"
    
    case tvshowOriginalTitleLabel = "tvshow_original_title_label"
    case tvshowOriginalLanguageLabel = "tvshow_original_language_label"
}

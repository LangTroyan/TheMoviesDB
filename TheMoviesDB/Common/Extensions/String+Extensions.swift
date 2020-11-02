//
//  String+Extensions.swift
//  TheMoviesDB
//
//  Created by Dylan Trujillo on 02/11/2020.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

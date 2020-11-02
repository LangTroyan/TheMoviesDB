//
//  String+Extensions.swift
//  TheMoviesDB
//
//  Created by Dylan Trujillo on 02/11/2020.
//

import UIKit

extension String {
    var localized: String {
        get {
            return NSLocalizedString(self, comment: "")
        }
    }
}

//
//  UIViewController+Extensions.swift
//  TheMoviesDB
//
//  Created by Dylan Trujillo on 02/11/2020.
//

import UIKit

extension UIViewController {
    static func instantiate(from storyboard: UIStoryboard? = nil) -> Self? {
        guard let storyboard = storyboard else {
            return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: Self.self)) as? Self
        }
        return storyboard.instantiateViewController(withIdentifier: String(describing: Self.self)) as? Self
    }
}

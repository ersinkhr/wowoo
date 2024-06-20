//
//  UIImageView+Extensions.swift
//  MoviesDB
//
//  Created by Ersin Kahraman on 20.06.2024.
//

import UIKit
import Kingfisher

extension UIImageView {
    func load(from urlString: String,
              didFailWithError: @escaping () -> Void = {}) {
        if let url: URL = URL(string: urlString) {
            kf.setImage(with: url) { result in
                switch result {
                case .success:
                    return
                case .failure:
                    didFailWithError()
                }
            }
        }
    }
}

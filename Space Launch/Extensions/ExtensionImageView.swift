//
//  ExtensionImageView.swift
//  Space Launch
//
//  Created by Alcides Junior on 18/10/18.
//  Copyright © 2018 Alcides Junior. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        var loading = UIActivityIndicatorView(style: .white)
        self.spinner(loading)
        loading.startAnimating()
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                    self.image = image
                
                loading.stopAnimating()
            }
            }.resume()
    }
    func downloadedFrom(link: String?, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        if let link = link {
            guard let url = URL(string: link) else { return }
            downloadedFrom(url: url, contentMode: mode)
        }
    }
}

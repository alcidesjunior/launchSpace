//
//  ExtensionImageView.swift
//  Space Launch WatchKit Extension
//
//  Created by Alcides Junior on 22/10/18.
//  Copyright © 2018 Alcides Junior. All rights reserved.
//
import Foundation
import WatchKit

extension WKInterfaceImage {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
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

//
//  MissionsTableViewCell.swift
//  Space Launch
//
//  Created by Alcides Junior on 17/10/18.
//  Copyright © 2018 Alcides Junior. All rights reserved.
//

import UIKit

class MissionsTableViewCell: UITableViewCell {

    @IBOutlet weak private var imgDetailsMission: UIImageView!
    @IBOutlet weak private var missionName: UILabel!
    @IBOutlet weak private var missionYear: UILabel!
    var mission : MissionStruct? {
        didSet {
            if mission != nil {
                self.updateView()
            }
        }
    }
    
    private func updateView() {
        missionName.text = mission?.missionName
        missionYear.text = mission?.launchYear
        imgDetailsMission.downloadedFrom(link: mission?.links?.missionPatchSmall)
//        if let url1 = mission?.links?.missionPatchSmall{
//            if let url2 = URL(string: ( (url1) )){
//                MissionsAPI.sharedInstance.getData(from:  url2) { data, response, error in
//                    guard let data = data, error == nil else { return }
//                    DispatchQueue.main.async() {
//                        self.imgDetailsMission.image = UIImage(data: data)
//                    }
//                }
//            }
//        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}


extension UIImageView {
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

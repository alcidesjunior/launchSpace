//
//  RocketViewController.swift
//  Space Launch
//
//  Created by Alcides Junior on 19/10/18.
//  Copyright © 2018 Alcides Junior. All rights reserved.
//

import UIKit

class RocketViewController: UIViewController {
    var delegateRocket: MissionStruct?
    @IBOutlet weak var rocketImage: UIImageView!{
        didSet{
            if let urlImg = self.delegateRocket?.links?.flickrImages{
                if urlImg.count>0{
                    self.rocketImage.downloadedFrom(link: urlImg[0])
                }else{
                    self.rocketImage.image = UIImage(named: "noimage")
                }
            }
        }
    }
    @IBOutlet weak var rocketTableView: UITableView!{
        didSet{
            rocketTableView.rowHeight = 70
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rocketTableView.delegate = self
        self.rocketTableView.dataSource = self
        self.title = self.delegateRocket?.rocket?.rocketName
    }

}
extension RocketViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = rocketTableView.dequeueReusableCell(withIdentifier: "RocketCellid") as? RocketTableViewCell
        switch indexPath.row {
        case 0:
            cell?.labelTitle.text = "Rocket name"
            cell?.labelSubtitle.text = self.delegateRocket?.rocket?.rocketName
        case 1:
            cell?.labelTitle.text = "Rocket type"
            cell?.labelSubtitle.text = self.delegateRocket?.rocket?.rocketType
        case 2:
            cell?.labelTitle.text = "Core serial"
            cell?.labelSubtitle.text = self.delegateRocket?.rocket?.firstStage?.cores[0]?.coreSerial
        case 3:
            cell?.labelTitle.text = "Reused"
            if let isReused = self.delegateRocket?.rocket?.firstStage?.cores[0]?.reused{
                cell?.labelSubtitle.text = ((isReused) ? "Yes" : "No")
            }
        case 4:
            cell?.labelTitle.text = "Nationality"
            cell?.labelSubtitle.text = self.delegateRocket?.rocket?.secondStage?.payloads[0]?.nationality
        case 5:
            cell?.labelTitle.text = "Manufacturer"
            cell?.labelSubtitle.text = self.delegateRocket?.rocket?.secondStage?.payloads[0]?.manufacturer
        case 6:
            cell?.labelTitle.text = "Payload type"
            cell?.labelSubtitle.text = self.delegateRocket?.rocket?.secondStage?.payloads[0]?.payloadType
        default:
            cell?.labelTitle.text = ""
        }
        return cell!
    }
    
    
}

//
//  MissionDetailsViewController.swift
//  Space Launch
//
//  Created by Alcides Junior on 18/10/18.
//  Copyright © 2018 Alcides Junior. All rights reserved.
//

import UIKit

class MissionDetailsViewController: UIViewController {

    var delegateMission: MissionDelegate?
    @IBOutlet weak var missionImage: UIImageView!
    @IBOutlet weak var missionDetailsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.delegateMission?.getMission().missionName
        self.missionImage.downloadedFrom(link: self.delegateMission?.getMission().links?.missionPatch)
        missionDetailsTableView.delegate = self
        missionDetailsTableView.dataSource = self
        missionDetailsTableView.rowHeight = 70
    }

}
//detailsMissionCellID
extension MissionDetailsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = missionDetailsTableView.dequeueReusableCell(withIdentifier: "detailsMissionCellID") as! MissionDetailsTableViewCell
        switch indexPath.row {
        case 0:
            let date = Date(timeIntervalSince1970: Double((self.delegateMission?.getMission().launchDateUnix)!))
            let dateFormatter = DateFormatter()
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            dateFormatter.locale = NSLocale.current
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let launchDate = dateFormatter.string(from: date)
            
            cell.labelTitle.text = "Launch date"
            cell.labelSubTitlte.text = launchDate
            
        case 1:
            cell.labelTitle.text = "Max tentative precision"
            cell.labelSubTitlte.text = self.delegateMission?.getMission().tentativeMaxPrecision
        case 2:
            cell.labelTitle.text = "Launch success"
            cell.labelSubTitlte.text = (self.delegateMission?.getMission().launchSuccess==true ? "Yes" : "No")
        case 3:
            cell.labelTitle.text = "Details"
            cell.labelSubTitlte.text = self.delegateMission?.getMission().details
        case 4:
            cell.labelTitle.text = "About Rocket"
            cell.labelSubTitlte.text = ""
            cell.accessoryType = .disclosureIndicator
        default:
            0
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item == 4{
            print("linha certa", self.delegateMission?.getMission().rocket?.rocketID)
        }
    }

}

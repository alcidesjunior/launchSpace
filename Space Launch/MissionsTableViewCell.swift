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
    var searchWasActivate : Bool = false
    var filteredMission : MissionStruct?{
        didSet{
            if filteredMission != nil{
                self.updateView()
            }
        }
    }
    var mission : MissionStruct? {
        didSet {
            if mission != nil {
                self.updateView()
            }
        }
    }
    
    private func updateView() {
        if searchWasActivate {
            missionName.text = filteredMission?.missionName
            missionYear.text = filteredMission?.launchYear
            imgDetailsMission.downloadedFrom(link: filteredMission?.links?.missionPatchSmall)
        }else{
            missionName.text = mission?.missionName
            missionYear.text = mission?.launchYear
            imgDetailsMission.downloadedFrom(link: mission?.links?.missionPatchSmall)
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}




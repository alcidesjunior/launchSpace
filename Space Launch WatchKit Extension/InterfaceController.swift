//
//  InterfaceController.swift
//  Space Launch WatchKit Extension
//
//  Created by Alcides Junior on 17/10/18.
//  Copyright © 2018 Alcides Junior. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var missionTableView: WKInterfaceTable!
    var missions : [MissionStruct] = []
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        MissionsAPI.sharedInstance.getMissions(completion: { missionsJson in
            self.missions = missionsJson
            self.loadTable()
        })
        self.loadTable()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    private func loadTable(){
        self.missionTableView.setNumberOfRows(self.missions.count, withRowType: "MissionRow")
        
        for(index, rowModel) in self.missions.enumerated(){
            if let rowController = missionTableView.rowController(at: index) as? MissionRowController{
                rowController.labelMission.setText(rowModel.missionName)
            }
        }
    }

}

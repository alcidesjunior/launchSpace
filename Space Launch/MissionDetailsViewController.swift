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
        // Do any additional setup after loading the view.
    }

}
extension MissionDetailsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

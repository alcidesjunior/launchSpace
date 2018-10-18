//
//  ViewController.swift
//  Space Launch
//
//  Created by Alcides Junior on 17/10/18.
//  Copyright © 2018 Alcides Junior. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var loading = UIActivityIndicatorView(style: .gray)
    var missions: [MissionStruct] = []
    var selectedMission: MissionStruct?
    @IBOutlet weak var missionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        missionTableView.delegate = self
        missionTableView.dataSource = self
        missionTableView.rowHeight = 70
        self.spinner()
        self.loading.startAnimating()
        MissionsAPI.sharedInstance.getMissions(completion: { missionsJson in
            self.missions = missionsJson
            self.missionTableView.reloadData()
            self.loading.stopAnimating()
        })
    }
    func spinner(){
        loading.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loading)
        loading.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loading.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource, MissionDelegate{
    func getMission() -> MissionStruct {
        return self.selectedMission!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.missions.count)
        return self.missions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = missionTableView.dequeueReusableCell(withIdentifier: "missionCellID") as! MissionsTableViewCell
        cell.mission = missions[indexPath.row]

        
//        if let url1 = currentMission.links?.missionPatchSmall{
//            if let url2 = URL(string: ( (url1) )){
//                MissionsAPI.sharedInstance.getData(from:  url2) { data, response, error in
//                    guard let data = data, error == nil else { return }
////                    print("Download Finished")
//                    
//                    DispatchQueue.main.async() {
//                        cell.imgDetailsMission.image = UIImage(data: data)
//                    }
//                }
//            }
//        }
        
//        cell.missionName.text = currentMission.missionName
//        cell.missionYear.text = currentMission.launchYear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedMission = self.missions[indexPath.item]
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "MissionDetails") as? MissionDetailsViewController else {return}
        controller.delegateMission = self
        navigationController?.pushViewController(controller, animated: true)
        
//        performSegue(withIdentifier: "missionDetailsSegue", sender: nil)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let destination = segue.destination as? MissionDetailsViewController else {return}
//        destination.delegateMission = self
//
//    }
}


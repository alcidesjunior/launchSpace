//
//  ViewController.swift
//  Space Launch
//
//  Created by Alcides Junior on 17/10/18.
//  Copyright © 2018 Alcides Junior. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBarMission: UISearchBar!
    var loading = UIActivityIndicatorView(style: .gray)
    var missions: [MissionStruct] = []
    var selectedMission: MissionStruct?
    var searchActive : Bool = false
    var filtered:[MissionStruct] = []
    
    @IBOutlet weak var missionTableView: UITableView!{
        didSet{
          missionTableView.rowHeight = 70
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        missionTableView.delegate = self
        missionTableView.dataSource = self
        searchBarMission.delegate = self
        
        self.view.spinner(loading)
        self.loading.startAnimating()
        
        MissionsAPI.sharedInstance.getMissions(completion: { missionsJson in
            self.missions = missionsJson
            self.missionTableView.reloadData()
            self.loading.stopAnimating()
        })
        self.searchBarMission.endEditing(true)
    }
    
    
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource, MissionDelegate{
    func getMission() -> MissionStruct {
        return self.selectedMission!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return self.filtered.count
        }
    
        return self.missions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = missionTableView.dequeueReusableCell(withIdentifier: "missionCellID") as! MissionsTableViewCell
        cell.searchWasActivate = searchActive
        if searchActive{
            cell.filteredMission = self.filtered[indexPath.row]
        }else{
            cell.mission = missions[indexPath.row]
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
        if self.searchActive == true{
            print("SELECTED==========")
            self.selectedMission = self.filtered[indexPath.item]
        }else{
            print("putz===============")
            self.selectedMission = self.missions[indexPath.item]
        }

        guard let controller = storyboard?.instantiateViewController(withIdentifier: "MissionDetails") as? MissionDetailsViewController else {return}
        controller.delegateMission = self

        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filtered = missions.filter({ (text) -> Bool in
            return text.missionName!.range(of: searchText, options: [ .caseInsensitive]) != nil
        })
        self.searchActive = !self.filtered.isEmpty
        print(searchActive)
        self.missionTableView.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchActive = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        self.searchActive = false
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        self.searchActive = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchActive = false
    }
    
}

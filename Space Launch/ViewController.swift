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
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        missionTableView.delegate = self
        missionTableView.dataSource = self
        searchBarMission.delegate = self
        
        self.spinner()
        self.loading.startAnimating()
        MissionsAPI.sharedInstance.getMissions(completion: { missionsJson in
            self.missions = missionsJson
            self.missionTableView.reloadData()
            self.loading.stopAnimating()
        })
        
        
        
    }
    func addTap(){
        print("adicionou===========")
        view.addGestureRecognizer(self.tap)
    }
    func removeTap(){
        print("==========removeu")
        view.removeGestureRecognizer(self.tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
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
        if searchActive{
            self.selectedMission = self.filtered[indexPath.item]
        }else{
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
        searchActive = !self.filtered.isEmpty
        self.missionTableView.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
}

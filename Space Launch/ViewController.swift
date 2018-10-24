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
        registerForPreviewing(with: self, sourceView: missionTableView)
        
        MissionsAPI.sharedInstance.getMissions(completion: { missionsJson in
            self.missions = missionsJson
            self.missionTableView.reloadData()
            self.loading.stopAnimating()
        })
        self.searchBarMission.endEditing(true)
    }

    override func viewDidAppear(_ animated: Bool) {
        
        if !CheckInternet.Connection(){
            
            self.Alert(Message: "Your Device is not connected with internet")
            
        }
        
    }
    
    func Alert (Message: String){
        
        let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: {(alert: UIAlertAction!) in
            exit(1)
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, MissionDelegate, UIViewControllerPreviewingDelegate{
    
    
    
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
    
    private func createDetailViewControllerIndexPath(indexPath: IndexPath) -> MissionDetailsViewController {
        let text = missions[indexPath.row]
        
        let controller = storyboard?.instantiateViewController(withIdentifier: "MissionDetails") as? MissionDetailsViewController
        if self.searchActive == true{
            print("SELECTED==========")
            self.selectedMission = self.filtered[indexPath.item]
        }else{
            print("putz===============")
            self.selectedMission = text
        }
        controller!.delegateMission = self
        
        return controller!
        
        
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = missionTableView.indexPathForRow(at: location) else {
            return nil
        }
        let detailViewController = createDetailViewControllerIndexPath(indexPath: indexPath)
        
        return detailViewController
    }
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        navigationController?.pushViewController(viewControllerToCommit, animated: true)
    }
    
}
//para esconder o teclado quando o usuário pesquisar e escrolar a tela
extension ViewController : UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
//lógica para procurar uma palavra em uma tableview
extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filtered = missions.filter({ (text) -> Bool in
            return text.missionName!.range(of: searchText, options: [ .caseInsensitive]) != nil
        })
        self.searchActive = !self.filtered.isEmpty
        print(searchActive)
        self.missionTableView.reloadData()
    }
}

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
    var loading = UIActivityIndicatorView(style: .gray)
    @IBOutlet weak var missionDetailsTableView: UITableView!{
        didSet{
            missionDetailsTableView.rowHeight = 70
        }
    }
    
    var selectedRocket: MissionStruct?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.delegateMission?.getMission().missionName
        if let missionImgUrl = self.delegateMission?.getMission().links?.missionPatch{
            self.missionImage.downloadedFrom(link: missionImgUrl)
        }else{
            self.missionImage.image = UIImage(named: "noimage")
        }
        missionDetailsTableView.delegate = self
        missionDetailsTableView.dataSource = self
//        register for use in peek and pop
        if traitCollection.forceTouchCapability == .available{
            registerForPreviewing(with: self, sourceView: view)
        }else{
            print("3D Touch Not Available")
        }
    }

}
extension MissionDetailsViewController : UIViewControllerPreviewingDelegate{

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let convertedLocation = view.convert(location, to: missionImage)
        
        
        
        if missionImage.bounds.contains(convertedLocation){
            let peekView =  self.storyboard?.instantiateViewController(withIdentifier: "PeekvcID") as? PeekViewController
            if let currentImage = missionImage{
                if let peek = peekView{
                    peek.image = currentImage.image
                    peek.label = self.delegateMission?.getMission().missionName
                }
            }
            
            peekView?.preferredContentSize = CGSize(width: 300, height: 300)
            previewingContext.sourceRect = missionImage.frame
            
            return peekView
        }else{
            return nil
        }
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        //present(viewControllerToCommit,animated: true)
        //usar push para
       // navigationController?.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }
    
}
//CONFIGURACOES DE TABLEVIEW
extension MissionDetailsViewController: UITableViewDelegate,UITableViewDataSource,RocketDelegate{
    func getRocketId() -> MissionStruct {
        return self.selectedRocket!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = missionDetailsTableView.dequeueReusableCell(withIdentifier: "detailsMissionCellID") as! MissionDetailsTableViewCell
        cell.labelSubTitlte.numberOfLines = 0
        cell.labelSubTitlte.lineBreakMode = .byWordWrapping
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
            cell.labelTitle.text = "Launch Site"
            cell.labelSubTitlte.text = self.delegateMission?.getMission().launchSite?.siteNameLong
        case 2:
            cell.labelTitle.text = "Launch success"
            cell.labelSubTitlte.text = (self.delegateMission?.getMission().launchSuccess==true ? "Yes" : "No")
        case 4:
            cell.labelTitle.text = "Details"
            if let missionDetail = self.delegateMission?.getMission().details {
                cell.labelSubTitlte.text = missionDetail
                
            }else{
                cell.labelSubTitlte.text = "Don't have details."
            }
        case 3:
            cell.labelTitle.text = "Customer"
            cell.labelSubTitlte.text = self.delegateMission?.getMission().rocket?.secondStage?.payloads.first??.customers.first as? String
        case 5:
            cell.labelTitle.text = "About Rocket"
            cell.labelSubTitlte.text = ""
            cell.accessoryType = .disclosureIndicator
        default:
            cell.labelSubTitlte.text = "Vazio???"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item == 5{
            self.selectedRocket = self.delegateMission?.getMission()
            guard let RocketController = storyboard?.instantiateViewController(withIdentifier: "RocketViewController") as? RocketViewController else {return}
            RocketController.delegateRocket = self.selectedRocket
            navigationController?.pushViewController(RocketController, animated: true)
            
        }
    }
    

}

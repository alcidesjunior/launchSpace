//
//  MissionsAPI.swift
//  Space Launch
//
//  Created by Alcides Junior on 17/10/18.
//  Copyright © 2018 Alcides Junior. All rights reserved.
//

import Foundation

public class MissionsAPI: NSObject{
    public static let sharedInstance = MissionsAPI()
    let url:String?
    
    private override init(){
       self.url = "https://api.spacexdata.com/v3/launches"
    }
    
  
    /// Funcao que faz o get de todas as missions
//    func getMissions(){
//        let urlPath = URL(string: self.url!)!
//        var request = URLRequest(url: urlPath)
//        request.httpMethod = "GET"
//        
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            guard let data = data, error == nil else {return}
//            
//            do{
//                let jsonDec = JSONDecoder()
//                //let missions = try jsonDec.decode([MissionStruct.self], from: data)
//                return missions
//                //completion(missions)
//            }catch _ as NSError{
//                //completion(nil)
//                return nil
//            }
//            
//        }.resume()
//    }
    func getMissions(completion: @escaping([MissionStruct])->(Void)){
        let urlPath = URL(string: self.url!)!
        var request = URLRequest(url: urlPath)
        request.httpMethod = "GET"
  
        let getTask = URLSession.shared.dataTask(with: request){ (data,response,error) in
            if error != nil {print("error request")}
            if data != nil {
                
                do{
                    let result = try JSONSerialization.jsonObject(with: data!, options: [])
                    let responseData = try JSONSerialization.data(withJSONObject: result, options: .prettyPrinted)
                    let missions = try JSONDecoder().decode([MissionStruct].self, from: responseData)

                    DispatchQueue.main.async {
                        completion(missions)
                    }
                    
                }catch let jsonError{
                    DispatchQueue.main.async {
                        print("caiu no catch \(jsonError)")
                    }
                }
            }
        }
        DispatchQueue.global(qos: .background).async{
            getTask.resume()
        }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}

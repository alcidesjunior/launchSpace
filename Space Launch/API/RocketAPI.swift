//
//  RocketAPI.swift
//  Space Launch
//
//  Created by Alcides Junior on 19/10/18.
//  Copyright © 2018 Alcides Junior. All rights reserved.
//

import Foundation
public class RocketAPI: NSObject{
    public static let sharedInstance = RocketAPI()
    var url: String?
    
    private override init(){}
    
    func getMissions(id: String,completion: @escaping([MissionStruct])->(Void)){
        self.url = "https://api.spacexdata.com/v3/rockets/\(id)"
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
}

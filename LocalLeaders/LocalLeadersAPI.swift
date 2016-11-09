//
//  LocalLeadersAPI.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 09/11/2016.
//  Copyright © 2016 MAV. All rights reserved.
//

import Foundation
import Alamofire

let GET_MLAS_JSON = "https://localleaders.herokuapp.com/leaders/mlas/"

open class LocalLeadersAPI : NSObject
{
    static func getMlasJSON()
    {
        LocalLeadersAPI.get(GET_MLAS_JSON) { (result : Any?) in
            print(result!)
        }
    }
    
    static func get(_ url: String, completion: @escaping (_ result : Any?) -> Void)
    {
        Alamofire.request(url).validate().responseJSON { response in
            switch response.result
            {
                case .success:
                    print("Successful GET request")
                    if let JSON = response.result.value {
                        completion(JSON)
                    }
                    break
                
                case .failure(let error):
                    print("GET request failed")
                    print(error)
                    break
            }
        }
    }
}
//
//  LocalLeadersAPI.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 09/11/2016.
//  Copyright © 2016 MAV. All rights reserved.
//

import Foundation
import Alamofire

let GET_MLAS_JSON = "https://vincetestaccount.herokuapp.com/leaders/mlas/"

open class LocalLeadersAPI: NSObject
{
    static func getMlasJSON()
    {
        LocalLeadersAPI.get(GET_MLAS_JSON) { (result: Dictionary<String, AnyObject>?) in
            if let result = result, let response = result["response"] as? [AnyObject] {
                ParserUtils.getMlasFromArray(response)
            }
        }
    }

    static func get(_ url: String, completion: @escaping (_ result: Dictionary<String, AnyObject>?) -> Void)
    {
        DispatchQueue.global().async {
            Alamofire.request(url).validate().responseJSON { response in
                switch response.result
                {
                case .success:
                    log.debug("Successful GET request")
                    if let JSON = response.result.value as? [String: AnyObject] {
                        completion(JSON)
                    }
                    break

                case let .failure(error):
                    log.error("GET request failed")
                    log.error(error)
                    break
                }
            }
        }
    }
}


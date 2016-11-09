//
//  LeaderRecord.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 09/11/2016.
//  Copyright © 2016 MAV. All rights reserved.
//

import Foundation
import RealmSwift

open class LeaderRecord : BaseRealmObject
{
    // MARK: Leader object properties
    dynamic var key : String? // key = The MLA Personal ID
    dynamic var firstname : String?
    dynamic var lastName : String?
    dynamic var imageURL : String?
    dynamic var partyAbbreviation : String?
    dynamic var partyName : String?
    dynamic var title : String?
    dynamic var twitterHandle : String?
    dynamic var emailAddress : String?
    dynamic var constituency : String?
    
    // MARK: Overriding the realm type to return.
    override class func realmType() throws -> Object.Type {
        return LeaderRecord.self
    }
    
    // MARK: Creating objects
    static func fetchOrCreate(dictionary : Dictionary<String, String> , key : String) -> LeaderRecord
    {
        let fetchedLeader : LeaderRecord? = BaseRealmObject.baseRealm().objects(LeaderRecord.self).filter("key = %@",key).first
        if (fetchedLeader == nil)
        {
            let newLeader = LeaderRecord()
            newLeader.key = dictionary["key"]
            newLeader.firstname = dictionary["firstName"]
            newLeader.lastName = dictionary["lastName"]
            newLeader.imageURL = dictionary["imageURL"]
            newLeader.partyAbbreviation = dictionary["partyAbbreviation"]
            newLeader.partyName = dictionary["partyName"]
            newLeader.title = dictionary["title"]
            newLeader.twitterHandle = dictionary["twitterHandle"]
            newLeader.emailAddress = dictionary["emailAddress"]
            newLeader.constituency = dictionary["constituency"]
            return newLeader
        }
        
        return fetchedLeader!
    }
    
    // MARK: Helper methods
    func updateTwitterHandle(_ handle : String)
    {
        try! BaseRealmObject.baseRealm().write({
            self.twitterHandle = handle
        })
    }
}

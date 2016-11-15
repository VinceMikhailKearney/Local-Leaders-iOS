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
    static func create(dictionary : Dictionary<String, AnyObject>) -> LeaderRecord!
    {
        let key : String = String((dictionary["MemberPersonId"] as! Int))
        let fetchedLeader : LeaderRecord? = BaseRealmObject.baseRealm().objects(LeaderRecord.self).filter("key == %@",key).first
        if (fetchedLeader == nil)
        {
            let newLeader = LeaderRecord()
            newLeader.key = key
            newLeader.firstname = dictionary["MemberFirstName"] as? String
            newLeader.lastName = dictionary["MemberLastName"] as? String
            newLeader.imageURL = dictionary["MemberImgUrl"] as? String
            newLeader.partyAbbreviation = dictionary["PartyAbbreviation"] as? String
            newLeader.partyName = dictionary["PartyName"] as? String
            newLeader.title = dictionary["MemberTitle"] as? String
            newLeader.twitterHandle = ""
            newLeader.emailAddress = ""
            newLeader.constituency = dictionary["ConstituencyName"] as? String
            
            return newLeader
        }
        
        return fetchedLeader!
    }
    
    func updateTwitterHandle(_ handle : String)
    {
        try! BaseRealmObject.baseRealm().write({
            self.twitterHandle = handle
        })
    }
    
    func updateEmailAddress(_ email : String)
    {
        try! BaseRealmObject.baseRealm().write({
            self.emailAddress = email
        })
    }
    
    static func fetchLeadersInConstituency(_ constituency : String) -> Array<LeaderRecord> {
        return Array(baseRealm().objects(try! realmType()).filter("constituency == %@", constituency)) as! Array<LeaderRecord>
    }
}

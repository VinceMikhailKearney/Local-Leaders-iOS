//
//  LeaderRecord.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 09/11/2016.
//  Copyright © 2016 MAV. All rights reserved.
//

import Foundation
import RealmSwift

open class LeaderRecord: BaseRealmObject
{
    // MARK: Leader object properties
    dynamic var key: String? // key = The MLA Personal ID
    dynamic var firstname: String?
    dynamic var lastName: String?
    dynamic var imageURL: String?
    dynamic var partyAbbreviation: String?
    dynamic var partyName: String?
    dynamic var title: String?
    dynamic var twitterHandle: String?
    dynamic var emailAddress: String?
    dynamic var constituency: String?

    // MARK: Overriding the realm type to return.
    override class func realmType() throws -> Object.Type {
        return LeaderRecord.self
    }

    // MARK: Creating objects
    static func create(dictionary: Dictionary<String, AnyObject>) -> LeaderRecord!
    {
        let key: String = String((dictionary["key"] as! Int))
        let fetchedLeader: LeaderRecord? = BaseRealmObject.baseRealm().objects(LeaderRecord.self).filter("key == %@", key).first
        if fetchedLeader == nil
        {
            let newLeader = LeaderRecord()
            newLeader.key = key
            newLeader.firstname = dictionary["firstName"] as? String
            newLeader.lastName = dictionary["lastName"] as? String
            newLeader.imageURL = dictionary["imageURL"] as? String
            newLeader.partyAbbreviation = dictionary["party"] as? String
            newLeader.partyName = dictionary["partyName"] as? String
            newLeader.title = dictionary["title"] as? String
            newLeader.twitterHandle = dictionary["twitter"] as? String
            newLeader.emailAddress = dictionary["email"] as? String
            newLeader.constituency = dictionary["constituency"] as? String

            return newLeader
        }

        return fetchedLeader!
    }

    func updateTwitterHandle(_ handle: String)
    {
        try! BaseRealmObject.baseRealm().write({
            self.twitterHandle = handle
        })
    }

    func updateEmailAddress(_ email: String)
    {
        try! BaseRealmObject.baseRealm().write({
            self.emailAddress = email
        })
    }

    static func fetchLeadersInConstituency(_ constituency: String) -> Array<LeaderRecord> {
        return Array(baseRealm().objects(try! realmType()).filter("constituency == %@", constituency)) as! Array<LeaderRecord>
    }
}


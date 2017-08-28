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
    dynamic var key: String = "" // key = The MLA Personal ID
    dynamic var firstname: String = ""
    dynamic var lastName: String = ""
    dynamic var imageURL: String = ""
    dynamic var partyAbbreviation: String = ""
    dynamic var partyName: String = ""
    dynamic var title: String = ""
    dynamic var twitterHandle: String = ""
    dynamic var emailAddress: String = ""
    dynamic var constituency: String = ""

    // MARK: Overriding the realm type to return.
    override class func realmType() throws -> Object.Type {
        return LeaderRecord.self
    }

    // MARK: Creating objects
    static func create(_ dictionary: [String: AnyObject]) -> LeaderRecord?
    {
        guard let keyInt = dictionary["key"] as? Int else { return nil }
        let key = String(keyInt)
        let fetchedLeader = BaseRealmObject.baseRealm().objects(LeaderRecord.self).filter("key == %@", key).first
        if fetchedLeader == nil
        {
            let newLeader = LeaderRecord()
            newLeader.key = key
            guard let firstName = dictionary["firstName"] as? String else { return nil }
            newLeader.firstname = firstName
            guard let lastName = dictionary["lastName"] as? String else { return nil }
            newLeader.lastName = lastName
            guard let imageURL = dictionary["imageURL"] as? String else { return nil }
            newLeader.imageURL = imageURL
            guard let partyAbbreviation = dictionary["party"] as? String else { return nil }
            newLeader.partyAbbreviation = partyAbbreviation
            guard let partyName = dictionary["partyName"] as? String else { return nil }
            newLeader.partyName = partyName
            guard let title = dictionary["title"] as? String else { return nil }
            newLeader.title = title
            guard let twitterHandle = dictionary["twitter"] as? String else { return nil }
            newLeader.twitterHandle = twitterHandle
            guard let emailAddress = dictionary["email"] as? String else { return nil }
            newLeader.emailAddress = emailAddress
            guard let constituency = dictionary["constituency"] as? String else { return nil }
            newLeader.constituency = constituency

            return newLeader
        }

        return fetchedLeader!
    }

    // Not yet used...
    static func fetchLeadersInConstituency(_ constituency: String) -> [LeaderRecord]
    {
        return Array(baseRealm().objects(try! realmType()).filter("constituency == %@", constituency)) as! Array<LeaderRecord>
    }
}


//
//  PartyRecord.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 09/11/2016.
//  Copyright © 2016 MAV. All rights reserved.
//

import Foundation
import RealmSwift

open class PartyRecord: BaseRealmObject
{
    // MARK: Leader object properties
    dynamic var key: String?
    dynamic var name: String?
    dynamic var imageURL: String?
    dynamic var twitterHandle: String?

    // MARK: Creating objects.
    static func fetchOrCreate(dictionary: Dictionary<String, AnyObject>, key: String) -> PartyRecord
    {
        let fetchedParty: PartyRecord? = BaseRealmObject.baseRealm().objects(PartyRecord.self).filter("key = %@", key).first!
        if fetchedParty == nil
        {
            let newParty = PartyRecord()
            newParty.key = key
            newParty.name = dictionary["name"] as? String
            newParty.imageURL = dictionary["image"] as? String
            newParty.twitterHandle = dictionary["twitter"] as? String
            return newParty
        }

        return fetchedParty!
    }

    // MARK: Overriding the realm type to return.
    override class func realmType() throws -> Object.Type
    {
        return PartyRecord.self
    }
}

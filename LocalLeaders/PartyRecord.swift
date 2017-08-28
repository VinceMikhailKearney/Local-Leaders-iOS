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
    dynamic var key: String = ""
    dynamic var imageURL: String = ""
    dynamic var twitterHandle: String = ""

    // MARK: Creating objects.
    static func create(_ dictionary: [String: AnyObject]) -> PartyRecord?
    {
        guard let nameKey = dictionary["name"] as? String else { return nil }
        let fetchedParty = BaseRealmObject.baseRealm().objects(PartyRecord.self).filter("key == %@", nameKey).first
        if fetchedParty == nil
        {
            let newParty = PartyRecord()
            newParty.key = nameKey
            guard let imageUrl = dictionary["image_url"] as? String else { return nil }
            newParty.imageURL = imageUrl
            guard let twitterHandle = dictionary["twitter_handle"] as? String else { return nil }
            newParty.twitterHandle = twitterHandle
            return newParty
        }

        return fetchedParty!
    }

    static func getParty(withName: String?) -> PartyRecord?
    {
        guard let withName = withName else { return nil }
        return baseRealm().objects(try! realmType()).filter("key == %@", withName).first as? PartyRecord
    }

    // MARK: Overriding the realm type to return.
    override class func realmType() throws -> Object.Type
    {
        return PartyRecord.self
    }
}


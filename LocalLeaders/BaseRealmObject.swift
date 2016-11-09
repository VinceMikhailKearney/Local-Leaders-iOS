//
//  BaseRealmObject.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 09/11/2016.
//  Copyright © 2016 MAV. All rights reserved.
//

import Foundation
import RealmSwift

enum baseRealmError : Error
{
    case realmTypeMustBeOverridden
    case moreThanOneInDatabaseMatchingKey
}

open class BaseRealmObject : Object
{
    // MARK: Checking for Realm migrations.
    static func checkForRealmMigration()
    {
        let config = Realm.Configuration(
            // Set the new schema version - Always greater than the previous. If never set, the first is 0.
            schemaVersion: 0,
            
            // This block is automatically called when opening a Realm with a schema version lower than the one we just set.
            migrationBlock:
            {
                migration, oldSchemaVersion in
                // First migration, previous schema = 0. So we check against 1.
                if (oldSchemaVersion < 1)
                { /* Realm will automatically detect new properties and removed properties and will update the schema on disk automatically */ } // Nothing to do!
            })
        
        // Now Realm needs to know to use the new config as the default config.
        Realm.Configuration.defaultConfiguration = config
        // Now that we've told Realm how to handle the schema change, opening the file ill automatically perform the migration
    }
    
    // MARK: Return the type of realm object --- MUST BE OVERRIDDEN IN SUBCLASSES.
    class func realmType() throws -> Object.Type
    {
        print("In base class for realm type")
        throw baseRealmError.realmTypeMustBeOverridden
    }
    
    // MARK: Use a base Realm
    static func baseRealm() -> Realm
    {
        return try! Realm()
    }
    
    // MARK: Saving and deleting realm objects.
    func save()
    {
        let realm = BaseRealmObject.baseRealm()
        try! realm.write({
            realm.add(self)
        })
    }
    
    static func deleteObject(_ object : Object)
    {
        let realm = BaseRealmObject.baseRealm()
        try! realm.write({
            realm.delete(object)
        })
    }
    
    static func deleteAllObjects()
    {
        let realm = BaseRealmObject.baseRealm()
        for object in realm.objects(try! realmType())
        {
            try! realm.write({
                realm.delete(object)
            })
        }
    }
    
    static func fetchWithKey(_ key : String) throws -> Object {
        var results : Results<Object>?
        results = baseRealm().objects(try! realmType()).filter("key == %@", key)
        
        if(results!.count == 1) {
            return results!.first!
        } else {
            throw baseRealmError.moreThanOneInDatabaseMatchingKey
        }
    }
    
    static func allObjects() -> Array<Object>
    {
        return Array(baseRealm().objects(try! realmType()))
    }
}

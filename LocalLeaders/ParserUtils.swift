//
//  CSVScanner.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 10/11/2016.
//  Copyright © 2016 MAV. All rights reserved.
//

import Foundation

/**
 * This class is no longer used as the server now takes care of putting the data together so the clients don't have to.
 */
open class ParserUtils: NSObject
{
    // MARK: Properties
    static let TWITTER_ROW_DATA: Int = 13
    static let EMAIL_ROW_DATA: Int = 7

    static func getMlasFromArray(_ array: Array<AnyObject>)
    {
        for object in array {
            if let leaderDictionary = object as? Dictionary<String, AnyObject> {
                let newLeader = LeaderRecord.create(dictionary: leaderDictionary)
                guard let leader = newLeader else { continue }
                newLeader?.updateTwitterHandle(fetchTwitterHandleFor(first: leader.firstname, last: leader.lastName))
                newLeader?.updateEmailAddress(fetchEmailFor(first: leader.firstname, last: leader.lastName))
                newLeader?.save()
            }
        }

        print(LeaderRecord.allObjects().count)
    }

    static func fetchTwitterHandleFor(first: String, last: String) -> String
    {
        return fetchDataFor(data: TWITTER_ROW_DATA, first: first, last: last)
    }

    static func fetchEmailFor(first: String, last: String) -> String
    {
        return fetchDataFor(data: EMAIL_ROW_DATA, first: first, last: last)
    }

    static func fetchDataFor(data: Int, first: String, last: String) -> String
    {
        var result = ""

        if let filePath = Bundle.main.path(forResource: "elected-candidates", ofType: "csv")
        {
            var fileObject: String?
            do {
                fileObject = try String(contentsOfFile: filePath)
            } catch {
                print("Unable to load csv file from path: \(filePath)")
            }

            var fileObjectCleaned = fileObject!.replacingOccurrences(of: "\r", with: "\n")
            fileObjectCleaned = fileObjectCleaned.replacingOccurrences(of: "\n\n", with: "\n")

            let objectArray = fileObjectCleaned.components(separatedBy: "\n")
            for row in objectArray
            {
                let rowData: Array<String> = row.components(separatedBy: ",")
                if rowData.count > 1 && (rowData[12].caseInsensitiveCompare(first) == ComparisonResult.orderedSame && rowData[11].caseInsensitiveCompare(last) == ComparisonResult.orderedSame) {
                    result = rowData[data]
                }
            }
        } else {
            print("Unable to get path to csv file.")
        }

        return result
    }
}


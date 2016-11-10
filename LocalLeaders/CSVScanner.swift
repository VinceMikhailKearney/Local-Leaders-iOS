//
//  CSVScanner.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 10/11/2016.
//  Copyright © 2016 MAV. All rights reserved.
//

import Foundation

class CSVScanner
{
    class func debug(_ string:String){
        print("CSVScanner: \(string)")
    }
    
    class func runFunctionOnRowsFromFile(fileName theFileName:String, withFunction theFunction:(Dictionary<String, String>)->())
    {
        if let filePath = Bundle.main.path(forResource: theFileName, ofType: "csv")
        {
//            var encodingError:NSError? = nil
            
            var fileObject : String?
            do {
                fileObject = try String(contentsOfFile: filePath)
                CSVScanner.debug(fileObject!)
            } catch {
                CSVScanner.debug("Unable to load csv file from path: \(filePath)")
            }
            
            var fileObjectCleaned = fileObject!.replacingOccurrences(of:"\r", with:"\n")
            fileObjectCleaned = fileObjectCleaned.replacingOccurrences(of:"\n\n", with:"\n")
            
            let objectArray = fileObjectCleaned.components(separatedBy:"\n")
            for anObjectRow in objectArray
            {
                let objectColumns = anObjectRow.components(separatedBy:",")
//                var aDictionaryEntry = Dictionary<String, String>()
//                var columnIndex = 0
                
                print(anObjectRow)
                
                for anObjectColumn in objectColumns
                {
                    CSVScanner.debug(anObjectColumn)
//                    aDictionaryEntry[theColumnNames[columnIndex]] = anObjectColumn.replacingOccurrences(of:"\"", with:"",
//                                                                                                        options: .caseInsensitive,
//                                                                                                        range: nil)
//                    columnIndex += 1
                }
                
//                if aDictionaryEntry.count > 1 {
//                    theFunction(aDictionaryEntry)
//                } else {
//                    CSVScanner.debug("No data extracted from row: \(anObjectRow) -> \(objectColumns)")
//                }
            }
        }
        else
        {
            CSVScanner.debug("Unable to get path to csv file: \(theFileName).csv")
        }
    }
}

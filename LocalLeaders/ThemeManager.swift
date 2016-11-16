//
//  ThemeManager.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 16/11/2016.
//  Copyright © 2016 MAV. All rights reserved.
//

import Foundation
import UIKit

enum themeError : Error
{
    case themeFileNotFound
}

open class ThemeManager : NSObject
{
    // MARK: Properties
    static var themeColors : Dictionary<String, String>?
    static let BLUE : String = "BLUE"
    static let PINK : String = "PINK"
    static let PRIMARY : String = "PRIMARY"
    static let MAIN_TEXT_COLOR : String = "MAIN_TEXT_COLOR"
    
    static func initialise() throws
    {
        let themeFile : String = Bundle.main.path(forResource: "Colours", ofType: "plist")!
        themeColors = NSDictionary(contentsOfFile: themeFile) as? Dictionary<String, String>
        if themeColors == nil {
            throw themeError.themeFileNotFound
        }
    }
    
    static func getColor(_ color : String) -> UIColor?
    {
        return UIColor(hexString: (themeColors?[color]!)!)
    }
}

//
//  ThemeManager.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 16/11/2016.
//  Copyright © 2016 MAV. All rights reserved.
//

import Foundation
import UIKit

enum themeError: Error
{
    case themeFileNotFound
}

open class ThemeManager: NSObject
{
    // MARK: Properties
    static var themeColors: Dictionary<String, String>?
    open class var blue: UIColor { return getColor("BLUE") }
    open class var pink: UIColor { return getColor("PINK") }
    open class var primary: UIColor { return getColor("PRIMARY") }
    open class var mainText: UIColor { return getColor("MAIN_TEXT_COLOR") }
    open class var titleColor: UIColor { return getColor("TITLE_COLOR") }

    static func initialise() throws
    {
        let themeFile: String = Bundle.main.path(forResource: "Colours", ofType: "plist")!
        themeColors = NSDictionary(contentsOfFile: themeFile) as? Dictionary<String, String>
        if themeColors == nil {
            throw themeError.themeFileNotFound
        }
    }

    static func getColor(_ colorName: String) -> UIColor
    {
        guard let color = UIColor(hexString: (themeColors?[colorName])) else { return .black }
        return color
    }
}


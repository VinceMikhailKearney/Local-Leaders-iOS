//
//  UIColorUitls.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 16/11/2016.
//  Copyright © 2016 MAV. All rights reserved.
//

import Foundation
import UIKit

extension UIColor
{
    public convenience init?(hexString: String)
    {
        let r, g, b: CGFloat
        // Let's make sure that we are passing in a Hex string first
        if hexString.hasPrefix("0x")
        {
            let start = hexString.index(hexString.startIndex, offsetBy: 2)
            let hexColor = hexString.substring(from: start)
            
            // If there are only 6, then we don't need to change the alpha. Which we probably never will.
            if hexColor.characters.count == 6
            {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber)
                {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    //a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: 1.0)
                    return
                }
            }
        }
        
        return nil
    }
}

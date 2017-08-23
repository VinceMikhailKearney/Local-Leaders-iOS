//
//  Utils.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 23/08/2017.
//  Copyright © 2017 MAV. All rights reserved.
//

import UIKit

class Utils: NSObject {
    public static func getImageFromFile(_ path: String) -> UIImage?
    {
        if let filePath = Bundle.main.path(forResource: path, ofType: "jpg") {
            return UIImage(contentsOfFile: filePath)
        }

        return nil
    }
}


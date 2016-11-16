//
//  BaseViewController.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 09/11/2016.
//  Copyright © 2016 MAV. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = ThemeManager.getColor(ThemeManager.PRIMARY)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: ThemeManager.getColor(ThemeManager.TITLE_COLOR)!]
        
        self.tabBarController?.tabBar.barTintColor = ThemeManager.getColor(ThemeManager.PRIMARY)
        self.tabBarController?.tabBar.tintColor = ThemeManager.getColor(ThemeManager.TITLE_COLOR)
    }
}

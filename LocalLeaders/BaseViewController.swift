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

        navigationController?.navigationBar.barTintColor = ThemeManager.primary
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: ThemeManager.titleColor]

        tabBarController?.tabBar.barTintColor = ThemeManager.primary
        tabBarController?.tabBar.tintColor = ThemeManager.titleColor
    }
}


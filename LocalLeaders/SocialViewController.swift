//
//  SecondViewController.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 08/11/2016.
//  Copyright © 2016 MAV. All rights reserved.
//

import UIKit
import TwitterKit

class SocialViewController: TWTRTimelineViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        dataSource = TWTRUserTimelineDataSource(screenName: "vmjkearney", apiClient: TWTRAPIClient())
        showTweetActions = true
        navigationController?.navigationBar.barTintColor = ThemeManager.primary
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: ThemeManager.titleColor]
        navigationItem.title = "Social"
    }
}


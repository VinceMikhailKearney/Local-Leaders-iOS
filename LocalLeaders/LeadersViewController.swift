//
//  FirstViewController.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 08/11/2016.
//  Copyright © 2016 MAV. All rights reserved.
//

import UIKit

class LeadersViewController: BaseViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        LocalLeadersAPI.getMlasJSON()
    }
}

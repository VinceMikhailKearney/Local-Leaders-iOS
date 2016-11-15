//
//  LeaderTableCell.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 15/11/2016.
//  Copyright © 2016 MAV. All rights reserved.
//

import UIKit

class LeaderCell : UITableViewCell
{
    @IBOutlet weak var leaderFullName: UILabel!
    @IBOutlet weak var leaderPartyName: UILabel!
    @IBOutlet weak var leaderConstituency: UILabel!
    @IBOutlet weak var leaderImage: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clear
        self.leaderFullName.textColor = UIColor.black
        self.leaderPartyName.textColor = UIColor.black
        self.leaderConstituency.textColor = UIColor.black
    }
    
    ////////////////////////////////////END OF CLASS////////////////////////////////////
}

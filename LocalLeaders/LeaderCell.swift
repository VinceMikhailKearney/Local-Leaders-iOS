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
        self.leaderPartyName.textColor = UIColor.red
        self.leaderConstituency.textColor = UIColor.gray
        
        self.leaderImage.layer.cornerRadius = 40
        self.leaderImage.layer.masksToBounds = true
        self.leaderImage.contentMode = UIViewContentMode.scaleAspectFill
    }
    
    ////////////////////////////////////END OF CLASS////////////////////////////////////
}

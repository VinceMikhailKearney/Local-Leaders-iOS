//
//  LeaderTableCell.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 15/11/2016.
//  Copyright © 2016 MAV. All rights reserved.
//

import UIKit

class LeaderCell: UITableViewCell
{
    @IBOutlet weak var leaderFullName: UILabel!
    @IBOutlet weak var leaderPartyName: UILabel!
    @IBOutlet weak var leaderConstituency: UILabel!
    @IBOutlet weak var leaderImage: UIImageView!

    override func awakeFromNib()
    {
        super.awakeFromNib()

        backgroundColor = UIColor.clear
        leaderFullName.textColor = UIColor.black
        leaderPartyName.textColor = ThemeManager.getColor(ThemeManager.PINK)
        leaderConstituency.textColor = UIColor.gray

        leaderImage.layer.cornerRadius = 40
        leaderImage.layer.masksToBounds = true
        leaderImage.contentMode = .scaleAspectFill
    }
}


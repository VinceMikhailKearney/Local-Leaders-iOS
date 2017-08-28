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

        backgroundColor = .clear
        leaderFullName.textColor = .black
        leaderPartyName.textColor = ThemeManager.pink
        leaderConstituency.textColor = .gray

        leaderImage.layer.cornerRadius = 40
        leaderImage.layer.masksToBounds = true
        leaderImage.contentMode = .scaleAspectFill
    }
}


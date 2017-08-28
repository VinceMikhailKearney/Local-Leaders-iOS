//
//  ProfileViewController.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 23/08/2017.
//  Copyright © 2017 MAV. All rights reserved.
//

import UIKit
import Social

class ProfileViewController: BaseViewController
{
    // MARK: - Properties
    public var mla: LeaderRecord?

    // MARK: - Outlets
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var mlaParty: UILabel!
    @IBOutlet weak var mlaName: UILabel!
    @IBOutlet weak var mlaConstituency: UILabel!
    @IBOutlet weak var mlaAboutTextView: UITextView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        coverView.backgroundColor = ThemeManager.primary

        guard let mla = mla else { return }
        profileImage.layer.cornerRadius = 50
        profileImage.layer.masksToBounds = true
        profileImage.contentMode = .scaleAspectFill
        profileImage.image = Utils.getImageFromFile("mla_with_id__\(mla.key)")
        setUpLabels()
        mlaName.text = "\(mla.firstname) \(mla.lastName)"
        mlaParty.text = mla.partyAbbreviation.uppercased()
        mlaConstituency.text = "MLA - \(mla.constituency)"
        mlaAboutTextView.text = mlaAboutText()
    }

    private func setUpLabels()
    {
        mlaName.textColor = .white
        mlaParty.textColor = ThemeManager.pink
        mlaConstituency.textColor = .white
        mlaAboutTextView.textColor = .black
        mlaAboutTextView.isEditable = false
    }

    private func mlaAboutText() -> String
    {
        guard let mla = mla else { return "" }
        return "Party Name\n\(mla.partyName)\n\nConstituency\n\(mla.constituency)\n\nAbout\nThe text could be the manifesto of the MLA/Counsellor or an explanation of who they are."
    }

    @IBAction func tweetUser(_: UIButton)
    {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter)
        {
            guard var handle = mla?.twitterHandle else { return }
            if !handle.hasPrefix("@") { handle.append("@") }
            let tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetSheet?.setInitialText("\(handle) #LocalLeaders ")
            guard let sheet = tweetSheet else { return }
            present(sheet, animated: true, completion: nil)
        }
    }

    @IBAction func dismissView(_: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
}


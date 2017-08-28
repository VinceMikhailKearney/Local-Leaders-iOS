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
        guard var handle = mla?.twitterHandle else { return }
        if handle.characters.count == 0 {
            guard let party = PartyRecord.getParty(withName: mla?.partyAbbreviation.uppercased()) else { return }
            handle = party.twitterHandle
        }

        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter)
        {
            if !handle.hasPrefix("@") { handle = String(format: "%@%@", "@", handle) }
            let tweetSheet = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetSheet?.setInitialText("\(handle) #LocalLeaders ")
            guard let sheet = tweetSheet else { return }
            present(sheet, animated: true, completion: nil)
        } else {
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.mode = .text
            hud.label.text = "No Twitter Account Found"

            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }
    }

    @IBAction func dismissView(_: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
}


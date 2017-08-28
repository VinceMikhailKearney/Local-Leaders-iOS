//
//  ProfileViewController.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 23/08/2017.
//  Copyright © 2017 MAV. All rights reserved.
//

import UIKit
import TwitterKit

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
        //        if (Twitter.sharedInstance().sessionStore.hasLoggedInUsers()) {
        //            // App must have at least one logged-in user to compose a Tweet
        //            let composer = TWTRComposerViewController.emptyComposer()
        //            present(composer, animated: true, completion: nil)
        //        } else {
        //            // Log in, and then check again
        //            Twitter.sharedInstance().logIn { session, error in
        //
        //                print("In the block for the log in")
        //                if session != nil { // Log in succeeded
        //                    let composer = TWTRComposerViewController.emptyComposer()
        //                    self.present(composer, animated: true, completion: nil)
        //                } else {
        //                    let alert = UIAlertController(title: "No Twitter Accounts Available", message: "You must log in before presenting a composer.", preferredStyle: .alert)
        //                    self.present(alert, animated: false, completion: nil)
        //                }
        //            }
        //        }
    }

    @IBAction func dismissView(_: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }
}


//
//  ProfileViewController.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 23/08/2017.
//  Copyright © 2017 MAV. All rights reserved.
//

import UIKit
import Social
import MessageUI

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
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!

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

        emailButton.backgroundColor = ThemeManager.primary
        emailButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        emailButton.setImage(UIImage(named: "email"), for: .normal)
        emailButton.layer.cornerRadius = 5

        twitterButton.backgroundColor = ThemeManager.primary
        twitterButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        twitterButton.setImage(UIImage(named: "twitter"), for: .normal)
        twitterButton.layer.cornerRadius = 5
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
            showToast(withText: "No Twitter Account Found")
        }
    }

    @IBAction func emailUser(_: UIButton)
    {
        guard let mla = mla else {
            showToast(withText: "Oops! Something went wrong!")
            log.error("Somehow we were unable to get the MLA?")
            return
        }

        let emailAddress = mla.emailAddress
        guard emailAddress.characters.count > 0 else {
            showToast(withText: "MLA does not have an E-mail address")
            return
        }

        if MFMailComposeViewController.canSendMail() {
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self

            mailComposer.setToRecipients([emailAddress])
            mailComposer.setSubject("Local Leaders")
            mailComposer.setMessageBody("Dear \(mla.firstname) \(mla.lastName)\n\n", isHTML: false)

            present(mailComposer, animated: true, completion: nil)
        } else {
            showToast(withText: "No E-Mail Account Found")
        }
    }

    @IBAction func dismissView(_: UIButton)
    {
        dismiss(animated: true, completion: nil)
    }

    // MARK: Private Helpers
    private func showToast(withText text: String)
    {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.mode = .text
        hud.label.text = text

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
}

extension ProfileViewController: MFMailComposeViewControllerDelegate
{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith _: MFMailComposeResult, error _: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}


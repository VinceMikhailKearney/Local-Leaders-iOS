//
//  FirstViewController.swift
//  LocalLeaders
//
//  Created by Vince Kearney on 08/11/2016.
//  Copyright © 2016 MAV. All rights reserved.
//

import UIKit

class LeadersViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource
{
    // MARK: Properties
    fileprivate var leaders: Array<LeaderRecord>?

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad()
    {
        super.viewDidLoad()

        leaders = Array<LeaderRecord>()
        for object in LeaderRecord.allObjects() {
            leaders?.append(object as! LeaderRecord)
        }

        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        navigationItem.title = "MLAs"
    }

    // MARK: TableView Delegate Methods
    internal func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int
    {
        return leaders!.count
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderCell", for: indexPath) as! LeaderCell

        let leader: LeaderRecord = leaders![indexPath.row]
        cell.leaderFullName.text = "\(leader.firstname!) \(leader.lastName!)"
        cell.leaderPartyName.text = leader.partyName!
        cell.leaderConstituency.text = leader.constituency!
        let leaderKey: String = leader.key!
        cell.leaderImage.image = getImageFromFile("mla_with_id__\(leaderKey)")

        return cell
    }

    internal func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat
    {
        return 100.0
    }

    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let leader: LeaderRecord = leaders![indexPath.row]
        print("Just tapped MLA: \(leader.firstname!) \(leader.lastName!). Key -> \(leader.key!)")
        tableView.deselectRow(at: indexPath, animated: true)
    }

    fileprivate func getImageFromFile(_ path: String) -> UIImage?
    {
        var image: UIImage?
        if let filePath = Bundle.main.path(forResource: path, ofType: "jpg") {
            image = UIImage(contentsOfFile: filePath)
        }
        return image
    }
}

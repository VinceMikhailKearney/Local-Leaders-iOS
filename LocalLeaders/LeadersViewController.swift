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
    // MARK: Properties
    fileprivate var leaders: [LeaderRecord]?

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        leaders = LeaderRecord.allObjects() as? [LeaderRecord]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        navigationItem.title = "MLAs"
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMla" {
            let profileViewController = segue.destination as? ProfileViewController
            profileViewController?.mla = sender as? LeaderRecord
        }
    }
}

extension LeadersViewController: UITableViewDataSource
{
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int
    {
        return leaders?.count ?? 0
    }
}

extension LeadersViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderCell", for: indexPath) as! LeaderCell

        guard let leaders = leaders else { return cell }
        let leader: LeaderRecord = leaders[indexPath.row]
        cell.leaderFullName.text = "\(leader.firstname) \(leader.lastName)"
        cell.leaderPartyName.text = leader.partyName
        cell.leaderConstituency.text = leader.constituency
        cell.leaderImage.image = Utils.getImageFromFile("mla_with_id__\(leader.key)")
        return cell
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat
    {
        return 100.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        guard let leaders = leaders else { return }
        let leader: LeaderRecord = leaders[indexPath.row]
        print("The leader is: \(leader)")
        performSegue(withIdentifier: "showMla", sender: leader)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


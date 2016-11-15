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
    fileprivate var leaders : Array<LeaderRecord>?
    
    // MARK: Outlets
    @IBOutlet weak var tableView : UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        leaders = Array<LeaderRecord>()
        
        for object in LeaderRecord.allObjects() {
            leaders?.append(object as! LeaderRecord)
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.white
        self.navigationItem.title = "MLAs"
    }
    
    // MARK: TableView Delegate Methods
    internal func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
    {
        return leaders!.count
    }
    
    internal func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderCell", for: indexPath) as! LeaderCell
        
        let leader : LeaderRecord = leaders![indexPath.row]
        cell.leaderFullName.text = "\(leader.firstname!) \(leader.lastName!)"
        cell.leaderPartyName.text = leader.partyName!
        cell.leaderConstituency.text = leader.constituency!
        let leaderKey : String = leader.key!
        cell.leaderImage.image = getImageFromFile("mla_with_id__\(leaderKey)")
        
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0
    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let leader : LeaderRecord = leaders![indexPath.row]
        print("Just tapped MLA: \(leader.firstname!) \(leader.lastName!). Key -> \(leader.key!)")
    }
    
    fileprivate func getImageFromFile(_ path: String) -> UIImage?
    {
        var image : UIImage?
        if let filePath = Bundle.main.path(forResource: path, ofType: "jpg") {
            image = UIImage(contentsOfFile: filePath)
        }
        return image
    }
}

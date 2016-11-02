//
//  TestRoundButtonCellController.swift
//  SwiftPlayground
//
//  Created by Enix Yu on 31/10/2016.
//  Copyright © 2016 RobotBros. All rights reserved.
//

import UIKit


class TestRoundButtonCellController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "TestRoundButtonCell", bundle: nil), forCellReuseIdentifier: "TestRoundButtonCell")
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TestRoundButtonCell", forIndexPath: indexPath)
        return cell
    }
}
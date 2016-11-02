//
//  TestRoundButtonCell.swift
//  SwiftPlayground
//
//  Created by Enix Yu on 31/10/2016.
//  Copyright © 2016 RobotBros. All rights reserved.
//

import UIKit

class TestRoundButtonCell: UITableViewCell {
    
    @IBOutlet weak var roundBtn: UIButton!
    
    override func layoutSubviews() {
        //super.layoutSubviews()
        
        roundBtn.layer.cornerRadius = 5.0
        roundBtn.layer.masksToBounds = true
    }
}
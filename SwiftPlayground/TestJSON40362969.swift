//
//  TestJSON40362969.swift
//  SwiftPlayground
//
//  Created by Enix Yu on 1/11/2016.
//  Copyright © 2016 RobotBros. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class SkillModel: NSObject {
    var needed1: String
    var needed2: String
    var needed3: String
    
    init(json: JSON) {
        needed1 = json["needed1"].stringValue
        needed2 = json["needed1"].stringValue
        needed3 = json["needed1"].stringValue
        super.init()
    }
}

class SkillsGainedModel: NSObject {
    var gained1: String
    var gained2: String
    var gained3: String
    
    init(json: JSON) {
        gained1 = json["gained1"].stringValue
        gained2 = json["gained2"].stringValue
        gained3 = json["gained3"].stringValue
        super.init()
    }
}

class EmployeeModel: NSObject {
    var name: String
    var employeeId: String
    var mediaIndustry: String
    var location: String
    var additionalInfo: String
    var skillsNeeded: SkillModel
    var skillGained: SkillsGainedModel
    var recommend: Int
    var graduationYear: String
    var email: String
    var company: String
    var desc: String
    var housing: String
    var continent: String
    
    init(json: JSON){
        name = json["name"].stringValue
        employeeId = json["employeeId"].stringValue
        mediaIndustry = json["mediaIndustry"].stringValue
        location = json["location"].stringValue
        additionalInfo = json["additionalInfo"].stringValue
        skillsNeeded = SkillModel(json: json["skillsNeeded"])
        skillGained = SkillsGainedModel(json: json["skillGained"])
        recommend = json["recommend"].intValue
        graduationYear = json["graduationYear"].stringValue
        email = json["email"].stringValue
        company = json["company"].stringValue
        desc = json["description"].stringValue
        housing = json["housing"].stringValue
        continent = json["continent"].stringValue
        super.init()
    }
}

class TestJSON40362969: UITableViewController {
    
    var employees = [EmployeeModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Alamofire.request(.GET, "https://jsonblob.com/api/jsonBlob/580d0ccce4b0bcac9f837fbe", parameters: nil, encoding: .URL, headers: nil)
            .validate()
            .responseJSON {
                (response) in
                switch response.result {
                case .Success(let value):
                    let json = JSON(value)
                    self.employees = json.arrayValue.map({
                        (item) -> EmployeeModel in
                        return EmployeeModel(json: item)
                    })
                    dispatch_async(dispatch_get_main_queue(), { 
                        self.tableView.reloadData()
                    })
                case .Failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let model = employees[indexPath.row]
        cell.textLabel?.text = model.name
        return cell
    }
}
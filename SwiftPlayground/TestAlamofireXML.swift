//
//  TestAlamofireXML.swift
//  SwiftPlayground
//
//  Created by Enix Yu on 31/10/2016.
//  Copyright © 2016 RobotBros. All rights reserved.
//

import UIKit
import Alamofire

class TestAlamofireXML: UIViewController {

    override func viewDidLoad() {
        getData()
    }
    
    func getData() {
        Alamofire.request(.GET, "https://api-equitywerks.rhcloud.com/api/read_ls.xml", parameters: nil, encoding: .URL, headers: nil)
            .validate()
            .responseString {
                (response) in
                switch response.result {
                case .Success(let value):
                    print(value)
                case .Failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}

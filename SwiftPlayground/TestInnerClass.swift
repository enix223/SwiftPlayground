//
//  TestInnerClass.swift
//  SwiftPlayground
//
//  Created by Enix Yu on 6/11/2016.
//  Copyright © 2016 RobotBros. All rights reserved.
//
//  Ref: http://stackoverflow.com/questions/40445852/custom-protocols-swift/40446419#40446419
//

import UIKit
import Alamofire

public class TestInnerClass: UIViewController {
    
    public func login(username username: String,
                      password: String,
                      successCallback: ((response: NSDictionary) -> Void),
                      errorCallback: ((message: String, code: Int) -> Void)) {
        
        //
        // Make your login request here, and change the `success` value depends on your response
        // let response = ...
        //
        
        Alamofire.request(.POST, "login", parameters: ["username": username, "password": password], encoding: .JSON, headers: nil)
            .validate()
            .responseJSON {
                (response) in
                switch response.result {
                    case .Success(let value):
                        let json = value as! NSDictionary
                        successCallback(response: json)
                    case .Failure(let error):
                        errorCallback(message: error.localizedDescription, code: error.code)
                }
            }
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        login(username: "enix",
              password: "123",
              successCallback:{
                    (response) in
                    // Get Called when success
                    self.dismissViewControllerAnimated(true, completion: nil)
              },
              errorCallback: ({
                // Get called when failed
                (message, code) in
                print(message)
              })
        )
    }
}
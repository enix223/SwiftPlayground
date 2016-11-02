//
//  TestAlamofireMultiUpload.swift
//  SwiftPlayground
//
//  Created by Enix Yu on 2/11/2016.
//  Copyright © 2016 RobotBros. All rights reserved.
//

import UIKit
import Alamofire


class TestAlamofireMultiUpload: UIViewController {
    
    var apiUrl: String {
        get {
            return "http://192.168.6.183:8000/api/v1/"  // SD Lib
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let images = [UIImage(named: "test1"), UIImage(named: "test2")]
        requestAPIUploadImageSignal
    }
    
    /// Upload file with multipart formdata
    func apiUploadFile(url: String,
                       method: Alamofire.Method,
                       token: String?,
                       multipartFormData: MultipartFormData -> Void,
                       completionHandler: (Response<AnyObject, NSError> -> Void)) {
        
        let headers = buildHeaders(token)
        
        Alamofire.upload(method,
                         "\(apiUrl)\(url)/",
                         headers: headers,
                         multipartFormData: multipartFormData,
                         encodingMemoryThreshold: Manager.MultipartFormDataEncodingMemoryThreshold,
                         encodingCompletion: {
                            (encodingResult) in
                            switch encodingResult {
                            case .Success(let request, _, _):
                                request
                                    .validate()
                                    .responseJSON(completionHandler: completionHandler)
                            case .Failure(let err):
                                let error = NSError(domain: "test", code: 1, userInfo: ["message": String(err)])
                                let result: Result<AnyObject, NSError> = .Failure(error)
                                let response = Response(request: nil, response: nil, data: nil, result: result)
                                completionHandler(response)
                            }
        })
        
        
    }
    
    /// Upload image
    func requestAPIUploadImage(token: String, images: [UIImage], completion: ((result: Bool) -> Void)) {
            
        let parameters = ["imageCategory": "1"]
        
        ////////////////////////////////////////////////////////////
        /// How can I make the images upload serially here ????? ///
        ////////////////////////////////////////////////////////////
        let image = images[0]
        
        self.apiUploadFile("image/upload", method: .POST, token: token, multipartFormData: {
            (multipartFormData) in
            
            // import images to multipart
            if let data = UIImageJPEGRepresentation(image, 1) {
                multipartFormData.appendBodyPart(data: data, name: "imageFile", fileName: "imageFile.jpeg", mimeType: "image/jpeg")
            }
            
            // import parameters to multipart
            for (key, value) in parameters {
                multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
            }
            
            }, completionHandler: {
                (response) in
                switch response.result {
                case .Success(let value):
                    print(value)
                    completion(true)
                case .Failure(let error):
                    print(error)
                    completion(false)
                }
        })
    }
    
    private func buildHeaders(token: String?) -> [String: String]? {
        var headers = [String: String]()
        if let token = token {
            headers["Authorization"] = "Token \(token)"
        }
        return headers
    }
}
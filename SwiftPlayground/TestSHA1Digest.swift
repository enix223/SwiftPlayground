//
//  TestSHA1Digest.swift
//  SwiftPlayground
//
//  Created by Enix Yu on 31/10/2016.
//  Copyright © 2016 RobotBros. All rights reserved.
//

import UIKit

extension String {
    func sha1() -> String {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)!
        var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joinWithSeparator("")
    }
    
    func sha1Data() -> NSData {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)!
        var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
        let digestData = NSData(bytes: digest, length: digest.count)
        return digestData
    }
}

/* 

Swift 3
 
extension String {
    func sha1() -> String {
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
}

*/


class TestSHA1Digest: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let b64 = calculateDigest("2.045020311114033331503343429780020454510MDAwMDAwMDAwMDAwMDA2ODkzOTI=https://myeshop.gr/orders/Payment_Okhttps://myeshop.gr/orders/Payment_FailEURO123") {
            print("SHA1: \(b64)")
        } else {
            print("Calcuate SHA1 failed")
        }
    }
    
    func calculateDigest(data: String) -> String? {
        let shaData = data.sha1Data()
        return shaData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    }
}
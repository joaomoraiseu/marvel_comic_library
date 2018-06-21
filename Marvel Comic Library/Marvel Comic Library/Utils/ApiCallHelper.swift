//
//  ApiCallHelper.swift
//  Marvel Comic Library
//
//  Created by João  Pedro on 19/06/18.
//  Copyright © 2018 João  Pedro. All rights reserved.
//

import Foundation

struct KeyDict {
    let publicKey: String!
    let privateKey: String!
}

class ApiCallHelper {
    
    private var keys: NSDictionary?
    func getKeys()-> KeyDict{
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),let infoPlistEntries = NSDictionary(contentsOfFile: path) as? [String:AnyObject] else{
            return KeyDict(publicKey: "", privateKey: "")
        }
        if let privKey = infoPlistEntries["private_key_marvel"] as? String ,let pubKey = infoPlistEntries["public_key_marvel"] as? String{
            return KeyDict(publicKey: pubKey, privateKey: privKey)
        }
        return KeyDict(publicKey: "", privateKey: "")
    }
    
    func getMainEndpoint()-> String{
        guard let path = Bundle.main.path(forResource: "Info", ofType: "plist"),let infoPlistEntries = NSDictionary(contentsOfFile: path) as? [String:AnyObject] else{
            return ""
        }
        if let _endpoint = infoPlistEntries["marvel_endpoint"] as? String {
            return _endpoint
        }
        return ""
    }
}

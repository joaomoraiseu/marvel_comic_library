//
//  ApiCall.swift
//  Marvel Comic Library
//
//  Created by João  Pedro on 19/06/18.
//  Copyright © 2018 João  Pedro. All rights reserved.
//

import Foundation

class ApiCallModel: NSObject,Codable {
    let code : Int?
    let status: String?
    var data : ComicList?
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Keys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        data = try values.decodeIfPresent(ComicList.self, forKey: .data)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(code, forKey: .code)
        try container.encode(status, forKey: .status)
        try container.encode(data, forKey: .data)
    }
    
    private enum Keys: String, CodingKey {
        case code = "code"
        case status = "status"
        case data = "data"
    }
}

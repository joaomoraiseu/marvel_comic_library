//
//  ComicList.swift
//  Marvel Comic Library
//
//  Created by João  Pedro on 19/06/18.
//  Copyright © 2018 João  Pedro. All rights reserved.
//

import Foundation

class ComicList: NSObject,Codable {
    
    public let offset: Int?
    public let limit: Int?
    public let total: Int?
    public let count: Int?
    public let comics: [Comic]?
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Keys.self)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        limit = try values.decodeIfPresent(Int.self, forKey: .limit)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        comics = try values.decodeIfPresent([Comic].self, forKey: .comics)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(offset, forKey: .offset)
        try container.encode(limit, forKey: .limit)
        try container.encode(total, forKey: .total)
        try container.encode(count, forKey: .count)
        try container.encode(comics, forKey: .comics)
    }
    
    private enum Keys: String, CodingKey {
        case offset = "offset"
        case limit = "limit"
        case total = "total"
        case count = "count"
        case comics = "results"
    }
}

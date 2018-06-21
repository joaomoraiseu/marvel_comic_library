//
//  Comic.swift
//  Marvel Comic Library
//
//  Created by João  Pedro on 19/06/18.
//  Copyright © 2018 João  Pedro. All rights reserved.
//

import Foundation

class Comic:NSObject, Codable {
    
    public var orderLetter: Character?
    public let id: Int?
    public let title: String?
    public let issueNumber: Int?
    public let descript: String?
    public let isbn: String?
    public let pageCount: Int?
    public let thumbnail: ComicImage?
    public let image:[ComicImage]?
    public var prices: [Price]?

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Keys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        orderLetter = title?.first
        issueNumber = try values.decodeIfPresent(Int.self, forKey: .issueNumber)
        descript = try values.decodeIfPresent(String.self, forKey: .descript)
        isbn = try values.decodeIfPresent(String.self, forKey: .isbn)
        pageCount = try values.decodeIfPresent(Int.self, forKey: .pageCount)
        thumbnail = try values.decodeIfPresent(ComicImage.self, forKey: .thumbnail)
        image = try values.decodeIfPresent([ComicImage].self, forKey: .image)
        prices = try values.decodeIfPresent([Price].self, forKey: .prices)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(issueNumber, forKey: .issueNumber)
        try container.encode(descript, forKey: .descript)
        try container.encode(isbn, forKey: .isbn)
        try container.encode(pageCount, forKey: .pageCount)
        try container.encode(thumbnail, forKey: .thumbnail)
        try container.encode(image, forKey: .image)
        try container.encode(prices, forKey: .prices)
    }
    
    private enum Keys: String, CodingKey {
        case id = "id"
        case title = "title"
        case issueNumber = "issueNumber"
        case descript = "description"
        case isbn = "isbn"
        case pageCount = "pageCount"
        case thumbnail = "thumbnail"
        case image = "images"
        case prices = "prices"
    }
}

class ComicImage: NSObject,Codable {
    public let fileExtension: String?
    
    private var _path: String!
    public var path: String? {
        return self.securePath(path: _path)
    }
    
    public var url: URL? {
        return URL(string: self.securePath(path: self._path) + "." + self.fileExtension!)
    }
    
    
    func securePath(path:String) -> String {
        if path.hasPrefix("http://") {
            let range = path.range(of: "http://")
            var newPath = path
            newPath.removeSubrange(range!)
            return "https://" + newPath
        } else {
            return path
        }
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Keys.self)
        _path = try values.decodeIfPresent(String.self, forKey: ._path)
        self.fileExtension = try values.decodeIfPresent(String.self, forKey: .fileExtension)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(_path, forKey: ._path)
        try container.encode(fileExtension, forKey: .fileExtension)
    }
    
    private enum Keys: String, CodingKey {
        case _path = "path"
        case fileExtension = "extension"
    }
    
    
}

class Price:NSObject, Codable {
    public let type: String?
    public let price: Double?
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: Keys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        price = try values.decodeIfPresent(Double.self, forKey: .price)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        try container.encode(type, forKey: .type)
        try container.encode(price, forKey: .price)
    }
    
    private enum Keys: String, CodingKey {
        case type = "type"
        case price = "price"
    }
}

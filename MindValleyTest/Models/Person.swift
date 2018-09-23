//
//  Person.swift
//  MindValleyTest
//
//  Created by Vahe on 9/20/18.
//  Copyright © 2018 Vahe. All rights reserved.
//

import Foundation

struct Person: Decodable {
    var id: String
    var user: User
    var imageURLs: ImageURL
    
    private enum CodingKeys: String, CodingKey {
        case id
        case user
        case imageURLs = "urls"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        user = try container.decode(User.self, forKey: .user)
        imageURLs = try container.decode(ImageURL.self, forKey: .imageURLs)
    }
}

struct ImageURL: Decodable {
    var full: String
    var thumb: String
    
    private enum CodingKeys: String, CodingKey {
        case full
        case thumb
    }
    
    init(full: String, thumb: String) {
        self.full = full
        self.thumb = thumb
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        full = try container.decode(String.self, forKey: .full)
        thumb = try container.decode(String.self, forKey: .thumb)
    }
}

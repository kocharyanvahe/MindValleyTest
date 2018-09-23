//
//  User.swift
//  MindValleyTest
//
//  Created by Vahe on 9/20/18.
//  Copyright © 2018 Vahe. All rights reserved.
//

import Foundation

struct User: Decodable {
    var id: String
    var username: String
    var name: String
    var profileImage: ProfileImage
    
    private enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case profileImage = "profile_image"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        username = try container.decode(String.self, forKey: .username)
        name = try container.decode(String.self, forKey: .name)
        profileImage = try container.decode(ProfileImage.self, forKey: .profileImage)
    }
}

struct ProfileImage: Decodable {
    var small: String
    var medium: String
    var large: String
    
    private enum CodingKeys: String, CodingKey {
        case small
        case medium
        case large
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        small = try container.decode(String.self, forKey: .small)
        medium = try container.decode(String.self, forKey: .medium)
        large = try container.decode(String.self, forKey: .large)
    }
}

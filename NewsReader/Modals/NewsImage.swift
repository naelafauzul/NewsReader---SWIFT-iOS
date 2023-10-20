//
//  NewsImage.swift
//  NewsReader
//
//  Created by Naela Fauzul Muna on 17/10/23.
//

import Foundation

struct NewsImage: Codable {
    let small: String
    let medium: String
    let large: String
    let extraLarge: String
    
    enum CodingKeys: String, CodingKey {
            case small
            case medium
            case large
            case extraLarge
        }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.small = try container.decodeIfPresent(String.self, forKey: .small) ?? ""
        self.medium = try container.decodeIfPresent(String.self, forKey: .medium) ?? ""
        self.large = try container.decodeIfPresent(String.self, forKey: .large) ?? ""
        self.extraLarge = try container.decodeIfPresent(String.self, forKey: .extraLarge) ?? ""
    }
}



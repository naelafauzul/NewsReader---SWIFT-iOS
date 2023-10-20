//
//  News.swift
//  NewsReader
//
//  Created by Naela Fauzul Muna on 17/10/23.
//

import Foundation

struct News: Codable {
    let creator: String
    let title: String
    let link: String
    let author: String
    let categories: [String]
    let isoDate: String
    let description: String
    let image: [NewsImage] // Changed this to an array of NewsImage

    enum CodingKeys: String, CodingKey {
        case creator
        case title
        case link
        case author
        case categories
        case isoDate
        case description
        case image
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.creator = try container.decodeIfPresent(String.self, forKey: .creator) ?? ""
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.link = try container.decodeIfPresent(String.self, forKey: .link) ?? ""
        self.author = try container.decodeIfPresent(String.self, forKey: .author) ?? ""
        self.categories = try container.decodeIfPresent([String].self, forKey: .categories) ?? [""]
        self.isoDate = try container.decodeIfPresent(String.self, forKey: .isoDate) ?? ""
        self.description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""

        // Handle the case where 'image' can be an array or a dictionary
        if let imageArray = try? container.decodeIfPresent([NewsImage].self, forKey: .image) {
            self.image = imageArray
        } else if let imageDict = try? container.decodeIfPresent(NewsImage.self, forKey: .image) {
            self.image = [imageDict]
        } else {
            // Handle the case where 'image' is not valid
            self.image = []
        }
    }
}


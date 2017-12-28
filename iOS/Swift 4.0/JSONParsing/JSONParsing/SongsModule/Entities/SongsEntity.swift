//
//  SongsEntity.swift
//  JSONParsing
//
//  Created by Shridhar Mali on 12/27/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import Foundation
public struct SongsViewModel: Codable {
    let feed: Feed
    private enum songsKeys: String, CodingKey {
        case feed = "feed"
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: songsKeys.self)
        feed = try container.decode(Feed.self, forKey: .feed)
    }
}
public struct Feed: Codable {
    let title: String
    let id: String
    let results: [Results]
}

public struct Results: Codable {
    let name: String
    let artistName: String
}


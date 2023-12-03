//
//  Topic.swift
//  SpaceWiz1
//
//  Created by relwas on 02/12/23.
//

import Foundation

struct Topic: Codable {
    let title: String
    let text: String
}

struct TopicsResponse: Codable {
    let topics: [Topic]
}

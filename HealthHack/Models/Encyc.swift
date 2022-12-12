//
//  Encyc.swift
//  HealthHack
//
//  Created by sehooon on 2022/12/12.
//

import Foundation

struct Encyc: Codable {
    let lastBuildDate: String
    let total, start, display: Int
    let encycDataList: [EncycData]
    
    enum CodingKeys: String, CodingKey{
        case lastBuildDate
        case total
        case start
        case display
        case encycDataList = "items"
    }
}

struct EncycData: Codable {
    let title: String
    let link: String
    let description: String
    let thumbnail: String
}


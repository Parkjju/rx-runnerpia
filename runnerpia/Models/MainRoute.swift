//
//  MainRoute.swift
//  runnerpia
//
//  Created by Jun on 2023/10/10.
//

import Foundation

struct MainRoute: Codable {
    let title: String
    let images: [String]
    let runningLocation: String
    let runningDate: String
    let runningTime: Int
    let runningDistance: Int
    let comment: String
    let isBookmarked: Bool
    let coordinate: [Coordinate]
    let secureTags: [String]
    let recommendTags: [String]
}

struct Coordinate: Codable {
    let latitude: CGFloat
    let longitude: CGFloat
}

//
//  Tags.swift
//  runnerpia
//
//  Created by Jun on 2023/10/10.
//

import Foundation

enum SecureTags: String {
    case schoolZone = "근처에 어린이 보호구역이 있어요"
    case safetyLight = "안심등이 있어요"
    case manyLight = "가로등이 많아요"
    case manyPeopleInNight = "밤에 사람이 많아요"
    case manyPeopleInNoon = "낮에 사람이 많아요"
    
    static func retrieveAllSecureTagsWithArray() -> [SecureTags] {
        return [.schoolZone, .safetyLight, .manyLight, .manyPeopleInNoon, .manyPeopleInNight]
    }
}

enum RecommendTags: String {
    case riverView = "강을 보며 달려요"
    case manyTrees = "나무가 많아요"
    case cleanRoad = "길이 깨끗해요"
    case noSteepRoad = "가파른 구간이 없어요"
    case pedestrianOnly = "보행자 전용 트랙이 있어요"
    
    static func retrieveAllRecommendedTagsWithArray() -> [RecommendTags] {
        return [.riverView, .manyTrees, .cleanRoad, .noSteepRoad, .pedestrianOnly]
    }
}

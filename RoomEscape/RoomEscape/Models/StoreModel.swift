//
//  RoomModel.swift
//  RoomEscape
//
//  Created by Noah's Ark on 2022/07/18.
//

import Foundation

struct RoomModel: Codable {
    let storeName: String
    let phoneNumber: String
    let homepage: String
    let image: String
    let title: String
    let star: Double
    let genre: String
    let difficulty: Double
    let activity: Double
    let horror: Double
    let description: String
    let recommendation: String
}

struct SampleRoomModel {
    let image: String
    let title: String
    let genre: String
    let difficulty: Float
    let activity: String
    let maxParty: Int
    let timeLimit: Int
    let description: String
}

let sampleRoomArray: [SampleRoomModel] = [
    SampleRoomModel(
        image: "https://previews.123rf.com/images/aquir/aquir1311/aquir131100316/23569861-sample-grunge-red-round-stamp.jpg",
        title: "낭랑카페",
        genre: "판타지",
        difficulty: 4.0,
        activity: "적음",
        maxParty: 4,
        timeLimit: 75,
        description: "낭랑 카페는 오랫동안 존재해 왔습니다."
    ),
    SampleRoomModel(
        image: "https://previews.123rf.com/images/aquir/aquir1311/aquir131100316/23569861-sample-grunge-red-round-stamp.jpg",
        title: "낭랑카페",
        genre: "판타지",
        difficulty: 4.0,
        activity: "적음",
        maxParty: 4,
        timeLimit: 75,
        description: "낭랑 카페는 오랫동안 존재해 왔습니다."
    ),
    SampleRoomModel(
        image: "https://previews.123rf.com/images/aquir/aquir1311/aquir131100316/23569861-sample-grunge-red-round-stamp.jpg",
        title: "낭랑카페",
        genre: "판타지",
        difficulty: 4.0,
        activity: "적음",
        maxParty: 4,
        timeLimit: 75,
        description: "낭랑 카페는 오랫동안 존재해 왔습니다."
    ),
    SampleRoomModel(
        image: "https://previews.123rf.com/images/aquir/aquir1311/aquir131100316/23569861-sample-grunge-red-round-stamp.jpg",
        title: "낭랑카페",
        genre: "판타지",
        difficulty: 4.0,
        activity: "적음",
        maxParty: 4,
        timeLimit: 75,
        description: "낭랑 카페는 오랫동안 존재해 왔습니다."
    ),
    SampleRoomModel(
        image: "https://previews.123rf.com/images/aquir/aquir1311/aquir131100316/23569861-sample-grunge-red-round-stamp.jpg",
        title: "낭랑카페",
        genre: "판타지",
        difficulty: 4.0,
        activity: "적음",
        maxParty: 4,
        timeLimit: 75,
        description: "낭랑 카페는 오랫동안 존재해 왔습니다."
    ),
    SampleRoomModel(
        image: "https://previews.123rf.com/images/aquir/aquir1311/aquir131100316/23569861-sample-grunge-red-round-stamp.jpg",
        title: "낭랑카페",
        genre: "판타지",
        difficulty: 4.0,
        activity: "적음",
        maxParty: 4,
        timeLimit: 75,
        description: "낭랑 카페는 오랫동안 존재해 왔습니다."
    ),
    SampleRoomModel(
        image: "https://previews.123rf.com/images/aquir/aquir1311/aquir131100316/23569861-sample-grunge-red-round-stamp.jpg",
        title: "낭랑카페",
        genre: "판타지",
        difficulty: 4.0,
        activity: "적음",
        maxParty: 4,
        timeLimit: 75,
        description: "낭랑 카페는 오랫동안 존재해 왔습니다."
    )
]

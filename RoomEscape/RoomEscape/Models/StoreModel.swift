//
//  RoomModel.swift
//  RoomEscape
//
//  Created by Noah's Ark on 2022/07/18.
//

import Foundation

/*
 JSON 예시는 아래와 같습니다.
 {
 "storeName": "세븐클루스 강남1호점",
 "telephone": "010-6551-6561",
 "homepage": "http://wqqme.cafe24.com/",
 "address": "서울 강남구 테헤란로2길 8",
 "rooms": [
     {
         "title": "룸 401",
         "genre": "스릴러",
         "difficulty": 2,
         "activity": "적음",
         "maxParty": 3,
         "timeLimit": 60,
         "description": "수진이의 생일인 크리스마스 이브날 모텔에서 준비해준 축하 와인과 함께 즐거운 생일파티를 하며 밤을 보낸 후 아침에 눈을 떠보니 수진이는 사라져있고..... 주변을 살펴보니 휴대폰은 사라져 있고 탁자 위 전화기도 신호가 가지 않는다. 방문은 잠겨있고 소리쳐도 아무런 대답도 들을 수 없다... 만약 수진이에게 무슨 일이 있었다면? 우린 무사히 모텔을 탈출할 수 있을까?"
     }
   ]
 }
 */

struct StoreModel: Codable {
    let storeName: String
    let telephone: String
    let homepage: String
    let address: String
    let rooms: [RoomModel]
}

struct RoomModel: Codable {
    let storeName: String
    let phoneNumber: String
    let Homepage: String
    let image: String
    let title: String
    let star: Int
    let genre: String
    let difficulty: Int
    let activity: Int
    let horror: Int
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

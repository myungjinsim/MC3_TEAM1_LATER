//
//  RoomModel.swift
//  RoomEscape
//
//  Created by Noah's Ark on 2022/07/18.
//

import Foundation

/*
"id": 1,
"location": "대구",
"storeName": "룸즈에이 대구동성로점",
"address": "대구광역시 중구 동성로6길 16",
"phoneNumber": "0507-1389-3838",
"homepage": "http://roomsa.co.kr/new_main.asp?R_JIJEM=S10",
"image": "http://roomsa.co.kr/upload_file/thema/maintheme(15).jpg",
"title": "취중진담",
"genre": "감성/스토리",
"difficulty": 4,
"activity": 3,
"horror": 1,
"description": "이곳은 누군가의 과거로 가볼 수 있는 술집입니다. 칵테일 한 잔에 과거의 이야기를 알 수 있는 술집이라... 이곳을 찾은 손님들의 취중진담을 들어볼까요?",
"recommendation": "몽글몽글한 감성 스토리를 좋아하시는 분"
*/

struct RoomModel: Codable, Hashable {
    let id: Int
    let location: String
    let storeName: String
    let phoneNumber: String
    let homepage: String
    let image: String
    let title: String
    let genre: String
    let difficulty: Int
    let activity: Int
    let horror: Int
    let description: String
    let recommendation: String
}

struct TeamModel {
    var teamName: String
    let themeList: [Int]
}

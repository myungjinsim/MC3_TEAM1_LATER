//
//  ShareScreenShotView.swift
//  RoomEscape
//
//  Created by Wonhyuk Choi on 2022/07/28.
//

import SwiftUI

struct ShareScreenShotView: View {
    let forWhom: String
    let rooms: [RoomModel]
    
    var body: some View {
        ScrollView {
            HStack {
                Text("\(forWhom)를 위해\n준비했어요")
                    .multilineTextAlignment(.leading)
                    .padding(.leading, 23)
                    .padding(.top, 21)
                    .font(.custom("AppleSDGothicNeo-Bold", size: 32))
                Spacer()
            }
            ForEach(rooms, id: \.self) { room in
                VStack (alignment: .leading) {
                    ThemePoster(
                        imageUrl: room.image,
                        genre: room.genre,
                        title: room.title,
                        storeName: room.storeName
                    )
                    DescriptionContainer(description: room.description)
                        .padding(.top, 24)
                }
            }
            .padding(.horizontal, 27)
            .padding(.vertical, 40)
        }
    }
}

struct ShareScreenShotView_Previews: PreviewProvider {
    static var previews: some View {
        ShareScreenShotView(
            forWhom: "룸메즈",
            rooms: [
                RoomModel(
                    storeName: "더와이 방탈출카페",
                    phoneNumber: "054-610-2030",
                    homepage: "https://blog.naver.com/theyescape",
                    image: "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20161007_172%2F1475799670453CuAdA_JPEG%2F176880618076414_6.jpeg",
                    title: "Christmas",
                    star: 4,
                    genre: "코믹",
                    difficulty: 4,
                    activity: 3,
                    horror: 0,
                    description: "오늘은 크리스마스 이브, 설레는 마음으로 선물을 포장하는 당신은 산타클로스다. 소중한 선물의 전달을 시작하고자 벽난로를 통해 첫 번째 집에 들어갔다. 조용히 선물을 두고 돌아가려는 순간, 굴뚝이 벽으로 막혀 버린 것을 발견한 산타! 전세계 어린이들이 기다리고 있고, 이제 시간은 얼마 없다. 차가운 공기로 뒤덮여버린 이 집을 반드시 탈출해야만 한다.",
                    recommendation: "365일 크리스마스를 느끼고 싶은 분"
                ),
                RoomModel(
                    storeName: "더와이 방탈출카페",
                    phoneNumber: "054-610-2030",
                    homepage: "https://blog.naver.com/theyescape",
                    image: "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20161007_183%2F1475799670398EyOql_JPEG%2F176880618076414_5.jpeg",
                    title: "Anti Science",
                    star: 4,
                    genre: "판타지",
                    difficulty: 3,
                    activity: 3,
                    horror: 2,
                    description: "당신은 인공지능 연구소장, 오래전 사고로 가족을 잃고 AI강아지 '네모'를 가족 삼아 지냈다. 그런데 어느날 강아지 '네모'가 실종되었다. AI에 반대하는 테러조직 Anti - Science의 납치가 유력하다. 조직의 본거지에 침투하여 '네모'를 되찾기로 결심한 당신! 과연 무사히 구출할 수 있을 것인가?",
                    recommendation: "전자장비를 이용해 문제를 풀고 싶으신 분, SF물을 좋아하시는 분"
                )
            ]
        )
    }
}

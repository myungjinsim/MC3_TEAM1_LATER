//
//  ThemePoster.swift
//  RoomEscape
//
//  Created by Wonhyuk Choi on 2022/07/28.
//

import SwiftUI

struct ThemePoster: View {
    let imageUrl: String
    let genre: String
    let title: String
    let storeName: String
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 17) {
            AsyncImage(url: URL(string: imageUrl)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                } else if phase.error != nil {
                    Image(systemName: "home")
                } else {
                    Image(systemName: "home")
                }
            }
            .frame(width: 179)
            .cornerRadius(10)
            VStack(alignment: .leading, spacing: 8) {
                Text("\(genre)테마")
                    .font(.custom("AppleSDGothicNeo-Regular", size: 15))
                    .foregroundColor(Color("text4"))
                Text("\(title)")
                    .font(.custom("AppleSDGothicNeo-Bold", size: 32))
                    .lineLimit(2)
                    .truncationMode(.tail)
                    .foregroundColor(Color("text1"))
                HStack (spacing: 4) {
                    Image(systemName: "location.fill")
                        .foregroundColor(Color("Main"))
                    Text(storeName)
                        .font(.custom("AppleSDGothicNeo-Regular", size: 15))
                        .lineLimit(2)
                        .truncationMode(.tail)
                        .foregroundColor(Color("text4"))
                }
            }
        }
        .frame(height: 229, alignment: .leading)
    }
}

struct ThemePoster_Previews: PreviewProvider {
    static var previews: some View {
        ThemePoster(
            imageUrl: "https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20161007_172%2F1475799670453CuAdA_JPEG%2F176880618076414_6.jpeg",
            genre: "코믹",
            title: "Christmas",
            storeName: "더와이 방탈출카페"
        )
        .previewLayout(.sizeThatFits)
    }
}

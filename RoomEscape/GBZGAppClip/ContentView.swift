//
//  ContentView.swift
//  GBZGAppClip
//
//  Created by Noah's Ark on 2022/07/27.
//

import SwiftUI

struct ContentView: View {
    
    var jsonDataManager: JSONDataManager = JSONDataManager()
    
    var body: some View {
        VStack {
            Text("가보자고~")
                .padding()
            
            ForEach(jsonDataManager.roomData, id: \.self) { item in
                Text(item.storeName)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

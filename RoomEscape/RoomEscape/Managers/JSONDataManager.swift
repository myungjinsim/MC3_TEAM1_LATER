//
//  JSONDataManager.swift
//  RoomEscape
//
//  Created by Noah's Ark on 2022/07/18.
//

import Foundation

class JSONDataManager: ObservableObject {
    @Published var storeData: [StoreModel] = []
    static let shared = JSONDataManager()

    init() {
        loadData()
    }
    
    private func loadData() {
        guard let path = Bundle.main.path(forResource: "StoreData", ofType: "json") else {
            return
        }
        guard let storeJSON = try? String(contentsOfFile: path) else {
            return
        }
        
        let decoder = JSONDecoder()
        let data = storeJSON.data(using: .utf8)
        
        guard let data = data,
              let storeData = try? decoder.decode([StoreModel].self, from: data) else {
            return
        }
        self.storeData = storeData
    }
    
}// JSONDataManager

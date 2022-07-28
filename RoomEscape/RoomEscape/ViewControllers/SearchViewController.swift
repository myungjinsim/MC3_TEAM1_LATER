//
//  SearchViewController.swift
//  RoomEscape
//
//  Created by KiWoong Hong on 2022/07/26.
//

import UIKit
import SwiftUI

class SearchViewController: UIViewController, UISearchResultsUpdating {
    
    let roomData = JSONDataManager.shared.roomData
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "SearchResult", bundle: nil)
        let viewController = storyboard.instantiateViewController(identifier: "SearchResultViewController") as? SearchResultViewController
        let searchController = UISearchController(searchResultsController: viewController)
        
        title = "테마 찾기"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        var result: [RoomModel] = []
        let vc = searchController.searchResultsController as? SearchResultViewController
        
        for item in roomData {
            if item.title.uppercased().contains(text.uppercased()) {
          //      print(item.title)
                result.append(item)
            }
        }
        
        if result.count > 0 {
            vc?.searchLabel.text = "'\(text)'에 대한 테마를 찾았어요!"
        } else {
            vc?.searchLabel.text = "'\(text)'에 대한 테마를 찾지 못했어요!"
        }
        vc?.resultRoom = result
    }
}

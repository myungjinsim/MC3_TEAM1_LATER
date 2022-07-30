//
//  SearchDetailResultViewController.swift
//  RoomEscape
//
//  Created by MINJI on 2022/07/26.
//

import UIKit

class SearchDetailResultViewController: UIViewController {
    
    @IBOutlet var locationLabel : UILabel!
    @IBOutlet var difficultyLabel : UILabel!
    @IBOutlet var themeLabel : UILabel!
    @IBOutlet var withLabel : UILabel!
    @IBOutlet weak var resultTableView: UITableView!
    
    let roomDataManager: JSONDataManager = JSONDataManager()
    var searchResultRoomModels: [RoomModel] = []
    var selectedLocation: String = ""
    var selectedDifficulty: String = ""
    var selectedTheme: String = ""
    var selectedWith: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationLabel.text = selectedLocation
        difficultyLabel.text = selectedDifficulty
        themeLabel.text = selectedTheme
        withLabel.text = selectedWith
        
        resultTableView.dataSource = self
        resultTableView.register(UINib(nibName: Constants.roomTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.roomTableViewCell)

        configureSearchResult()
        
    }
    
    private func configureSearchResult() {
        searchResultRoomModels = roomDataManager.roomData.filter { RoomModel in
            RoomModel.location == selectedLocation &&
            RoomModel.genre == selectedTheme
//            RoomModel.difficulty == (selectedDifficulty == "쉬운(1~2)"
//                                     ? 2
//                                     : selectedDifficulty == "보통(3~4)"
//                                        ? 4
//                                        : selectedDifficulty == "어려움(5)"
//                                        ? 5
//                                        : 1
//            )
            
        }
        print(searchResultRoomModels)
    }
}

extension SearchDetailResultViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultRoomModels.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "DetailViewControllerRef") as? DetailViewController else { return }
        
        viewController.roomIndex = indexPath.row
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.roomTableViewCell, for: indexPath) as! RoomTableViewCell
        let roomInfo = searchResultRoomModels[indexPath.row]
        let url = URL(string: roomInfo.image)

        cell.roomName?.text = roomInfo.title
        cell.storeName?.text = roomInfo.storeName
        cell.genre.text = roomInfo.genre
        cell.roomImage?.contentMode = .scaleToFill
        cell.roomImage?.clipsToBounds = true
        
        for i in 0 ..< roomInfo.difficulty {
            cell.difficulties?.arrangedSubviews[i].tintColor = UIColor(named: "star");
        }
        
        DispatchQueue.main.async {
            if let url = url {
                if let data = try? Data(contentsOf: url) {
                    cell.roomImage?.image = UIImage(data: data)
                } else {
                    cell.roomImage?.image = UIImage(systemName: "house")
                }
            }
        }
        
        return cell
    }
}
    

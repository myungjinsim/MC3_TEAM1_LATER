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
    @IBOutlet weak var searchResultCollectionView: UICollectionView!
    
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
        
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.register(
            UINib(nibName: Constants.roomCollectionViewCell, bundle: nil),
            forCellWithReuseIdentifier: Constants.roomCollectionViewCell
        )
        searchResultCollectionView.contentInset = UIEdgeInsets(top: 0, left: 23, bottom: 0, right: 23)

        
        searchResultRoomModels = roomDataManager.roomData.filter { RoomModel in
            RoomModel.storeName == "더패닉 방탈출카페"
        }
        
    }
}

extension SearchDetailResultViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Quantity of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultRoomModels.count
    }
    
    // Size of layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 354)
    }
    
    // Navigation control to the DetailView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "DetailViewControllerRef") as? DetailViewController else { return }
        
        viewController.roomIndex = indexPath.row
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension SearchDetailResultViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.roomCollectionViewCell, for: indexPath) as! RoomCollectionViewCell
        let roomInfo: RoomModel = searchResultRoomModels[indexPath.row]
        let url = URL(string: roomInfo.image)
        
        cell.roomName?.text = roomInfo.title
        cell.storeName?.text = roomInfo.storeName
        cell.roomImage?.contentMode = .scaleToFill
        
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

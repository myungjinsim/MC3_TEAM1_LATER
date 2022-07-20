//
//  HomeViewController.swift
//  RoomEscape
//
//  Created by Noah's Ark on 2022/07/19.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var locationCollectionView: UICollectionView!
    @IBOutlet weak var recommendTableView: UITableView!
    
    let roomDataManager = JSONDataManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CollectionView Setting
        locationCollectionView.delegate = self
        locationCollectionView.dataSource = self
        locationCollectionView.register(UINib(nibName: "RoomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RoomCollectionViewCell")
        locationCollectionView.contentInset = UIEdgeInsets(top: 0, left: 23, bottom: 0, right: 23)
        
        // CollectionView Setting
        recommendTableView.delegate = self
        recommendTableView.dataSource = self
        recommendTableView.register(UINib(nibName: "RoomTableViewCell", bundle: nil), forCellReuseIdentifier: "RoomTableViewCell")
    }
    
}// HomeViewController

// MARK: CollectionView Delegates
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roomDataManager.roomData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let roomInfo = roomDataManager.roomData[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomCollectionViewCell", for: indexPath) as! RoomCollectionViewCell
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 354)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


// MARK: TableView Delegates
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomDataManager.roomData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let roomInfo = roomDataManager.roomData[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTableViewCell", for: indexPath) as! RoomCell
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

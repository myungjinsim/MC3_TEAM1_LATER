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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationCollectionView.delegate = self
        locationCollectionView.dataSource = self
        
        recommendTableView.delegate = self
        recommendTableView.dataSource = self
        recommendTableView.register(UINib(nibName: "RoomCell", bundle: nil), forCellReuseIdentifier: "RoomCell")
    }
    
}// HomeViewController

// MARK: CollectionView Delegates
extension HomeViewController: UICollectionViewDelegate {
    
}// UICollectionViewDelegate

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        cell.setUp(text: "HELLO")
        
        return cell
    }
    
}// UICollectionViewDataSource

// MARK: TableView Delegates
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You Tapped Me!")
    }
    
}// UITableViewDelegate

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sampleRoomArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomCell", for: indexPath) as! RoomCell
        let url = URL(string: sampleRoomArray[indexPath.row].image)

        DispatchQueue.main.async {
            let data = try? Data(contentsOf: url!)
            cell.roomImage?.image = UIImage(data: data!)
        }
        
        return cell
    }

}// UITableViewDataSource

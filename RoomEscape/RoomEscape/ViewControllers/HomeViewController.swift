//
//  HomeViewController.swift
//  RoomEscape
//
//  Created by Noah's Ark on 2022/07/19.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var locationCollectionView: UICollectionView!
    @IBOutlet weak var recommendationCollectionView: UICollectionView!
    @IBOutlet weak var genreRecommendation: UILabel!
    let roomDataManager: JSONDataManager = JSONDataManager()
    var randomRoomModels: [RoomModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Random genres setting
        genreRecommendation.text = Constants.genreCategories[Int.random(in: 0..<Constants.genreCategories.count)]
        
        randomRoomModels = roomDataManager.roomData.filter { RoomModel in
            RoomModel.genre == genreRecommendation.text!.components(separatedBy: " ")[0]
        }
        
        // Collection views setting
        configureRecommendationCollectionView()
    }
    
}// HomeViewController

// MARK: viewDidLoad Configuration Handler
extension HomeViewController {
    
    fileprivate func configureRecommendationCollectionView() {
        
        // LocationCollectionView Setting
        locationCollectionView.delegate = self
        locationCollectionView.dataSource = self
        locationCollectionView.register(
            UINib(nibName: Constants.roomCollectionViewCell, bundle: nil),
            forCellWithReuseIdentifier: Constants.roomCollectionViewCell
        )
        locationCollectionView.contentInset = UIEdgeInsets(top: 0, left: 23, bottom: 0, right: 23)
        
        // RecommendationCollectionView Setting
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
        recommendationCollectionView.register(
            UINib(nibName: Constants.roomRecommendationCollectionViewCell, bundle: nil),
            forCellWithReuseIdentifier: Constants.roomRecommendationCollectionViewCell
        )
        recommendationCollectionView.contentInset = UIEdgeInsets(top: 0, left: 23, bottom: 0, right: 23)
    }
    
}

// MARK: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Quantity of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("🔥 qty")
        print(randomRoomModels.count)
        print(randomRoomModels)
        
        if collectionView == self.locationCollectionView {
            return roomDataManager.roomData.count
        } else {
            return randomRoomModels.count
        }
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
    
}// HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

// MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Room information variable

        
        // CollectionView setting
        if collectionView == self.locationCollectionView {
            let roomInfo = roomDataManager.roomData[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.roomCollectionViewCell, for: indexPath) as! RoomCollectionViewCell
            let url = URL(string: roomInfo.image)
            
            cell.roomName?.text = roomInfo.title
            cell.storeName?.text = roomInfo.storeName
            cell.roomImage?.contentMode = .scaleToFill
            
            for i in 0 ..< roomInfo.star {
                cell.stars?.arrangedSubviews[i].tintColor = UIColor(named: "star");
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
        } else {
            let roomInfo = randomRoomModels[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.roomRecommendationCollectionViewCell, for: indexPath) as! RoomRecommendationCollectionViewCell
            let url = URL(string: roomInfo.image)
            
            cell.roomName?.text = roomInfo.title
            cell.storeName?.text = roomInfo.genre
            cell.roomImage?.contentMode = .scaleToFill
            
            for i in 0 ..< roomInfo.star {
                cell.stars?.arrangedSubviews[i].tintColor = UIColor(named: "star");
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
        
    }// collectionView: cellForItemAt
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let roomInfo = roomDataManager.roomData[indexPath.row]
        guard let recommendedGenre: String = genreRecommendation.text?.components(separatedBy: " ")[0] else { return }
        
        print("🔥 roomInfo.genre")
        print(roomInfo.genre)
        
//        if collectionView == self.recommendationCollectionView,
//           roomInfo.genre != recommendedGenre {
//            cell.isHidden = true
//            cell.isOpaque = true
//            cell.removeFromSuperview()
//        }
        
    }
    
}// HomeViewController: UICollectionViewDataSource

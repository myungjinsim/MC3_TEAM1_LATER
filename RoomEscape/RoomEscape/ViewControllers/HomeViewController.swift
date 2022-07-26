//
//  HomeViewController.swift
//  RoomEscape
//
//  Created by Noah's Ark on 2022/07/19.
//

import UIKit

class HomeViewController: UIViewController {
    // IBOutlet Variables
    @IBOutlet weak var locationCollectionView: UICollectionView!
    @IBOutlet weak var recommendationCollectionView: UICollectionView!
    @IBOutlet weak var recommendationCollectionViewSecond: UICollectionView!
    
    @IBOutlet weak var dimensionImageView: UIImageView!
    
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var currentLocationMenu: UIMenu!
    
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var currentLocationHighlight: UIView!
    @IBOutlet weak var genreRecommendation: UILabel!
    @IBOutlet weak var genreRecommendationSecond: UILabel!
    @IBOutlet weak var firstRecommendationHighlight: UIView!
    @IBOutlet weak var secondRecommendationHighlight: UIView!
    
    // Variables
    let roomDataManager: JSONDataManager = JSONDataManager()
    var randomRoomModels: [RoomModel] = []
    var randomRoomModelsSecond: [RoomModel] = []
    var isCurrentLocationButtonPressed: Bool = false
    
    // viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Random genres setting
        configureGenreRecommendation()
        
        // Delegate setting
        configureDelegateSetting()
        
        // Pull down setting
        configruePulldownButton()

        // Configure other settings
        currentLocationButton.setTitle(Constants.locations[2], for: .normal)
        currentLocationLabel.text = Constants.locations[2] + " 근처"
        dimensionImageView.image = UIImage(named: Constants.mainImageArray[Int.random(in: 0..<Constants.mainImageArray.count)])
        
        randomRoomModels = roomDataManager.roomData.filter { RoomModel in
            RoomModel.genre == genreRecommendation.text!.components(separatedBy: " ")[0]
        }
        randomRoomModelsSecond = roomDataManager.roomData.filter { RoomModel in
            RoomModel.genre == genreRecommendationSecond.text!.components(separatedBy: " ")[0]
        }

    }
    
    // Handling functions
    private func configureGenreRecommendation() {
        genreRecommendation.text = Constants.genreCategories[Int.random(in: 0..<Constants.genreCategories.count)]
        genreRecommendationSecond.text = Constants.genreCategories[Int.random(in: 0..<Constants.genreCategories.count)]
        
        while genreRecommendation.text == genreRecommendationSecond.text {
            genreRecommendation.text = Constants.genreCategories[Int.random(in: 0..<Constants.genreCategories.count)]
            genreRecommendationSecond.text = Constants.genreCategories[Int.random(in: 0..<Constants.genreCategories.count)]
        }
        
        if genreRecommendation.text!.count == 2 {
            firstRecommendationHighlight.frame.size.width = 112
        } else {
            firstRecommendationHighlight.frame.size.width = 140
        }
        
        if genreRecommendationSecond.text!.count == 2 {
            secondRecommendationHighlight.frame.size.width = 112
        } else {
            secondRecommendationHighlight.frame.size.width = 140
        }

    }
    
    private func configureDelegateSetting() {
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
            UINib(nibName: Constants.roomCollectionViewCell, bundle: nil),
            forCellWithReuseIdentifier: Constants.roomCollectionViewCell
        )
        recommendationCollectionView.contentInset = UIEdgeInsets(top: 0, left: 23, bottom: 0, right: 23)

        // RecommendationCollectionViewSecond Setting
        recommendationCollectionViewSecond.delegate = self
        recommendationCollectionViewSecond.dataSource = self
        recommendationCollectionViewSecond.register(
            UINib(nibName: Constants.roomCollectionViewCell, bundle: nil),
            forCellWithReuseIdentifier: Constants.roomCollectionViewCell
        )
        recommendationCollectionViewSecond.contentInset = UIEdgeInsets(top: 0, left: 23, bottom: 0, right: 23)
        
    }
    
    private func configruePulldownButton() {
        currentLocationButton.showsMenuAsPrimaryAction = true
        currentLocationButton.changesSelectionAsPrimaryAction = true
        
        let button1 = UIAction(title: "경주시", handler: { _ in self.changeCurrentLocation(location: "경주시") })
        let button2 = UIAction(title: "대구광역시", handler: { _ in self.changeCurrentLocation(location: "대구광역시") })
        let button3 = UIAction(title: "포항시", handler: { _ in self.changeCurrentLocation(location: "포항시") })

        let buttonMenu = UIMenu(children: [button1, button2, button3])
        
        currentLocationButton.menu = buttonMenu
    }
    
    private func changeCurrentLocation(location: String) {
        currentLocationLabel.text = location + " 근처"
        
        if location.count == 3 {
            currentLocationHighlight.frame.size.width = 84
        } else {
            currentLocationHighlight.frame.size.width = 140
        }

    }
    
}// HomeViewController

// MARK: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // Quantity of items
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {        
        if collectionView == self.locationCollectionView {
            return roomDataManager.roomData.count
        } else if collectionView == self.recommendationCollectionView {
            return randomRoomModels.count
        } else {
            return randomRoomModelsSecond.count
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.roomCollectionViewCell, for: indexPath) as! RoomCollectionViewCell
        var roomInfo: RoomModel? = nil
        
        // CollectionView setting
        if collectionView == self.locationCollectionView {
            roomInfo = roomDataManager.roomData[indexPath.row]
        } else if collectionView == self.recommendationCollectionView {
            roomInfo = randomRoomModels[indexPath.row]
        } else {
            roomInfo = randomRoomModelsSecond[indexPath.row]
        }
        
        let url = URL(string: roomInfo!.image)
        
        cell.roomName?.text = roomInfo!.title
        cell.storeName?.text = roomInfo!.storeName
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

    }// collectionView: cellForItemAt
        
}// HomeViewController: UICollectionViewDataSource


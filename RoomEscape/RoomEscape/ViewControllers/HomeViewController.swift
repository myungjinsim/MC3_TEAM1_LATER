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
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var locationContainerView: UIView!
    @IBOutlet weak var locationPickerView: UIPickerView!
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

        // Configure other settings
        currentLocationButton.setTitle(Constants.locations[0], for: .normal)
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
            UINib(nibName: Constants.roomRecommendationCollectionViewCell, bundle: nil),
            forCellWithReuseIdentifier: Constants.roomRecommendationCollectionViewCell
        )
        recommendationCollectionView.contentInset = UIEdgeInsets(top: 0, left: 23, bottom: 0, right: 23)

        // RecommendationCollectionViewSecond Setting
        recommendationCollectionViewSecond.delegate = self
        recommendationCollectionViewSecond.dataSource = self
        recommendationCollectionViewSecond.register(
            UINib(nibName: Constants.roomRecommendationCollectionViewCellSecond, bundle: nil),
            forCellWithReuseIdentifier: Constants.roomRecommendationCollectionViewCellSecond
        )
        recommendationCollectionViewSecond.contentInset = UIEdgeInsets(top: 0, left: 23, bottom: 0, right: 23)
        
        locationPickerView.delegate = self
        locationPickerView.dataSource = self
    }

    @IBAction func currentLocationButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 0.05,
            animations: {
                self.currentLocationButton.layer.opacity = 0.6
            },
            completion: { _ in
                UIView.animate(withDuration: 0.05) {
                    self.currentLocationButton.layer.opacity = 1
                }
            })
        
        isCurrentLocationButtonPressed.toggle()
        
        if isCurrentLocationButtonPressed == true {
            UIView.animate(withDuration: 0.5,
                animations: {
                self.locationContainerView.layer.opacity = 1
                }
            )
        } else {
            UIView.animate(withDuration: 0.5,
                animations: {
                self.locationContainerView.layer.opacity = 0
                }
            )
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
        } else if collectionView == self.recommendationCollectionView {
            let roomInfo = randomRoomModels[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.roomRecommendationCollectionViewCell, for: indexPath) as! RoomRecommendationCollectionViewCell
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
            let roomInfo = randomRoomModelsSecond[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.roomRecommendationCollectionViewCellSecond, for: indexPath) as! RoomRecommendationCollectionViewCellSecond
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

        }
        
    }// collectionView: cellForItemAt
        
}// HomeViewController: UICollectionViewDataSource

// MARK: UIPickerViewDelegate, UIPickerViewDataSource
extension HomeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.locations.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.locations[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedLocation: String = Constants.locations[row]

        self.currentLocationButton.setTitle(selectedLocation, for: .normal)
        self.currentLocationLabel.text = selectedLocation + " 근처"

        if selectedLocation.count == 3 {
            currentLocationHighlight.frame.size.width = 84
        } else {
            currentLocationHighlight.frame.size.width = 140
        }
    }


}

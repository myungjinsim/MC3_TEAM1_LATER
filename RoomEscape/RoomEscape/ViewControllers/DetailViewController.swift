//
//  DetailViewController.swift
//  RoomEscape
//
//  Created by ICHAN NAM on 2022/07/20.
//

import Foundation

import UIKit

class DetailViewController: UIViewController {
    
    // roomModel은 Optional이 아님
    let roomModel: RoomModel = RoomModel(storeName: "가게 이름", phoneNumber: "전화번호", Homepage: "url", image: "https://blogfiles.pstatic.net/MjAxNzEwMDhfMjA1/MDAxNTA3NDYwODkyODM2.bTbkQeLmYyM_eo1ZB7uUusJ7o8vnxpm4ErDGMNo8oTIg.1CGn9lqXzLPBvjbwBUDeYvsZZLNvRvKZ5ABG_QdUAFUg.JPEG.theyescape/Christmas.jpg?type=w1", title: "테마 이름", star: 3, genre: "장르", difficulty: 5, activity: 5, horror: 5, description: "설명", recommendation: "추천")

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var roomTitle: UILabel!
    @IBOutlet weak var stars: UIStackView!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var difficulty: UILabel!
    @IBOutlet weak var activity: UILabel!
    @IBOutlet weak var horror: UILabel!
    @IBOutlet weak var roomDescription: UILabel!
    @IBOutlet weak var recommendation: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPosterFrom(urlAddress: roomModel.image)
        
        storeName.text = roomModel.storeName
        roomTitle.text = roomModel.title
        genre.text = roomModel.genre
        difficulty.text = String(roomModel.difficulty) + ".0"
        activity.text = String(roomModel.activity) + ".0"
        horror.text = String(roomModel.horror) + ".0"
        roomDescription.text = "  " + roomModel.description
        recommendation.text = roomModel.recommendation
        
        for i in 0 ..< roomModel.star {
            stars.arrangedSubviews[i].tintColor = UIColor(named: "star");
        }
    }
    
    func loadPosterFrom(urlAddress: String) {
        guard let url = URL(string: urlAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.poster.image = loadedImage
                }
            }
        }
    }
    
}

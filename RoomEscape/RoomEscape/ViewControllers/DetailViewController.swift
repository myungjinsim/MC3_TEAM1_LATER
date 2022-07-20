//
//  DetailViewController.swift
//  RoomEscape
//
//  Created by ICHAN NAM on 2022/07/20.
//

import Foundation

import UIKit

class DetailViewController: UIViewController {
    
    var roomIndex: Int = 0
    
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
        
        let roomModel: RoomModel = JSONDataManager.shared.roomData[roomIndex]
        
        loadPosterFrom(urlAddress: roomModel.image)
        
        for i in 0 ..< roomModel.star {
            stars.arrangedSubviews[i].tintColor = UIColor(named: "star");
        }
        
        storeName.text = roomModel.storeName
        roomTitle.text = roomModel.title
        genre.text = roomModel.genre
        difficulty.text = String(roomModel.difficulty) + ".0"
        activity.text = String(roomModel.activity) + ".0"
        horror.text = String(roomModel.horror) + ".0"
        roomDescription.text = "  " + roomModel.description
        recommendation.text = roomModel.recommendation
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

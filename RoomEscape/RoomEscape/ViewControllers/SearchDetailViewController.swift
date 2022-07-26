//
//  SearchDetailViewController.swift
//  RoomEscape
//
//  Created by Hyeon-sang Lee on 2022/07/26.
//

import UIKit

class SearchDetailViewController: UIViewController {

    @IBOutlet weak var giftImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        giftImage.image = UIImage(named: "3dGift")
    }
}

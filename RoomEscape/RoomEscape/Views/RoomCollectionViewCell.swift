//
//  RoomCollectionViewCell.swift
//  RoomEscape
//
//  Created by Hyeon-sang Lee on 2022/07/19.
//

import UIKit

class RoomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var roomImage: UIImageView!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var starImage1: UIImageView!
    @IBOutlet weak var starImage2: UIImageView!
    @IBOutlet weak var starImage3: UIImageView!
    @IBOutlet weak var starImage4: UIImageView!
    @IBOutlet weak var starImage5: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}

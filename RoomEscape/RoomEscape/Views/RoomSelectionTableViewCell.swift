//
//  RoomSelectionTableViewCell.swift
//  RoomEscape
//
//  Created by Wonhyuk Choi on 2022/07/27.
//

import UIKit

class RoomSelectionTableViewCell: UITableViewCell {

    @IBOutlet weak var roomImage: UIImageView!
    @IBOutlet weak var roomName: UILabel!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var stars: UIStackView!
    @IBOutlet weak var selectionCover: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionCover.layer.cornerRadius = 10
        roomImage.layer.cornerRadius = 10
        selectionCover.layer.borderColor = UIColor.mainPurple?.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            selectionCover.layer.borderWidth = 1
            selectionCover.backgroundColor = UIColor(rgb: 0x242424)
        } else {
            selectionCover.layer.borderWidth = 0
            selectionCover.backgroundColor = UIColor.background
        }
    }
    
}

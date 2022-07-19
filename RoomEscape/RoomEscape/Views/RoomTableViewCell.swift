//
//  RoomCell.swift
//  RoomEscape
//
//  Created by Wonhyuk Choi on 2022/07/19.
//

import UIKit

class RoomCell: UITableViewCell {

    @IBOutlet weak var roomImage: UIImageView!
    @IBOutlet weak var targetLabel: UILabel!
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

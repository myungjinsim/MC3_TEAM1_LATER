//
//  TeamCell.swift
//  RoomEscape
//
//  Created by Wonhyuk Choi on 2022/07/19.
//

import UIKit

class TeamCell: UITableViewCell {
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cellContainer: UIView!
    @IBOutlet weak var addImage: UIImageView!
    @IBOutlet weak var addLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellContainer.layer.cornerRadius = cellContainer.bounds.height / 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

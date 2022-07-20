//
//  PickTeamCell.swift
//  RoomEscape
//
//  Created by ICHAN NAM on 2022/07/21.
//

import UIKit

class PickTeamCell: UITableViewCell {
    
    var checked: Bool = false
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var toggle: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        toggle.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
    }
    
    @objc func toggleButtonTapped() {
        
        toggle.configuration?.image = checked ? UIImage(systemName: "square") : UIImage(systemName: "checkmark.square.fill")
        toggle.configuration?.baseForegroundColor = checked ? UIColor.titleWhite : UIColor.mainPurple
        checked.toggle()
    }
}

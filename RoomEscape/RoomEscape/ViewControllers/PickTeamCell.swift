//
//  PickTeamCell.swift
//  RoomEscape
//
//  Created by ICHAN NAM on 2022/07/21.
//

import UIKit

class PickTeamCell: UITableViewCell {
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var toggle: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        toggle.addTarget(self, action: #selector(toggleButtonTapped), for: .touchUpInside)
    }
    
    func isChecked() -> Bool {
        return toggle.configuration?.baseForegroundColor?.accessibilityName
        == UIColor.mainPurple?.accessibilityName ? true : false
    }
    
    @objc func toggleButtonTapped() {
        toggle.configuration?.image = isChecked() ? UIImage(systemName: "square") : UIImage(systemName: "checkmark.square.fill")
        toggle.configuration?.baseForegroundColor = isChecked() ? UIColor.titleWhite : UIColor.mainPurple
    }
}

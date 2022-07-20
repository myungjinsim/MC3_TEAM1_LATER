//
//  HomeCollectionViewCell.swift
//  RoomEscape
//
//  Created by Hyeon-sang Lee on 2022/07/19.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var testLabel: UILabel!
    
    func setUp(text: String) {
        self.testLabel.text = text
        self.testLabel.textColor = .blue
    }
}

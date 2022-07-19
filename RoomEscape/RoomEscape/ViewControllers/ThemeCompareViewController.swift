//
//  ThemeCompareViewController.swift
//  RoomEscape
//
//  Created by KiWoong Hong on 2022/07/18.
//

import UIKit

class ThemeCompareViewController: UIViewController {

    @IBOutlet weak var firstThemeTitle: UILabel!
    @IBOutlet weak var firstThemeImage: UIImageView!
    @IBOutlet weak var firstThemeGenre: UILabel!
    @IBOutlet weak var firstThemeDifficulty: UILabel!
    @IBOutlet weak var firstThemeActivity: UILabel!
    @IBOutlet weak var firstThemeMaxParty: UILabel!
    @IBOutlet weak var firstThemeTimeLimit: UILabel!
    
    @IBOutlet weak var secondThemeTitle: UILabel!
    @IBOutlet weak var secondThemeImage: UIImageView!
    @IBOutlet weak var secondThemeGenre: UILabel!
    @IBOutlet weak var secondThemeDifficulty: UILabel!
    @IBOutlet weak var secondThemeActivity: UILabel!
    @IBOutlet weak var secondThemeMaxParty: UILabel!
    @IBOutlet weak var secondThemeTimeLimit: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

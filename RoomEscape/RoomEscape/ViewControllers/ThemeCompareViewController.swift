//
//  ThemeCompareViewController.swift
//  RoomEscape
//
//  Created by KiWoong Hong on 2022/07/18.
//

import UIKit

class ThemeCompareViewController: UIViewController {
    
    let firstTheme: SampleModel = dummys[0]
    let secondTheme: SampleModel = dummys[1]

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

struct SampleModel {
    let title: String
    let image: String
    let genre: String
    let difficulty: Float
    let activity: String
    let maxParty: Int
    let timeLimit: Int
    let description: String
}
    
var dummys: [SampleModel] {
    [
        SampleModel(title: "낭랑카페", image: "", genre: "미스테리", difficulty: 4.0, activity: "많음", maxParty: 6, timeLimit: 75, description: "안쓰는 디스크립션"),
        SampleModel(title: "안개꽃", image: "", genre: "감성", difficulty: 3.0, activity: "적음", maxParty: 4, timeLimit: 60, description: "안쓰는 디스크립션")
    ]
}

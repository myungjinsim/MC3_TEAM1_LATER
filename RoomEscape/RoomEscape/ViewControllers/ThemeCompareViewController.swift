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

    @IBOutlet weak var firstThemeImage: UIImageView!
    @IBOutlet weak var firstThemeTitle: UILabel!
    @IBOutlet weak var firstThemeStoreName: UILabel!
    @IBOutlet weak var firstThemeStar: UILabel!
    @IBOutlet weak var firstThemeGenre: UILabel!
    @IBOutlet weak var firstThemeDifficulty: UILabel!
    @IBOutlet weak var firstThemeActivity: UILabel!
    @IBOutlet weak var firstThemeHorror: UILabel!
    
    @IBOutlet weak var secondThemeImage: UIImageView!
    @IBOutlet weak var secondThemeTitle: UILabel!
    @IBOutlet weak var secondThemeStoreName: UILabel!
    @IBOutlet weak var secondThemeStar: UILabel!
    @IBOutlet weak var secondThemeGenre: UILabel!
    @IBOutlet weak var secondThemeDifficulty: UILabel!
    @IBOutlet weak var secondThemeActivity: UILabel!
    @IBOutlet weak var secondThemeHorror: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   /*
    private func fetchLabelText() {
        firstThemeTitle.text = firstTheme.title
        firstThemeGenre.text = firstTheme.genre
        firstThemeDifficulty.text = "\(firstTheme.difficulty)"
        firstThemeActivity.text = firstTheme.activity
        firstThemeMaxParty.text = "\(firstTheme.maxParty)명"
        firstThemeTimeLimit.text = "\(firstTheme.timeLimit)분"
        
        secondThemeTitle.text = secondTheme.title
        secondThemeGenre.text = secondTheme.genre
        secondThemeDifficulty.text = "\(secondTheme.difficulty)"
        secondThemeActivity.text = secondTheme.activity
        secondThemeMaxParty.text = "\(secondTheme.maxParty)명"
        secondThemeTimeLimit.text = "\(secondTheme.timeLimit)분"
    }
    
    private func requestImage(url: URL) async throws -> UIImage? {
        let urlRequest = URLRequest(url: url)
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Image Request failed")
        }
        
        let image = UIImage(data: data)
        
        return image
    }
    
    private func fetchPosters() async throws -> Void {
        do {
            firstThemeImage.image = try await requestImage(url: URL(string: firstTheme.image)!)
            secondThemeImage.image = try await requestImage(url: URL(string: secondTheme.image)!)
        } catch {
            print("fetchPosters Error")
        }
    }
    
    private func compareDifficulty() {
        if firstTheme.difficulty > secondTheme.difficulty {
            firstThemeDifficulty.setBetter()
            secondThemeDifficulty.setWorse()
            
        } else if firstTheme.difficulty < secondTheme.difficulty {
            firstThemeDifficulty.setWorse()
            secondThemeDifficulty.setBetter()
            
        } else {
            firstThemeDifficulty.setBetter()
            secondThemeDifficulty.setBetter()
        }
    }
    
    private func compareActivity() {
        let firstActivityLevel = convertToActivityLevel(activity: firstTheme.activity)
        let secondActivityLevel = convertToActivityLevel(activity: secondTheme.activity)
        
        if firstActivityLevel > secondActivityLevel {
            firstThemeActivity.setBetter()
            secondThemeActivity.setWorse()
            
        } else if firstActivityLevel < secondActivityLevel {
            firstThemeActivity.setWorse()
            secondThemeActivity.setBetter()
            
        } else {
            firstThemeActivity.setBetter()
            secondThemeActivity.setBetter()
        }
    }
    
    private func convertToActivityLevel(activity: String) -> Int {
        switch activity {
        case "많음": return 3
        case "중간": return 2
        case "적음": return 1
        default: return 0
        }
    }
    
    private func compareMaxParty() {
        if firstTheme.maxParty > secondTheme.maxParty {
            firstThemeMaxParty.setBetter()
            secondThemeMaxParty.setWorse()
            
        } else if firstTheme.maxParty < secondTheme.maxParty {
            firstThemeMaxParty.setWorse()
            secondThemeMaxParty.setBetter()
            
        } else {
            firstThemeMaxParty.setBetter()
            secondThemeMaxParty.setBetter()
        }
    }
    
    private func compareTimeLimit() {
        if firstTheme.timeLimit > secondTheme.timeLimit {
            firstThemeTimeLimit.setBetter()
            secondThemeTimeLimit.setWorse()
            
        } else if firstTheme.timeLimit < secondTheme.timeLimit {
            firstThemeTimeLimit.setWorse()
            secondThemeTimeLimit.setBetter()
            
        } else {
            firstThemeTimeLimit.setBetter()
            secondThemeTimeLimit.setBetter()
        }
        
    }*/
}

struct SampleModel {
    let title: String
    let image: String
    let storeName: String
    let genre: String
    let description: String
    let difficulty: Float
    let activity: Float
    let horror: Float
    let star: Float
}
    
var dummys: [SampleModel] {
    [
        SampleModel(title: "안개꽃", image: "https://blogfiles.pstatic.net/MjAxNzEwMDhfMjA1/MDAxNTA3NDYwODkyODM2.bTbkQeLmYyM_eo1ZB7uUusJ7o8vnxpm4ErDGMNo8oTIg.1CGn9lqXzLPBvjbwBUDeYvsZZLNvRvKZ5ABG_QdUAFUg.JPEG.theyescape/Christmas.jpg?type=w1", storeName: "C5 포항", genre: "감성", description: "안 개 꽃꼬로로롤로꽃", difficulty: 4.0, activity: 4.0, horror: 3.0, star: 4.1),
        SampleModel(title: "크리스마스", image: "https://blogfiles.pstatic.net/MjAxNzEwMDhfMjA1/MDAxNTA3NDYwODkyODM2.bTbkQeLmYyM_eo1ZB7uUusJ7o8vnxpm4ErDGMNo8oTIg.1CGn9lqXzLPBvjbwBUDeYvsZZLNvRvKZ5ABG_QdUAFUg.JPEG.theyescape/Christmas.jpg?type=w1", storeName: "더와이빙 방탈출카페", genre: "코믹", description: "산을 타고있는 산타크로스", difficulty: 3.0, activity: 5.0, horror: 4.0, star: 4.5)
    ]
}

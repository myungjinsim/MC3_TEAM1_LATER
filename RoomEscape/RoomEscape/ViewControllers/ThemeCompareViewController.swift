//
//  ThemeCompareViewController.swift
//  RoomEscape
//
//  Created by KiWoong Hong on 2022/07/18.
//

import UIKit

class ThemeCompareViewController: UIViewController {
    
    var firstTheme: RoomModel?
    var secondTheme: RoomModel?

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
        fetchThemeData()
        compareValue(firstValue: firstTheme?.star ?? 0, secondValue: secondTheme?.star ?? 0, firstLabel: firstThemeStar, secondLabel: secondThemeStar)
        compareValue(firstValue: firstTheme?.horror ?? 0, secondValue: secondTheme?.horror ?? 0, firstLabel: firstThemeHorror, secondLabel: secondThemeHorror)
        compareValue(firstValue: firstTheme?.activity ?? 0, secondValue: secondTheme?.activity ?? 0, firstLabel: firstThemeActivity, secondLabel: secondThemeActivity)
        compareValue(firstValue: firstTheme?.difficulty ?? 0, secondValue: secondTheme?.difficulty ?? 0, firstLabel: firstThemeDifficulty, secondLabel: secondThemeDifficulty)
    }
    
    private func fetchThemeData() {
        firstThemeTitle.text = firstTheme?.title ?? ""
        firstThemeStoreName.text = firstTheme?.storeName ?? ""
        firstThemeStar.text = "\(firstTheme?.star ?? 0)"
        firstThemeGenre.text = firstTheme?.genre ?? ""
        firstThemeDifficulty.text = "\(firstTheme?.difficulty ?? 0)"
        firstThemeActivity.text = "\(firstTheme?.activity ?? 0)"
        firstThemeHorror.text = "\(firstTheme?.horror ?? 0)"
        
        secondThemeTitle.text = secondTheme?.title ?? ""
        secondThemeStoreName.text = secondTheme?.storeName ?? ""
        secondThemeStar.text = "\(secondTheme?.star ?? 0)"
        secondThemeGenre.text = secondTheme?.genre ?? ""
        secondThemeDifficulty.text = "\(secondTheme?.difficulty ?? 0)"
        secondThemeActivity.text = "\(secondTheme?.activity ?? 0)"
        secondThemeHorror.text = "\(secondTheme?.horror ?? 0)"
        
        Task {
            do {
                try await fetchPosters()
            } catch {
                print("fetchPosters() Error")
            }
        }
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
            firstThemeImage.image = try await requestImage(url: URL(string: firstTheme?.image ?? "")!)
            secondThemeImage.image = try await requestImage(url: URL(string: secondTheme?.image ?? "")!)
        } catch {
            print("fetchPosters Error")
        }
    }
    
    private func compareValue(firstValue: Int, secondValue: Int, firstLabel: UILabel, secondLabel: UILabel) {
        if firstValue > secondValue {
            firstLabel.setBetter()
            secondLabel.setWorse()
        } else if firstValue < secondValue {
            firstLabel.setWorse()
            secondLabel.setBetter()
        } else {
            firstLabel.setBetter()
            secondLabel.setBetter()
        }
    }
   /*
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

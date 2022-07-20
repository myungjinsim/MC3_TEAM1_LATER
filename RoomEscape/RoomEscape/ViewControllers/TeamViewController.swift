//
//  TeamViewController.swift
//  RoomEscape
//
//  Created by Noah's Ark on 2022/07/20.
//

import UIKit

class TeamViewController: UIViewController {
    
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamTableView: UITableView!
    @IBOutlet weak var themeComparisonButton: UIButton!
    @IBOutlet weak var themeComparisonView: UIView!
    @IBOutlet weak var selectedTheme1: UILabel!
    @IBOutlet weak var selectedTheme2: UILabel!
    
    var selectedThemes: [String] = []
    var isButtonPressed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teamNameLabel.text = "룸메즈 입문 추천용"
        selectedTheme1.text = "-"
        selectedTheme2.text = "-"
        
        themeComparisonButton.layer.cornerRadius = 5
        
        teamTableView.delegate = self
        teamTableView.dataSource = self
        teamTableView.register(UINib(nibName: Constants.roomTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.roomTableViewCell)
        
    }
    
    // Make the themeComparisonView disappear when this button is pressed
    @IBAction func themeComparisonButtonPressed(_ sender: UIButton) {
        themeComparisonView.isHidden = true
        self.isButtonPressed = true
    }
    
    
}// TeamViewController

extension TeamViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedCell = tableView.cellForRow(at: indexPath)
        
        selectedThemes.append(sampleRoomArray[indexPath.row].title)
        if selectedTheme1.text == "-" {
            selectedTheme1.text = sampleRoomArray[indexPath.row].title
        } else {
            selectedTheme2.text = sampleRoomArray[indexPath.row].title
        }

    }
}

extension TeamViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // Models/StoreModel 파일에 샘플 데이터 있어요
        return sampleRoomArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.roomTableViewCell, for: indexPath) as! RoomCell

        cell.roomName?.text = sampleRoomArray[indexPath.row].title
        
        return cell
    }
    
}

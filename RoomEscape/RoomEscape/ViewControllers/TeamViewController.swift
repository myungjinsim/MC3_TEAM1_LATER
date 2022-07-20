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
    @IBOutlet weak var infoLabel: UILabel!
    
    var selectedThemes: [String] = []
    var selectedIndexPath: [Int] = []
    var isButtonPressed: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teamNameLabel.text = "룸메즈 입문 추천용"
        
        themeComparisonView.layer.cornerRadius = 5
        themeComparisonButton.layer.cornerRadius = 5
        
        teamTableView.delegate = self
        teamTableView.dataSource = self
        teamTableView.register(UINib(nibName: Constants.roomTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.roomTableViewCell)
        teamTableView.allowsMultipleSelection = true
    }
    
    // Make the themeComparisonView disappear when this button is pressed
    @IBAction func themeComparisonButtonPressed(_ sender: UIButton) {
        self.isButtonPressed = true
        self.themeComparisonButton.isHidden = true
        self.infoLabel.text = "비교해서 보고싶은 2가지 테마를 선택하세요!"
    }
    
    
}// TeamViewController

// MARK: UITableViewDelegate, UITableViewDataSource
extension TeamViewController: UITableViewDelegate {
    // 터치가 비활성화 되었을 경우
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("✅✅✅✅✅✅✅✅")
        print("I thought we were friends.. \(indexPath)")
    }
    
    // 터치가 활성화 되었을 경우
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard isButtonPressed == true else { return }
        guard selectedThemes.count <= 2, selectedIndexPath.count <= 2 else { return }

        selectedThemes.append(sampleRoomArray[indexPath.row].title)
        selectedIndexPath.append(indexPath.row)

        print(selectedThemes)
    }
}

extension TeamViewController: UITableViewDataSource {

    // Models/StoreModel 파일에 샘플 데이터 있어요
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return sampleRoomArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.roomTableViewCell, for: indexPath) as! RoomCell

        cell.roomName?.text = sampleRoomArray[indexPath.row].title
        
        return cell
    }
    
}

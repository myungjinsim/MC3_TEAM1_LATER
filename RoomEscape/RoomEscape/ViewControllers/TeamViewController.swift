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
    let util: Util = Util()
    var cancelButton: UIBarButtonItem?
    var selectedThemes: [Int] = []
    var isButtonPressed: Bool = false
    var team: TeamModel?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
        self.cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        
        themeComparisonView.layer.cornerRadius = 5
        themeComparisonButton.layer.cornerRadius = 5
        
        teamTableView.delegate = self
        teamTableView.dataSource = self
        teamTableView.register(UINib(nibName: Constants.roomTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.roomTableViewCell)
        teamTableView.allowsMultipleSelection = false
    }
    
    private func configureView() {
        guard let team = self.team else { return }
        self.teamNameLabel.text = team.teamName
    }
    
    // Make the themeComparisonView disappear when this button is pressed
    @IBAction func themeComparisonButtonPressed(_ sender: UIButton) {
        teamTableView.allowsMultipleSelection = true
        self.navigationItem.rightBarButtonItem = self.cancelButton
        self.isButtonPressed = true
        self.themeComparisonButton.isHidden = true
        self.infoLabel.text = "비교해서 보고싶은 2가지 테마를 선택하세요!"
    }
    
    @objc func cancelButtonTapped() {
        teamTableView.allowsMultipleSelection = false
        self.navigationItem.rightBarButtonItem = .none
        self.isButtonPressed = false
        self.themeComparisonButton.isHidden = false
        self.infoLabel.text = "테마간 차이점이 궁금하다면?"
        selectedThemes.removeAll()
    }
    
    
}// TeamViewController

// MARK: UITableViewDelegate, UITableViewDataSource
extension TeamViewController: UITableViewDelegate {
    // 터치가 비활성화 되었을 경우
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if isButtonPressed {
            selectedThemes = selectedThemes.filter { $0 != indexPath.row }
        }
    }
    
    // 터치가 활성화 되었을 경우
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isButtonPressed {
            guard selectedThemes.count < 2 else {
                util.showToast(view: self.view, message: "2개 이상 선택할 수 없습니다")
                self.teamTableView.reloadRows(at: [indexPath], with: .automatic)
                return
            }
            selectedThemes.append(indexPath.row)
        } else {
            util.showToast(view: self.view, message: "테마 비교 버튼을 눌러주세요")
            self.teamTableView.reloadRows(at: [indexPath], with: .automatic)
        }
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

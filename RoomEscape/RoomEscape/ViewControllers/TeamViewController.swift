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
    @IBOutlet weak var compareButton: UIButton!
    
    let roomDataManager = JSONDataManager.shared
    
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
        
        self.compareButton.tintColor = UIColor(rgb: 0x464646)
        self.compareButton.isHidden = true
        
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
        self.compareButton.isHidden = false
        
    }
    
    @objc func cancelButtonTapped() {
        teamTableView.allowsMultipleSelection = false
        self.navigationItem.rightBarButtonItem = .none
        self.isButtonPressed = false
        self.themeComparisonButton.isHidden = false
        self.infoLabel.text = "테마간 차이점이 궁금하다면?"
        selectedThemes.removeAll()
        self.compareButton.tintColor = UIColor(rgb: 0x464646)
        self.compareButton.isHidden = true
    }
    
    @IBAction func compareButtonTapped(_ sender: UIButton) {
        if !compareButton.isHidden && compareButton.tintColor == UIColor.mainPurple {
            guard let viewController = self.storyboard?.instantiateViewController(identifier: "ThemeCompareViewControllerRef") as? ThemeCompareViewController else { return }
            
            viewController.firstTheme = roomDataManager.roomData[selectedThemes[0]]
            viewController.secondTheme = roomDataManager.roomData[selectedThemes[1]]
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
    }
    
}// TeamViewController

// MARK: UITableViewDelegate, UITableViewDataSource
extension TeamViewController: UITableViewDelegate {
    // 터치가 비활성화 되었을 경우
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if isButtonPressed {
            guard let theme = team?.themeList[indexPath.row] else { return }
            selectedThemes = selectedThemes.filter { $0 != theme }
            self.compareButton.tintColor = UIColor(rgb: 0x464646)
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
            guard let theme = team?.themeList[indexPath.row] else { return }
            selectedThemes.append(theme)
            if selectedThemes.count == 2 {
                self.compareButton.tintColor = UIColor.mainPurple
            }
        } else {
            util.showToast(view: self.view, message: "테마 비교 버튼을 눌러주세요")
            self.teamTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

extension TeamViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let themes = self.team?.themeList else { return 0 }

        return themes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.roomTableViewCell, for: indexPath) as! RoomCell

        let themes = self.team?.themeList
        guard let themeIdx = themes?[indexPath.row] else { return UITableViewCell() }
        let roomInfo = roomDataManager.roomData[themeIdx]
        
        cell.roomName?.text = roomInfo.title
        let url = URL(string: roomInfo.image)
        cell.storeName?.text = roomInfo.storeName
        cell.roomImage?.contentMode = .scaleToFill
        cell.roomImage?.clipsToBounds = true
        
        for i in 0 ..< roomInfo.star {
            cell.stars?.arrangedSubviews[i].tintColor = UIColor(named: "star");
        }
        
        DispatchQueue.main.async {
            if let url = url {
                if let data = try? Data(contentsOf: url) {
                    cell.roomImage?.image = UIImage(data: data)
                } else {
                    cell.roomImage?.image = UIImage(systemName: "house")
                }
            }
        }
        
        return cell
    }
    
}

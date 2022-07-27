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
    @IBOutlet weak var emptyLabel: UIStackView!
    @IBOutlet weak var emptyButton: UIButton!
    
    let roomDataManager = JSONDataManager.shared
    
    let util: Util = Util()
    var selectedThemes: [Int] = []
    var isButtonPressed: Bool = false
    var team: TeamModel?
    
    var cancelButton : UIBarButtonItem?
    var shareButton : UIBarButtonItem?
    var editButton : UIBarButtonItem?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = ""
        
        cancelButton = UIBarButtonItem(
            title: "취소",
            style: .plain,
            target: self,
            action: #selector(cancelButtonTapped)
        )
        shareButton = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: nil
        )
        editButton = UIBarButtonItem(
            barButtonSystemItem: .compose,
            target: self,
            action: nil
        )
        
        self.configureView()
        
        navigationItem.rightBarButtonItems = [ self.editButton!, self.shareButton!]
        
        themeComparisonView.layer.cornerRadius = 5
        themeComparisonButton.layer.cornerRadius = 10
        
        teamTableView.delegate = self
        teamTableView.dataSource = self
        teamTableView.register(UINib(nibName: Constants.roomTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.roomTableViewCell)
        teamTableView.register(UINib(nibName: Constants.roomSelectionTableViewCell, bundle: nil), forCellReuseIdentifier: Constants.roomSelectionTableViewCell)
        teamTableView.allowsMultipleSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if team?.themeList.isEmpty ?? true {
            teamTableView.isHidden = true
            themeComparisonView.isHidden = true
            emptyLabel.isHidden = false
            emptyButton.isHidden = false
        } else {
            teamTableView.isHidden = false
            themeComparisonView.isHidden = false
            emptyLabel.isHidden = true
            emptyButton.isHidden = true
        }
        
        teamTableView.reloadData()
    }
    
    private func configureView() {
        guard let team = self.team else { return }
        self.teamNameLabel.text = team.teamName
    }
    
    // Make the themeComparisonView disappear when this button is pressed
    @IBAction func themeComparisonButtonPressed(_ sender: UIButton) {
        if isButtonPressed {
            if themeComparisonButton.backgroundColor == UIColor.mainPurple {
                guard let viewController = self.storyboard?.instantiateViewController(identifier: "ThemeCompareViewControllerRef") as? ThemeCompareViewController else { return }
                
                viewController.firstTheme = roomDataManager.roomData[selectedThemes[0]]
                viewController.secondTheme = roomDataManager.roomData[selectedThemes[1]]
                
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        } else {
            teamTableView.allowsMultipleSelection = true
            navigationItem.rightBarButtonItems = [ self.cancelButton!]
            self.isButtonPressed = true
            self.themeComparisonButton.setTitle("비교하기", for: .normal)
            self.themeComparisonButton.backgroundColor = UIColor.titleBlack
            self.infoLabel.text = "원하는 2개의 테마를 비교해요!"
            self.teamTableView.reloadData()
        }
    }
    
    @objc func cancelButtonTapped() {
        navigationItem.rightBarButtonItems = [ self.editButton!, self.shareButton!]
        teamTableView.allowsMultipleSelection = false
        self.isButtonPressed = false
        self.themeComparisonButton.setTitle("테마 비교", for: .normal)
        self.themeComparisonButton.backgroundColor = UIColor.mainPurple
        self.infoLabel.text = "테마간 차이점이 궁금하다면?"
        selectedThemes.removeAll()
        self.teamTableView.reloadData()
    }
    
    @IBAction func findThemeButtonTapped(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 0
    }
    
}// TeamViewController

// MARK: UITableViewDelegate, UITableViewDataSource
extension TeamViewController: UITableViewDelegate {
    // 터치가 비활성화 되었을 경우
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if isButtonPressed {
            guard let theme = team?.themeList[indexPath.row] else { return }
            selectedThemes = selectedThemes.filter { $0 != theme }
            self.themeComparisonButton.backgroundColor = UIColor.titleBlack
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
                self.themeComparisonButton.backgroundColor = UIColor.mainPurple
            }
        } else {
            guard let viewController = self.storyboard?.instantiateViewController(identifier: "DetailViewControllerRef") as? DetailViewController else { return }
            
            guard let theme = team?.themeList[indexPath.row] else { return }
            viewController.roomIndex = theme
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

extension TeamViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let themes = self.team?.themeList else { return 0 }

        return themes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if isButtonPressed {
            let selectionCell = tableView.dequeueReusableCell(withIdentifier: Constants.roomSelectionTableViewCell, for: indexPath) as! RoomSelectionTableViewCell
            
            let themes = self.team?.themeList
            guard let themeIdx = themes?[indexPath.row] else { return UITableViewCell() }
            let roomInfo = roomDataManager.roomData[themeIdx]
            
            selectionCell.roomName?.text = roomInfo.title
            let url = URL(string: roomInfo.image)
            selectionCell.storeName?.text = roomInfo.storeName
            selectionCell.genre.text = roomInfo.genre
            selectionCell.roomImage?.contentMode = .scaleToFill
            selectionCell.roomImage?.clipsToBounds = true
            
            for i in 0 ..< roomInfo.star {
                selectionCell.stars?.arrangedSubviews[i].tintColor = UIColor(named: "star");
            }
            
            DispatchQueue.main.async {
                if let url = url {
                    if let data = try? Data(contentsOf: url) {
                        selectionCell.roomImage?.image = UIImage(data: data)
                    } else {
                        selectionCell.roomImage?.image = UIImage(systemName: "house")
                    }
                }
            }
            
            return selectionCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.roomTableViewCell, for: indexPath) as! RoomTableViewCell
            
            let themes = self.team?.themeList
            guard let themeIdx = themes?[indexPath.row] else { return UITableViewCell() }
            let roomInfo = roomDataManager.roomData[themeIdx]
            
            cell.roomName?.text = roomInfo.title
            let url = URL(string: roomInfo.image)
            cell.storeName?.text = roomInfo.storeName
            cell.genre.text = roomInfo.genre
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
    
}

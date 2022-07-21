//
//  PickSheetViewController.swift
//  RoomEscape
//
//  Created by ICHAN NAM on 2022/07/21.
//

import UIKit

class PickSheetViewController: UIViewController {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var teams = [TeamModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.loadTeams()
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadTeams()
        self.tableView.reloadData()
    }
    
    func loadTeams() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "teams") as? [[String: Any]] else { return }
        self.teams = data.compactMap {
            guard let title = $0["teamName"] as? String else { return nil }
            guard let themeList = $0["themeList"] as? [Int] else { return nil }
            return TeamModel(teamName: title, themeList: themeList)
        }
    }
    
    @objc func saveButtonTapped() {
        var updatedTeams = [TeamModel]()
        
        if let detailPickSheetViewController = self.parent as? DetailPickSheetViewController {
            let roomIndex: Int = detailPickSheetViewController.roomIndex
            
            for i in 0 ..< teams.count {
                let tableViewCell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! PickTeamCell

                if tableViewCell.checked {
                    if let _ = teams[i].themeList.firstIndex(of: roomIndex) {
                        updatedTeams.insert(teams[i], at: updatedTeams.count)
                    } else {
                        var list = teams[i].themeList
                        list.insert(roomIndex, at: 0)
                        updatedTeams.insert(TeamModel(teamName: teams[i].teamName, themeList: list), at: updatedTeams.count)
                    }
                    
                    if let parentView = self.parent {
                        guard let text = tableViewCell.teamName.text else { return }
                        Util.shared.showToast(view: parentView.view, message: "'\(text)'팀에 추가되었습니다")
                    }
                    
                } else {
                    if let index = teams[i].themeList.firstIndex(of: roomIndex) {
                        var list = teams[i].themeList
                        list.remove(at: index)
                        updatedTeams.insert(TeamModel(teamName: teams[i].teamName, themeList: list), at: updatedTeams.count)
                    } else {
                        updatedTeams.insert(teams[i], at: updatedTeams.count)
                    }
                }
            }
            
        }
        
        let data = updatedTeams.map {
            [
                "teamName": $0.teamName,
                "themeList": $0.themeList
            ]
        }
        
                
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "teams")
        
        if let detailPickSheetViewController = self.parent as? DetailPickSheetViewController {
            detailPickSheetViewController.hidePickSheetAndGoBack()
        }
    }
    
}

extension PickSheetViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PickTeamCell", for: indexPath) as? PickTeamCell else { return UITableViewCell() }
    
        cell.teamName.text = teams[indexPath.row].teamName
        
        if let detailPickSheetViewController = self.parent as? DetailPickSheetViewController {
            let roomIndex: Int = detailPickSheetViewController.roomIndex
            
            if let _ = teams[indexPath.row].themeList.firstIndex(of: roomIndex) {
                cell.toggle.configuration?.image = UIImage(systemName: "checkmark.square.fill")
                cell.toggle.configuration?.baseForegroundColor = UIColor.mainPurple
            } else {
                cell.toggle.configuration?.image = UIImage(systemName: "square")
                cell.toggle.configuration?.baseForegroundColor = UIColor.titleWhite
            }
        }
        
        return cell
    }
}

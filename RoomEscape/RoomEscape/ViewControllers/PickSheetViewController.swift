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
        
        return cell
    }
}

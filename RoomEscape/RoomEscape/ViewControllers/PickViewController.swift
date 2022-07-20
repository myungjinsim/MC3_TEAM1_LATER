//
//  PickViewController.swift
//  RoomEscape
//
//  Created by Wonhyuk Choi on 2022/07/18.
//

import UIKit

class PickViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var teams = [TeamModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.loadTeams()
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
}

extension PickViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as? TeamCell else { return UITableViewCell() }
        
        if indexPath.row == teams.count {
            cell.teamName.text = ""
            cell.descriptionLabel.text = ""
            cell.addImage.image = UIImage(systemName: "plus")
            cell.addLabel.text = "새로운 팀 만들기"
        } else {
            cell.teamName.text = teams[indexPath.row].teamName
            cell.descriptionLabel.text = "\(teams[indexPath.row].themeList.count)개의 방탈출 테마"
            cell.addImage.image = .none
            cell.addLabel.text = ""
        }
        
        return cell
    }
}

extension PickViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == teams.count {
            guard let viewController = self.storyboard?.instantiateViewController(identifier: "MakeTeamViewController") as? MakeTeamViewController else { return }
            viewController.teams = self.teams
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            guard let viewController = self.storyboard?.instantiateViewController(identifier: "TeamViewControllerRef") as? TeamViewController else { return }
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

//
//  PickViewController.swift
//  RoomEscape
//
//  Created by Wonhyuk Choi on 2022/07/18.
//

import UIKit

class PickViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let teams = ["My PICK!", "룸메즈 입문 추천용"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
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
            cell.teamName.text = teams[indexPath.row]
            cell.descriptionLabel.text = "4개의 방탈출 테마"
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
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            guard let viewController = self.storyboard?.instantiateViewController(identifier: "TeamViewControllerRef") as? TeamViewController else { return }
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

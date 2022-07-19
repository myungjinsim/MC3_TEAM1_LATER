//
//  PickViewController.swift
//  RoomEscape
//
//  Created by Wonhyuk Choi on 2022/07/18.
//

import UIKit

class PickViewController: UIViewController {
    
    @IBOutlet weak var pickTableView: UITableView!
    
    let teams = ["My PICK!", "룸메즈 입문 추천용"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickTableView.dataSource = self
        self.pickTableView.delegate = self
        
        pickTableView.register(UINib(nibName: "RoomTableViewCell", bundle: nil), forCellReuseIdentifier: "RoomTableViewCell")
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        self.pickTableView.reloadData()
    }
}

extension PickViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickCell", for: indexPath) as UITableViewCell
        
        return cell
    }
}

extension PickViewController: UITableViewDelegate {
    
}

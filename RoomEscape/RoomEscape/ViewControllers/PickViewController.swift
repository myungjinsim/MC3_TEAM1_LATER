//
//  PickViewController.swift
//  RoomEscape
//
//  Created by Wonhyuk Choi on 2022/07/18.
//

import UIKit

class PickViewController: UIViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var pickTableView: UITableView!
    
    let firstArray = ["One", "Two", "Three"]
    let secondArray = ["1", "2", "3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickTableView.dataSource = self
        self.pickTableView.delegate = self
        segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        self.pickTableView.reloadData()
    }
}

extension PickViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentControl.selectedSegmentIndex == 0 {
            return firstArray.count
        } else if segmentControl.selectedSegmentIndex == 1 {
            return secondArray.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickCell", for: indexPath) as UITableViewCell
        
        if segmentControl.selectedSegmentIndex == 0 {
            cell.textLabel?.text = firstArray[indexPath.row]
        } else if segmentControl.selectedSegmentIndex == 1 {
            cell.textLabel?.text = secondArray[indexPath.row]
        }
        
        return cell
    }
}

extension PickViewController: UITableViewDelegate {
    
}

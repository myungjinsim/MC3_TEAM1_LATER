//
//  SearchResultViewController.swift
//  RoomEscape
//
//  Created by KiWoong Hong on 2022/07/27.
//

import UIKit

class SearchResultViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var table: UITableView!
    
    var resultRoom: [RoomModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

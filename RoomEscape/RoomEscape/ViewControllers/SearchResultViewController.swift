//
//  SearchResultViewController.swift
//  RoomEscape
//
//  Created by KiWoong Hong on 2022/07/27.
//

import UIKit

class SearchResultViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var resultRooms: [RoomModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tableViewCellNib = UINib(nibName: Constants.roomTableViewCell, bundle: nil)
        tableView.register(tableViewCellNib, forCellReuseIdentifier: Constants.roomTableViewCell)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func update(newResult: [RoomModel]) {
        if resultRooms == newResult {
        } else {
            resultRooms = newResult
            tableView.reloadData()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Detail", bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(identifier: "DetailViewControllerRef") as? DetailViewController else { return }
        
        detailViewController.roomIndex = indexPath.row
        /*
         MARK: 현재 SearchResultViewController가 UINavigationController(navigationController?)가 비어있는 값을 반환해 pushViewController가 안되는 것으로 보임(아마도???)
         */
        /*
        let rootVC = self
        let navCV = UINavigationController(rootViewController: rootVC)
        navCV.pushViewController(detailViewController, animated: true)
         */
  //      self.navigationController?.pushViewController(detailViewController, animated: true)
     //   self.navigationController?.present(detailViewController, animated: true)
        self.present(detailViewController, animated: true)
    }
}

extension SearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return resultRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RoomTableViewCell", for: indexPath) as? RoomTableViewCell else { return UITableViewCell() }
        
        let roomInfo = resultRooms[indexPath.row]
        let url = URL(string: roomInfo.image)
        
        cell.roomName?.text = roomInfo.title
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

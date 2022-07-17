//
//  CartViewController.swift
//  RoomEscape
//
//  Created by Wonhyuk Choi on 2022/07/18.
//

import UIKit

class CartViewController: UIViewController {
    
    @IBOutlet weak var myThemeView: UIView!
    @IBOutlet weak var teamView: UIView!
    @IBOutlet weak var segmentedControlButton: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myThemeView.alpha = 1
        teamView.alpha = 0
        segmentedControlButton.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmentedControlButton.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    }
    
    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            myThemeView.alpha = 1
            teamView.alpha = 0
        } else {
            myThemeView.alpha = 0
            teamView.alpha = 1
        }
    }
    
}

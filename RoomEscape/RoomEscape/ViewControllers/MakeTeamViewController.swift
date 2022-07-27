//
//  MakeTeamViewController.swift
//  RoomEscape
//
//  Created by Wonhyuk Choi on 2022/07/20.
//

import UIKit

class MakeTeamViewController: UIViewController {
    
    @IBOutlet weak var teamNameField: CustomTextField!
    @IBOutlet weak var makeButton: UIButton!
    
    var teams = [TeamModel]() {
        didSet {
            self.saveTeams()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.teamNameField.delegate = self
        self.makeButton.tintColor = UIColor.background2
        
        self.teamNameField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func saveTeams() {
        let data = self.teams.map {
            [
                "teamName": $0.teamName,
                "themeList": $0.themeList
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(data, forKey: "teams")
    }

    @objc func textFieldDidChange(sender: UITextField) {
        if sender.hasText {
            makeButton.tintColor = UIColor.mainPurple
            
        } else {
            makeButton.tintColor = UIColor(rgb: 0x464646)
        }
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        teamNameField.resignFirstResponder()
    }
    
    @IBAction func makeButtonTapped(_ sender: UIButton) {
        if makeButton.tintColor == UIColor.mainPurple {
            guard let teamName = self.teamNameField.text else { return }
            let team = TeamModel(teamName: teamName, themeList: [Int]())
            self.teams.append(team)
            print(self.teams)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension MakeTeamViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

class CustomTextField: UITextField {

    override func layoutSubviews() {
        super.layoutSubviews()

        for view in subviews {
            if let button = view as? UIButton {
                button.setImage(button.image(for: .normal)?.withRenderingMode(.alwaysTemplate), for: .normal)
                button.tintColor = UIColor(rgb: 0x8E8E93)
            }
        }
    }
}

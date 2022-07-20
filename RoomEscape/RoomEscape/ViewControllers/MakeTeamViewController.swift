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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.teamNameField.delegate = self
        self.makeButton.tintColor = UIColor(rgb: 0x464646)
        
        self.teamNameField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }

    @objc func textFieldDidChange(sender: UITextField) {
        if sender.hasText {
            makeButton.tintColor = UIColor(rgb: 0x7B61FF)
        } else {
            makeButton.tintColor = UIColor(rgb: 0x464646)
        }
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        teamNameField.resignFirstResponder()
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

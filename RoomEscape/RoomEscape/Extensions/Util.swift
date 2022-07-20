//
//  Util.swift
//  RoomEscape
//
//  Created by Noah's Ark on 2022/07/21.
//

import Foundation
import UIKit

struct Util {
    static let shared = Util()
    
    func showToast(view: UIView, message: String) {
        let toastLabel = UILabel(frame: CGRect(
            x: view.frame.size.width / 2 - 100,
            y: view.frame.size.height - 750,
            width: 200,
            height: 35)
        )
        
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        
        view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }

}

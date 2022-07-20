//
//  DetailViewController.swift
//  RoomEscape
//
//  Created by ICHAN NAM on 2022/07/20.
//

import Foundation

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var themeTitle: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var maxParty: UILabel!
    @IBOutlet weak var activity: UILabel!
    @IBOutlet weak var timeLimit: UILabel!
    @IBOutlet weak var themeDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeName.text = "세븐클루스 강남1호점"
        themeTitle.text = "룸 401"
        genre.text = "스릴러"
        maxParty.text = "3" + "명"
        activity.text = "적음"
        timeLimit.text = "60" + "분"
        themeDescription.text = "  " + "수진이의 생일인 크리스마스 이브날 모텔에서 준비해준 축하 와인과 함께 즐거운 생일파티를 하며 밤을 보낸 후 아침에 눈을 떠보니 수진이는 사라져있고..... 주변을 살펴보니 휴대폰은 사라져 있고 탁자 위 전화기도 신호가 가지 않는다. 방문은 잠겨있고 소리쳐도 아무런 대답도 들을 수 없다... 만약 수진이에게 무슨 일이 있었다면? 우린 무사히 모텔을 탈출할 수 있을까?"
    }
    
}

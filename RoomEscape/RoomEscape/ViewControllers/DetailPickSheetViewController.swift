//
//  DetailPickSheetView.swift
//  RoomEscape
//
//  Created by ICHAN NAM on 2022/07/21.
//

import UIKit

class DetailPickSheetViewController: UIViewController {
    
    private let contentViewController: UIViewController
    
    init(contentViewController: UIViewController) {
        self.contentViewController = contentViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        return view
    }()
    
    private let pickSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    private var pickSheetViewTopConstraint: NSLayoutConstraint!
    
    var defaultHeight: CGFloat = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
        dimmedView.addGestureRecognizer(dimmedTap)
        dimmedView.isUserInteractionEnabled = true
    }
    
    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
        hidePickSheetAndGoBack()
    }
    
    func hidePickSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        
        pickSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showPickSheet()
    }
    
    private func setupUI() {
        view.addSubview(dimmedView)
        view.addSubview(pickSheetView)
        
        addChild(contentViewController)
        pickSheetView.addSubview(contentViewController.view)
        
        dimmedView.alpha = 0.0
        
        setupLayout()
    }
    
    private func showPickSheet() {
        let safeAreaHeight: CGFloat = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding: CGFloat = view.safeAreaInsets.bottom
        
        pickSheetViewTopConstraint.constant = (safeAreaHeight + bottomPadding) - defaultHeight
        
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
            self.dimmedView.alpha = 0.7
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func setupLayout() {
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        pickSheetView.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        pickSheetViewTopConstraint = pickSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
        
        NSLayoutConstraint.activate([
            pickSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            pickSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            pickSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pickSheetViewTopConstraint
        ])
        
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentViewController.view.topAnchor.constraint(equalTo: pickSheetView.topAnchor),
            contentViewController.view.leadingAnchor.constraint(equalTo: pickSheetView.leadingAnchor),
            contentViewController.view.trailingAnchor.constraint(equalTo: pickSheetView.trailingAnchor),
            contentViewController.view.bottomAnchor.constraint(equalTo: pickSheetView.bottomAnchor)
        ])
    }
}

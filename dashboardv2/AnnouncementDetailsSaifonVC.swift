//
//  AnnouncementDetailsSaifonVC.swift
//  dashboardKB
//
//  Created by Hainizam on 12/04/2018.
//  Copyright © 2018 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class AnnouncementDetailsSaifonVC: UIViewController {
    
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
       return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.updateStatusBarColor()
        setupTableView()
        setupNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = preferredStatusBarStyle
    }
    
    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 150.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
    }
    
    private func setupNavigationBar() {
        navigationBar.delegate = self
        navigationBar.barTintColor = UIColor.lightPurple
        navigationBar.isTranslucent = false
        navigationBar.tintColor = UIColor.white
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        
        let textShadow = NSShadow.init()
        textShadow.shadowColor = UIColor.black
        textShadow.shadowOffset = CGSize(width: 0, height: 1)
        navigationBar.titleTextAttributes = [NSAttributedStringKey.shadow: textShadow,
                                             NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    
    private func changeStatusBarColor() {
       
    }
    
    @IBAction func didTappedDoneButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension AnnouncementDetailsSaifonVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell") else { return UITableViewCell() }
        
        return cell
    }
}

extension AnnouncementDetailsSaifonVC: UINavigationBarDelegate {
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}


















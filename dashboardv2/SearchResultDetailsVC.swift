//
//  SearchResultDetailsVC.swift
//  dashboardKB
//
//  Created by Hainizam on 14/06/2017.
//  Copyright © 2017 Ingeniworks Sdn Bhd. All rights reserved.
//

import UIKit

class SearchResultDetailsVC: UIViewController {

    struct Storyboard {
        
        static let AboutCell = "aboutCell"
        static let DetailsCell = "detailsCell"
        static let PhotoCell = "photoCell"
    }
    
    private let tableHeaderViewHeight: CGFloat = 250.0
    private let tableHeaderViewCutaway: CGFloat = 20.0
    
    @IBOutlet weak var tableView: UITableView!
    
    var headerView: HeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerView = tableView.tableHeaderView as! HeaderView
        
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150.0
        
        let effectiveHeight: CGFloat = tableHeaderViewHeight
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        
        updateHeaderView()
    }
    
    func updateHeaderView() {
        
        let effectiveHeight: CGFloat = tableHeaderViewHeight //- tableHeaderViewCutaway / 2
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: tableHeaderViewHeight)
        
        if tableView.contentOffset.y < -effectiveHeight {
            
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y //+ tableHeaderViewCutaway / 2
        }
        
        headerView.frame = headerRect
        
        //let path = UIBezierPath()
        //path.move(to: CGPoint(x: 0, y: 0))
        //path.addLine(to: CGPoint(x: headerRect.width, y: 0))
        //path.addLine(to: CGPoint(x: headerRect.width, y: headerRect.height))
        //path.addLine(to: CGPoint(x: headerRect.width / 2, y: headerRect.height - tableHeaderViewCutaway))
        //path.addLine(to: CGPoint(x: 0, y: headerRect.height))
        
        //headerViewMaskLayer?.path = path.cgPath
    }
}

extension SearchResultDetailsVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //var cell: UITableViewCell?
        let index = indexPath.item
        
        if index == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.DetailsCell, for: indexPath) as! SearchResultDetailsCell
            
            return cell
        } else if index == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.PhotoCell, for: indexPath) as! SearchResultDetailsCell
            
            return cell
        } else if index == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Storyboard.AboutCell, for: indexPath) as! SearchResultDetailsCell
            
            cell.aboutString = "Go..!"
            
            return cell
        } else {
            
            return UITableViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        updateHeaderView()
    }
}































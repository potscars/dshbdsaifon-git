//
//  MessageControlTableViewController.swift
//  Mail
//
//  Created by Ingeniworks Puchong on 08/03/2017.
//  Copyright © 2017 Ingeniworks Puchong. All rights reserved.
//

import UIKit

class MessageControlTableViewController: UITableViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        print("Selected Row = \(indexPath.description)")
    }

}

//
//  AddViewController.swift
//  Mail
//
//  Created by Ingeniworks Puchong on 09/03/2017.
//  Copyright © 2017 Ingeniworks Puchong. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let someButton: UIButton = UIButton.init()
        someButton.titleLabel?.text = "Add"
        someButton.target(forAction: #selector(addSelector(sender:)), withSender: self)
        
        let someButtonItem: UIBarButtonItem = UIBarButtonItem.init(customView: someButton)
        
        self.navigationController?.navigationItem.leftBarButtonItem = someButtonItem

        
    }
    
    func addSelector(sender: UIButton)
    {
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

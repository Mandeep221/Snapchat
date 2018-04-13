//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Mandeep Sarangal on 2018-04-12.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        performSegue(withIdentifier: "addSnapSegue", sender: nil)
    }
}

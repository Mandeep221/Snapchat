//
//  ViewSnapViewController.swift
//  Snapchat
//
//  Created by Mandeep Sarangal on 2018-04-13.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit
import SDWebImage

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var snapDescription: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        snapDescription.text = snap.description
        //imageView.sd_setImage(with: URL(string : snap.imageUrl))
    }

}

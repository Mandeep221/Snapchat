//
//  SelectUserViewController.swift
//  Snapchat
//
//  Created by Mandeep Sarangal on 2018-04-13.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit
import Firebase

class SelectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var imageUrl = ""
    var descript = ""
    
    // array of users
    var users : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // get snapshot for child added
        Database.database().reference().child("users").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
        
            let user = User()
            user.email  = (snapshot.value as? NSDictionary)?["email"] as? String ?? ""
            user.uid = snapshot.key

            self.users.append(user)
            
            self.tableView.reloadData()
        
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        cell.textLabel?.text = user.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        
        // create a snap dictionary
        let snap = ["from" : user.email, "description" : descript, "imageUrl" : imageUrl]
        
        // push the snap in firebase
        Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        
        // go back
        navigationController?.popToRootViewController(animated: true)
    }
    
}

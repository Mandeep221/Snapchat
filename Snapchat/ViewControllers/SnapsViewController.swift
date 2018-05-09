//
//  SnapsViewController.swift
//  Snapchat
//
//  Created by Mandeep Sarangal on 2018-04-12.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var snaps : [Snap] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // get snapshot for child added
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childAdded, with: {(snapshot) in
            print(snapshot)
            
            let snap = Snap()
            snap.imageUrl  = (snapshot.value as? NSDictionary)?["imageUrl"] as? String ?? ""
            snap.description  = (snapshot.value as? NSDictionary)?["description"] as? String ?? ""
            snap.from  = (snapshot.value as? NSDictionary)?["from"] as? String ?? ""
            
            self.snaps.append(snap)
            
            self.tableView.reloadData()
            
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snaps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let snap = snaps[indexPath.row]
        cell.textLabel?.text = snap.from
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "viewSnapSegue", sender: snap)
        
//        // create a snap dictionary
//        let snap = ["from" : user.email, "description" : descript, "imageUrl" : imageUrl]
//
//        // push the snap in firebase
//        Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSnapSegue"
        {
            let nextVc = segue.destination as! ViewSnapViewController
            nextVc.snap = sender as! Snap
        }
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        try! Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        performSegue(withIdentifier: "addSnapSegue", sender: nil)
    }
}

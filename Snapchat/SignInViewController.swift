//
//  ViewController.swift
//  Snapchat
//
//  Created by Mandeep Sarangal on 2018-04-12.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    
    @IBOutlet weak var userId: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: self.userId.text!, password: self.password.text!) { (user, error) in
            
            print("We tried to sign in")
            
            if error != nil{
                print("Sign in failed")
                Auth.auth().createUser(withEmail: self.userId.text!, password: self.password.text!, completion: { (user, error) in
                    
                    print("We tried to create a user")
                    
                    if error != nil{
                        print("New user ceation error")
                    }else{
                        print("New user ceated successfully")
                        self.performSegue(withIdentifier: "signinsegue", sender: nil)
                    }
                })
            }else{
                print("Sign in successful")
                self.performSegue(withIdentifier: "signinsegue", sender: nil)
            }
        }
    }
    
}


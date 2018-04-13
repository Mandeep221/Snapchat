//
//  PictureViewController.swift
//  Snapchat
//
//  Created by Mandeep Sarangal on 2018-04-12.
//  Copyright © 2018 Mandeep Sarangal. All rights reserved.
//

import UIKit
import Firebase

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var descriptionText: UITextField!
    
    // image picker to pick image from library or take a new pic
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // image picker is going to use these Interfaces
        imagePicker.delegate = self
        
        // Do any additional setup after loading the view.
    }

    @IBAction func cameraTapped(_ sender: Any) {
        // set image source
        imagePicker.sourceType = .photoLibrary
        
        //open the image brwoser screen
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        // set the image to imageview
        imageView.image = selectedImage
        imageView.backgroundColor = UIColor.clear
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    

    @IBAction func nextTapped(_ sender: Any) {
        nextButton.isEnabled = false
        let imagesFolder = Storage.storage().reference().child("images")
        
        let imageData = UIImageJPEGRepresentation(imageView.image!, 0.1)
        
        imagesFolder.child("\(NSUUID().uuidString).jpg").putData(imageData!, metadata: nil) { (metadata, error) in
            print("We tried to upload")
            if error != nil{
                print("We had an error")
            }else{
                print("Success")
                self.nextButton.isEnabled = true
                self.performSegue(withIdentifier: "selectUserSegue", sender: nil)
            }
        }
    }
}

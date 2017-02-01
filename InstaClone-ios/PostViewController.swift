//
//  PostViewController.swift
//  InstaClone-ios
//
//  Created by Pourpre on 2/1/17.
//  Copyright © 2017 Pourpre. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    //--------------------------------------
    //MARK: - Variable declaration
    //--------------------------------------
    
    var activityIndicator = UIActivityIndicatorView()

    @IBOutlet weak var postImageLbl: UIButton!
    
    //--------------------------------------
    //MARK: - Function declaration
    //--------------------------------------
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            imageToPost.image = image
            
        }
        
        self.dismiss(animated: true, completion: nil)
    
    }

    func createAlert(title: String, message: String ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            
            alert.dismiss(animated: true, completion: nil)
        
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //--------------------------------------
    //MARK: - IBOutlet declaration
    //--------------------------------------
    
    @IBOutlet weak var imageToPost: UIImageView!
    @IBOutlet weak var messageTextField: UITextField!
    
    
    //--------------------------------------
    //MARK: - IBAction declaration
    //--------------------------------------
    
    @IBAction func chooseAnImageBtn(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = false
        
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func postImageBtn(_ sender: UIButton) {
        
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let post = PFObject(className: "Posts")
        
        post["message"] = messageTextField.text
        
        post["userID"] = PFUser.current()?.objectId
        
        let imageData = UIImageJPEGRepresentation(imageToPost.image!, 1.0)
        
        let imageFile = PFFile(name: "image.png", data: imageData!)
        
        post["imageFile"] = imageFile
        
        post.saveInBackground { (success, error) in
            
            self.activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            
            if error != nil {
                
                self.createAlert(title: "Could not post image", message: "Please try again later")
    
            } else {
             
                self.createAlert(title: "Image posted", message: "Your image has been posted succefully")
                
                self.messageTextField.text = ""
                
                self.imageToPost.image = UIImage(named: "PersonIcon.png")
            }
        }
    }
    
    
    //--------------------------------------
    //MARK: - Override Function declaration
    //--------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        postImageLbl.layer.cornerRadius = 5.0
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

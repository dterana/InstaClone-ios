//
//  ViewController.swift
//  InstaClone-ios
//
//  Created by Pourpre on 1/30/17.
//  Copyright © 2017 Pourpre. All rights reserved.
//

import UIKit

import Parse

class ViewController: UIViewController {
    
    //--------------------------------------
    //MARK: - Variable declaration
    //--------------------------------------
    
    var signupMode = true
    
    var activityIndicator = UIActivityIndicatorView()
    
    
    //--------------------------------------
    //MARK: - Function declaration
    //--------------------------------------
    
    func createAlert(title: String, message: String ) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            self.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //--------------------------------------
    //MARK: - IBOutlet declaration
    //--------------------------------------
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupOrLoginLbl: UIButton!
    @IBOutlet weak var changeSignupModeLbl: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    //--------------------------------------
    //MARK: - IBAction declaration
    //--------------------------------------
    
    @IBAction func signupOrLoginBtn(_ sender: UIButton) {
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            
            createAlert(title: "Error in form", message: "Please enter an email and password")
            
        } else {
            
            activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            if signupMode {
                
                //Sign Up
                
                let user = PFUser()
                
                user.username = emailTextField.text
                user.email = emailTextField.text
                user.password = passwordTextField.text
                
                user.signUpInBackground(block: { (success, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        
                        var displayErrorMessage = "Please try again later."
                        
                        if let errorMessage = error as NSError? {
                            
                            displayErrorMessage = errorMessage.userInfo["error"] as! String
                            
                        }
                        
                        self.createAlert(title: "Signup Error", message: displayErrorMessage)
                        
                    } else {
                        
                        //Sign up successful
                        self.performSegue(withIdentifier: "showUserTableSegue", sender: self)
        
                    }
                    
                })
                
            } else {
                
                //Log In
                
                PFUser.logInWithUsername(inBackground: emailTextField.text!, password: passwordTextField.text!, block: { (user, error) in
                    
                    self.activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if error != nil {
                        
                        var displayErrorMessage = "Please try again later."
                        
                        if let errorMessage = error as NSError? {
                            
                            displayErrorMessage = errorMessage.userInfo["error"] as! String
                            
                        }
                        
                        self.createAlert(title: "Login Error", message: displayErrorMessage)
                        
                    } else {
                        
                        //Log in successful
                        self.performSegue(withIdentifier: "showUserTableSegue", sender: self)
                        
                        
                    }

                    
                })
            }
        }
        
    }
    
    
    @IBAction func changeSignupModeBtn(_ sender: UIButton) {
        if (signupMode) {
            
            //Change login mode
            signupOrLoginLbl.setTitle("Log In", for: [])
            
            changeSignupModeLbl.setTitle("Sign Up", for: [])
            
            messageLabel.text = "Don't have an account?"
            
            signupMode = false
            
        } else {
            
            //Change login mode
            signupOrLoginLbl.setTitle("Sign Up", for: [])
            
            changeSignupModeLbl.setTitle("Log In", for: [])
            
            messageLabel.text = "Already have an account?"
            
            signupMode = true
        }
    }
    
    
    //--------------------------------------
    //MARK: - Override Function declaration
    //--------------------------------------
    
    override func viewDidAppear(_ animated: Bool) {
        
        if PFUser.current() != nil {
            
            performSegue(withIdentifier: "showUserTableSegue", sender: self)
            
        }
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("start")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//
//  Login.swift
//  EastHighschoolLibrary
//
//  Created by Kevin Wang on 2/25/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class LoginController: UIViewController, UITextFieldDelegate{
    
    var ref: DatabaseReference!
    
    
    var passwordFirebase = ""
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
    super.viewDidLoad()

}

    @IBAction func loginPressed(_ sender: Any) {
        // when login button is pressed the code here checks if the password assosciated with the username in firebase is the one the user inputs
        
        let myGroup = DispatchGroup()
        myGroup.enter()
        
        self.ref = Database.database().reference()
        if(usernameField.text! == ""){
        
            let alert = UIAlertController(title: "Login Error", message: "Username or Password do not work", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)

        }
        else{
        self.ref.child("Users").child(usernameField.text!).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let item = snapshot.value as? String{
                self.passwordFirebase = item
                myGroup.leave()
                print("hi")
            }
        })
        myGroup.notify(queue: DispatchQueue.main) {
            if(self.passwordFirebase == self.passwordField.text! && self.passwordFirebase != ""){
                let userInfo = UserDefaults.standard
                userInfo.set(self.usernameField.text!, forKey: "username")
                self.performSegue(withIdentifier: "loginPressedSegue", sender: self)
            }
                
            else{
                let alert = UIAlertController(title: "Login Error", message: "Username or Password do not work", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        
    }
        }
    

        
    }
   
override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}


}


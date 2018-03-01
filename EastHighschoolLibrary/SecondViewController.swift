//
//  SecondViewController.swift
//  EastHighschoolLibrary
//
//  Created by Kevin Wang on 2/15/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import UIKit
import FirebaseDatabase
import EventKit
class SecondViewController: UIViewController {
    
    var ref: DatabaseReference!
    var username = UserDefaults.standard.string(forKey: "username")
    var bookOneFirebase = "none"
    var bookTwoFirebase = "none"
    var count = 0
    var arrayBookNames = [String]()
    var arrayBookStock = [Int]()
    var countHowManyBooks = 0
    @IBOutlet weak var bookTwo: UILabel!
    @IBOutlet weak var bookOne: UILabel!
    
    @IBOutlet weak var bookTwoImage: UIImageView!
    @IBOutlet weak var bookOneImage: UIImageView!

    override func viewDidLoad() {
        self.ref = Database.database().reference()
        self.ref.child("Users").child("Books").observeSingleEvent(of: .value, with: { (snapshot) in
            self.count = Int(snapshot.childrenCount)
            let books = snapshot.children
            while let rest = books.nextObject() as? DataSnapshot {
                self.arrayBookStock.append(rest.value as! Int)
                self.arrayBookNames.append(rest.key)
                
                UserDefaults.standard.set(self.arrayBookStock, forKey:"arrayBookStock")
                
                UserDefaults.standard.set(self.arrayBookNames, forKey:"arrayBookNames")
            }
        })
        self.ref = Database.database().reference()
        let firebaseReference = "\(username ?? "none")Books"
        self.ref.child("Users").child(firebaseReference).child("bookOne").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let item = snapshot.value as? String{
                self.bookOneFirebase = item
                self.bookOneImage.image = UIImage(named:self.bookOneFirebase)!
                self.bookOne.text = self.bookOneFirebase
                
                UserDefaults.standard.set("none" , forKey:"bookOneSlotsFree")
                if(self.bookOneFirebase == "none"){
                    
                    UserDefaults.standard.set("bookOne", forKey:"bookOneSlotsFree")
                }
            }
            
        })
        self.ref.child("Users").child(firebaseReference).child("bookTwo").observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let item = snapshot.value as? String{
                self.bookTwoFirebase = item
                self.bookTwoImage.image = UIImage(named:self.bookTwoFirebase)!
                self.bookTwo.text = self.bookTwoFirebase
                
                UserDefaults.standard.set("none" , forKey:"bookTwoSlotsFree")
                if(self.bookTwoFirebase == "none"){
                    
                    UserDefaults.standard.set("bookTwo", forKey:"bookTwoSlotsFree")
                    
                }
                
            }
            
        })
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


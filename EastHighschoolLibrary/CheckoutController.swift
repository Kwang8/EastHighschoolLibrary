//
//  CheckoutController.swift
//  EastHighschoolLibrary
//
//  Created by Kevin Wang on 2/28/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
class CheckoutController:UIViewController {
    @IBOutlet weak var bookName: UILabel!
    
    let ref = Database.database().reference()
    let date = Date()
    var username = UserDefaults.standard.string(forKey: "username")
    var book = UserDefaults.standard.integer(forKey:"bookNumber")
    var arrayBookNames = UserDefaults.standard.array(forKey: "arrayBookNames")
    var arrayBookStocks:[Int] = UserDefaults.standard.array(forKey: "arrayBookStock") as! [Int]
    var freeSpacesOne =  UserDefaults.standard.string(forKey:"bookOneSlotsFree")
    var freeSpacesTwo =  UserDefaults.standard.string(forKey:"bookTwoSlotsFree")
    @IBOutlet weak var bookImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bookImage.image = UIImage(named:"\(arrayBookNames![book])")!
        bookName.text = " \(self.arrayBookNames![book]) Stock: \(self.arrayBookStocks[book])"
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func checkoutPressed(_ sender: Any) {
        //checking for if the book is in stock and if you have at least 1 one free book slot
        let string:String = "\(self.arrayBookStocks[book])"
        if(string == "0"){
            let alert = UIAlertController(title: "No Books Left", message: "There are no books in stock, please reserve the book instead", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
    }
        else if(freeSpacesOne! == "none" && freeSpacesTwo! == "none"){
            let alert = UIAlertController(title: "Please Return Book", message: "Sorry, but the capacity of books a student can have is only two! please return them!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if (freeSpacesOne != "none"){
            let reference = "\(username ?? "none")Books"
            self.ref.child("Users").child(reference).child("bookOne").setValue("\(arrayBookNames![book])")
            self.ref.child("Users").child("Books").child("\(self.arrayBookNames![book])").setValue(self.arrayBookStocks[book]-1)
        }
        else{
            let reference = "\(username ?? "none")Books"
            self.ref.child("Users").child(reference).child("bookTwo").setValue("\(arrayBookNames![book])")
            self.ref.child("Users").child(reference).child("bookTwo").child("timeOut").setValue(self.date)
            
            self.ref.child("Users").child("Books").child("\(self.arrayBookNames![book])").setValue(self.arrayBookStocks[book]-1)
        }
    }
    
    @IBAction func reservesPressed(_ sender: Any) {
            //puts time on firebase so librarian can know who to give book to
        self.ref.child("Users").child("reservations").child(self.username!).setValue("\(self.arrayBookNames![book]) \(self.date)")
        let alert = UIAlertController(title: "Reservation Tip", message: "Sorry,due to the demand for popular books students can only have one reservation at a time, if you do multiple one will be canceled", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "ok, I confirm my reservation", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}



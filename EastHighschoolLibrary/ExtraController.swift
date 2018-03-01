//
//  ExtraController.swift
//  EastHighschoolLibrary
//
//  Created by Kevin Wang on 3/1/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import Foundation
import UIKit
class ExtraController:UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}


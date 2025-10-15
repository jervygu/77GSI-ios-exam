//
//  ViewController.swift
//  Login
//
//  Created by Jervy Umandap on 10/14/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.title = "Login"
    }
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        print("loginTapped")
    }
    

}


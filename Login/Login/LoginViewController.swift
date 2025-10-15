//
//  ViewController.swift
//  Login
//
//  Created by Jervy Umandap on 10/14/25.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    private let loginViewModel = LoginViewModel()
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.title = "Login"
        
        setupBindings()
    }
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        print("loginTapped")
    }
    
    func setupBindings() {
        usernameTF.rx.text
            .map { $0 ?? "" }
            .bind(to: loginViewModel.usernameTFPublishSubject)
            .disposed(by: disposeBag)
        
        passwordTF.rx.text
            .map { $0 ?? "" }
            .bind(to: loginViewModel.passwordTFPublishSubject)
            .disposed(by: disposeBag)
        
        loginViewModel.isValid()
            .bind(to: loginBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginViewModel.isValid()
            .map { $0 ? 1 : 0.1 }
            .bind(to: loginBtn.rx.alpha)
            .disposed(by: disposeBag)
        
    }

}


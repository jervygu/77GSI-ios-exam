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
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Login"
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        messageLabel.text = ""
        usernameTF.text = ""
        passwordTF.text = ""
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        print("loginTapped")
    }
    
    private func setupBindings() {
        usernameTF.rx.text
            .map { $0 ?? "" }
            .bind(to: loginViewModel.usernameTFBehaviorRelay)
            .disposed(by: disposeBag)

        passwordTF.rx.text
            .map { $0 ?? "" }
            .bind(to: loginViewModel.passwordTFBehaviorRelay)
            .disposed(by: disposeBag)

        loginViewModel.isValid()
            .bind(to: loginBtn.rx.isEnabled)
            .disposed(by: disposeBag)

        loginViewModel.isValid()
            .map { $0 ? 1 : 0.95 }
            .bind(to: loginBtn.rx.alpha)
            .disposed(by: disposeBag)
        
        // Bind text fields to ViewModel inputs
        usernameTF.rx.text.orEmpty
            .bind(to: loginViewModel.usernameTFBehaviorRelay)
            .disposed(by: disposeBag)
        
        passwordTF.rx.text.orEmpty
            .bind(to: loginViewModel.passwordTFBehaviorRelay)
            .disposed(by: disposeBag)
        
        // Button tap - ViewModel trigger
        loginBtn.rx.tap
            .bind(to: loginViewModel.loginTapped)
            .disposed(by: disposeBag)
        
        // Show loading indicator
        loginViewModel.isLoading
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        loginViewModel.isLoading
            .map { !$0 }
            .bind(to: activityIndicator.rx.isHidden)
            .disposed(by: disposeBag)
        
        // Disable button while loading
        loginViewModel.isLoading
            .map { !$0 }
            .bind(to: loginBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        // Display login result
        loginViewModel.loginResult
            .observe(on: MainScheduler.instance)
            .bind(onNext: { [weak self] message in
                self?.messageLabel.text = message
                self?.messageLabel.textColor = message.contains("✅") ? .systemGreen : .systemRed
            })
            .disposed(by: disposeBag)
        
        loginViewModel.isAuthenticated
            .observe(on: MainScheduler.instance)
            .map { $0 }
            .bind(onNext: { [weak self] isSuccess in
                if isSuccess {
                    let vc = HomeViewController()
                    vc.title = "Welcome!"
                    vc.view.backgroundColor = .systemBackground
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }

}


//
//  LoginViewModel.swift
//  Login
//
//  Created by Jervy Umandap on 10/15/25.
//


import RxSwift
import RxCocoa

class LoginViewModel {
    
    let usernameTFBehaviorRelay = BehaviorRelay<String>(value: "")
    let passwordTFBehaviorRelay = BehaviorRelay<String>(value: "")
    let loginTapped = PublishRelay<Void>()
    
    let isLoading = BehaviorRelay<Bool>(value: false)
    let isAuthenticated = PublishRelay<Bool>()
    let loginResult = PublishRelay<String>()
    
    private let disposeBag = DisposeBag()
    
    init() {
        bindActions()
    }
    
    private func bindActions() {
        loginTapped
            .subscribe(onNext: { [weak self] in
                self?.login()
            })
            .disposed(by: disposeBag)
    }
    
    private func login() {
        guard !usernameTFBehaviorRelay.value.isEmpty, !passwordTFBehaviorRelay.value.isEmpty else {
            loginResult.accept("⚠️ Please enter both username and password.")
            return
        }
        
        isLoading.accept(true)
        
        // Simulate API delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            self.isLoading.accept(false)
            
            if self.usernameTFBehaviorRelay.value == "jervygu" && self.passwordTFBehaviorRelay.value == "pppppp" {
                self.loginResult.accept("✅ Login Successful!")
                self.isAuthenticated.accept(true)
            } else {
                self.loginResult.accept("❌ Invalid username or password.")
                self.isAuthenticated.accept(false)
            }
        }
    }
    
    func isValid() -> Observable<Bool> {
        let obs = Observable.combineLatest(usernameTFBehaviorRelay.asObservable().startWith(""), passwordTFBehaviorRelay.asObservable().startWith("")).map { username, password in
            return username.count >= 6 && password.count >= 6
        }
        return obs.startWith(false)
    }
    
}

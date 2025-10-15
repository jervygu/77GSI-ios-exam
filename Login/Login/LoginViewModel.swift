//
//  LoginViewModel.swift
//  Login
//
//  Created by Jervy Umandap on 10/15/25.
//


import RxSwift
import RxCocoa

class LoginViewModel {
    
    let usernameTFPublishSubject = PublishSubject<String>()
    let passwordTFPublishSubject = PublishSubject<String>()
    
    func isCredentialValid() -> Bool {
        return true
    }
    
    func isValid(input: String?) -> Bool {
        guard let input = input else { return false }
        return !input.isEmpty
    }
    
    func isValid() -> Observable<Bool> {
        let obs = Observable.combineLatest(usernameTFPublishSubject.asObservable().startWith(""), passwordTFPublishSubject.asObservable().startWith("")).map { username, password in
            return username.count > 3 && password.count > 3
        }
        return obs.startWith(false)
    }
    
}

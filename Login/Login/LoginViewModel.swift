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
    
    func isValid() -> Observable<Bool> {
        let obs = Observable.combineLatest(usernameTFPublishSubject.asObservable().startWith(""), passwordTFPublishSubject.asObservable().startWith("")).map { username, password in
            return username.count > 6 && password.count > 8
        }
        return obs.startWith(false)
    }
    
}

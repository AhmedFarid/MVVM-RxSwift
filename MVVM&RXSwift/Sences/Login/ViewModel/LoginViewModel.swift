//
//  LoginViewModel.swift
//  MVVM&RXSwift
//
//  Created by macbook on 11/07/2022.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire

class LoginViewModel {
  var codeBehavior = BehaviorRelay<String>(value: "")
  var phoneBehavior = BehaviorRelay<String>(value: "")
  
  var loadingBehavior = BehaviorRelay<Bool>(value: false)
  private var loginModelSubject = PublishSubject<LoginSuccessModel>()
  
  var isPhoneValid: Observable<Bool> {
    return phoneBehavior.asObservable().map { (phone) -> Bool in
      let isPhoneEmpty = phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
      return isPhoneEmpty
    }
  }
  
  var isCodeValid: Observable<Bool> {
    return codeBehavior.asObservable().map { (code) -> Bool in
      let isCodeEmpty = code.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
      return isCodeEmpty
    }
  }
  
  var isLoadingEnabled: Observable<Bool> {
    return Observable.combineLatest(isPhoneValid, isCodeValid) { (isPhoneEmpty,isCodeEmpty) in
      let loginValid = !isPhoneEmpty && !isCodeEmpty
      return loginValid
    }
  }
  
  
  var loginModelObservable: Observable<LoginSuccessModel> {
    return loginModelSubject
  }
  
  func getData() {
    loadingBehavior.accept(true)
    
    let params = [
      "username": phoneBehavior.value,
      "password": codeBehavior.value
    ]
    
    let headers: HTTPHeaders = ["Api-Locale": "en"]
    
    APIServices.instance.getData(url: "http://mokfha.orcav.com/api/auth/login", method: .post, params: params, encoding: URLEncoding.queryString, headers: headers) { [weak self] (loginModel: LoginSuccessModel?, baseErrorModel: BaseErrorModel?, error) in
      guard let self = self else {return}
      self.loadingBehavior.accept(false)
      if let error = error {
        // network error
        print(error.localizedDescription)
      }else if let baseErrorModel = baseErrorModel {
        print(baseErrorModel.message ?? "")
      }else {
        guard let loginModel = loginModel else {return}
        self.loginModelSubject.onNext(loginModel)
        
      }
    }
  }
}

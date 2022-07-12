//
//  LoginVC.swift
//  MVVM&RXSwift
//
//  Created by macbook on 11/07/2022.
//

import UIKit
import RxSwift
import RxCocoa

class LoginVC: UIViewController {
  
  @IBOutlet weak var codeTextField: UITextField!
  @IBOutlet weak var phoneTextField: UITextField!
  
  @IBOutlet weak var loginButton: UIButton!
  
  let loginViewModel = LoginViewModel()
  
  
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bindTextFieldsToViewModel()
    subscribeToLoginButton()
    subscribeToLoading()
    subscribeToResponse()
    subscribeIsLoginEnabled()
  }
  
  func bindTextFieldsToViewModel() {
    phoneTextField.rx.text.orEmpty.bind(to: loginViewModel.phoneBehavior).disposed(by: disposeBag)
    codeTextField.rx.text.orEmpty.bind(to: loginViewModel.codeBehavior).disposed(by: disposeBag)
  }
  
  func subscribeToLoginButton() {
    loginButton.rx.tap
      .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
      .subscribe(onNext: { [weak self](_) in
        guard let self = self else { return }
        self.loginViewModel.getData()
      }).disposed(by: disposeBag)
  }
  
  func subscribeToResponse() {
    loginViewModel.loginModelObservable.subscribe(onNext: {
      if $0.success == true {
        print($0.data?.user?.firstName ?? "")
        let vc = HomeVC(nibName: "HomeVC", bundle: nil)
        self.present(vc, animated: true)
      } else {
        
      }
    }).disposed(by: disposeBag)
  }
  
  func subscribeToLoading() {
    loginViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
      if isLoading {
        self.showIndicator(withTitle: "", and: "")
      } else {
        self.hideIndicator()
      }
    }).disposed(by: disposeBag)
  }
  
  func subscribeIsLoginEnabled() {
    loginViewModel.isLoadingEnabled.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
  }
}

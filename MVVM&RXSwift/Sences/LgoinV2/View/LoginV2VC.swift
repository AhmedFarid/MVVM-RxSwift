//
//  LoginV2VC.swift
//  MVVM&RXSwift
//
//  Created by macbook on 13/07/2022.
//

import UIKit

class LoginV2VC: UIViewController {
  
  @IBOutlet weak var passwordField: UITextField!
  @IBOutlet weak var usernameField: UITextField!
  @IBOutlet weak var codeLabel: UILabel!
  
  
  //var loginSuccess: (() -> Void)?
  
  private var viewModel = UserViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
      passwordField.delegate = self
      usernameField.delegate = self
      
      viewModel.accessCode.bind { [unowned self] in
        self.codeLabel.text = $0
      }
      
      viewModel.username.bind { [unowned self] in
        print($0)
      }
    }


  @IBAction func authenticate() {
    switch viewModel.validate() {
    case .Valid:
      viewModel.login { errorMessage in
        if let errorMessage = errorMessage {
          self.displayErrorMessage(errorMessage: errorMessage)
        }else {
          let vc = SuucessLoginScreenVC(nibName: "SuucessLoginScreenVC", bundle: nil)
          navigationController?.pushViewController(vc, animated: true)
        }
      }
    case .Invalid(let error):
      displayErrorMessage(errorMessage: error)
    }
  }
  

}

extension LoginV2VC: UITextFieldDelegate {
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if textField == usernameField {
      textField.text = viewModel.username.value
    }
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField == usernameField {
      textField.text = viewModel.protectedUserName
    }
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == usernameField {
      passwordField.becomeFirstResponder()
    }else {
      authenticate()
    }
    return true
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
    if textField == usernameField {
      viewModel.updateUsername(username: newString)
    }else {
      viewModel.updatePassword(password: newString)
    }
    return true
  }
}

private extension LoginV2VC {
  func displayErrorMessage(errorMessage: String) {
    let alertController = UIAlertController(title: nil, message: errorMessage, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(okAction)
    present(alertController, animated: true, completion: nil)
  }
}

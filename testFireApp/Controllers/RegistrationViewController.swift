//
//  RegistrationViewController.swift
//  testFireApp
//
//  Created by Глеб Писарев on 21.04.2022.
//

import UIKit
import Firebase
//import FirebaseDatabase

class RegistrationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        self.confirmTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        hideLeyboardWhenTap()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case usernameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            confirmTextField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        
        return true
        
    }
    
    @objc func kbWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: keyboardSize.height)
    }
    
    @objc func kbWillHide() {
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    @IBAction func registrationAction(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, let confirm = confirmTextField.text, email != "" else { return }
        if password != confirm {
            return
        }
        
        AuthService.shared.register(email: email, password: password) { result in
            switch result {
            case .success(_):
                self.dismiss(animated: true)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

extension RegistrationViewController {
    func hideLeyboardWhenTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}

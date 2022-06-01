//
//  ViewController.swift
//  testFireApp
//
//  Created by Глеб Писарев on 20.04.2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    private var handle: AuthStateDidChangeListenerHandle?
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private var uid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        errorLabel.isHidden = true
        
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
        hideLeyboardWhenTap()
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        loginButton.layer.cornerRadius = 10
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener({[weak self] auth, user in
            if user != nil {
                self?.uid = user?.uid ?? ""
                self?.performSegue(withIdentifier: "assignmentsSegue", sender: nil)
            }
        })
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .next {
            //usernameTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        else {
            passwordTextField.resignFirstResponder()
        }
        
        return true
    }
    
    
    @objc func kbDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let kbSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: kbSize.height)
    }
    
    @objc func kbDidHide() {
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let username = usernameTextField.text, let password = passwordTextField.text, username != "", password != "" else { return }
        AuthService.shared.register(email: usernameTextField.text, password: passwordTextField.text) { result in
            switch result {
            case .success(_):
                return
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
}

extension LoginViewController {
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




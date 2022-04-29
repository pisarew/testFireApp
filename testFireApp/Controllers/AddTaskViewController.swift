//
//  AddTaskViewController.swift
//  testFireApp
//
//  Created by Глеб Писарев on 24.04.2022.
//

import UIKit
import FirebaseDatabase

enum Question {
    case name, place, price, more
}

class AddTaskViewController: UIViewController {

    private var question: Question = .name
    private var task: Task = Task()
    private var ref: DatabaseReference!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        nextButton.layer.cornerRadius = 10
        
        backButton.tintColor = .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        hideLeyboardWhenTap()
    }
    
    @objc private func kbWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        let kbSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: kbSize.height)
    }
    @objc private func kbWillHide() {
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
    }
    
    private func setQuestion() {
        switch question {
        case .name:
            questionLabel.text = "Что нужно сделать?"
            answerTextField.placeholder = "Название задачи"
            answerTextField.text = ""
            //nextButton.setTitle("Дальше", for: .normal)
            backButton.tintColor = .white
        case .place:
            questionLabel.text = "Как Выс найти?"
            answerTextField.placeholder = "Место нахождения"
            answerTextField.text = ""
            //nextButton.setTitle("Дальше", for: .normal)
            backButton.tintColor = .gray
        case .price:
            questionLabel.text = "Сколько Вы готовы заплатить?"
            answerTextField.placeholder = "Цена"
            answerTextField.text = ""
            //nextButton.setTitle("Дальше", for: .normal)
            backButton.tintColor = .gray
        case .more:
            questionLabel.text = "Что то еще?"
            answerTextField.placeholder = "Дополнительно"
            answerTextField.text = ""
            //nextButton.setTitle("Завершить", for: .normal)
            backButton.tintColor = .gray
        }
    }
    
    @IBAction func nextAction(_ sender: Any) {
        switch question {
        case .name:
            task.title = answerTextField.text ?? ""
            question = .place
            setQuestion()
        case .place:
            task.place = answerTextField.text ?? ""
            question = .price
            setQuestion()
        case .price:
            task.price = answerTextField.text ?? ""
            question = .more
            setQuestion()
        case .more:
            task.more = answerTextField.text ?? ""
            ref.child("tasks").childByAutoId().setValue(task.convertToDictionary())
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        switch question {
        case .name:
            return
        case .place:
            question = .name
            setQuestion()
        case .price:
            question = .place
            setQuestion()
        case .more:
            question = .price
            setQuestion()
        }
    }
    

}


extension AddTaskViewController {
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

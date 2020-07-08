//
//  ViewController.swift
//  My_lesson30_UserDefaults
//
//  Created by OlegChudnovskiy on 05.07.2020.
//  Copyright © 2020 OlegChudnovskiy. All rights reserved.
//
// Парсинг и работа с Codable в Swift 4
// https://habr.com/ru/post/414221/

// UserDefaults
// https://habr.com/ru/post/324400/

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var switchControl: UISwitch?
    @IBOutlet private weak var textLabel: UILabel?
    @IBOutlet private weak var textLabelFromTF: UILabel?
    @IBOutlet private weak var textField: UITextField?
    @IBOutlet private weak var datePicker: UIDatePicker?
    @IBOutlet private weak var contentBottomConstraint: NSLayoutConstraint?

    //MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
        let notificationCenter = NotificationCenter.default
         notificationCenter.addObserver(
             forName: UIResponder.keyboardWillChangeFrameNotification,
             object: nil, queue: .main) { (notification) in
                 self.handleKeyboard(notification: notification)
         }
         notificationCenter.addObserver(
             forName: UIResponder.keyboardWillHideNotification,
             object: nil, queue: .main) { (notification) in
                 self.handleKeyboard(notification: notification)
         }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK: - Private
    private func handleKeyboard(notification: Notification) {
      // 1
      guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
        contentBottomConstraint?.constant = 0
        view.layoutIfNeeded()
        return
      }

      guard
        let info = notification.userInfo,
        let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
          return
      }

      // 2
      let keyboardHeight = keyboardFrame.cgRectValue.size.height
      UIView.animate(withDuration: 0.1, animations: { () -> Void in
        self.contentBottomConstraint?.constant = keyboardHeight
        self.view.layoutIfNeeded()
      })
    }
    
    //MARK: - Private
    private func saveData() {
        let value = switchControl?.isOn
        UserDefaults.standard.set(value, forKey: Keys.SwitchControlIsOnKey)
        
        let textString = "TEST_String"
        UserDefaults.standard.set(textString, forKey: Keys.StringKey)
        textLabel?.text = textString
        
        let textFieldText = textField?.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        UserDefaults.standard.set( textFieldText, forKey: Keys.StringKeyTextField)
        if let text = textFieldText {
            textLabelFromTF?.text = text
        } else {
            textLabelFromTF?.text = "-=TF.text text is Empty =-"
        }
        
        UserDefaults.standard.set(datePicker?.date, forKey: Keys.DateKey)
    }
    
    private func loadData() {
        let value = UserDefaults.standard.bool(forKey: Keys.SwitchControlIsOnKey)
        switchControl?.isOn = value
        
        let textValue = UserDefaults.standard.string(forKey: Keys.StringKey)
        textLabel?.text = textValue ?? "-= text is Empty =-"
        
        if let text = UserDefaults.standard.string(forKey: Keys.StringKeyTextField) {
            textLabelFromTF?.text = text
        } else {
           textLabelFromTF?.text = "-=TF.text text is Empty =-"
        }
        let dateValue = UserDefaults.standard.object(forKey: Keys.DateKey) as? Date
        datePicker?.date = dateValue ?? Date()
    }
    
    private func clearData() {
        UserDefaults.standard.removeObject(forKey: Keys.SwitchControlIsOnKey)
        UserDefaults.standard.removeObject(forKey: Keys.StringKey)
        UserDefaults.standard.removeObject(forKey: Keys.StringKeyTextField)
        UserDefaults.standard.removeObject(forKey: Keys.DateKey)

        loadData() 
    }
    
    //MARK: - Actions
    @IBAction private func datePickerChanged() {
        
    }
    
    @IBAction private func hideKeyBoard() {
        view.endEditing(true)
    }
    
    @IBAction private func switchControlChanged() {
    }
    
    @IBAction private func saveDataBattonClicked() {
        saveData()
    }
    
    @IBAction private func loadDataBattonClicked() {
        loadData()
    }
    
    @IBAction private func clearDataBattonClicked() {
        let allert = UIAlertController(title: "Clear data?", message: nil, preferredStyle: .alert)
        allert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [weak self] _ in
            self?.clearData()
        }))
        allert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        self.present(allert, animated: true, completion: nil)
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

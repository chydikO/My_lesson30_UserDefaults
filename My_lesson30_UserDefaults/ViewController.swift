//
//  ViewController.swift
//  My_lesson30_UserDefaults
//
//  Created by OlegChudnovskiy on 05.07.2020.
//  Copyright © 2020 OlegChudnovskiy. All rights reserved.
//
// Парсинг и работа с Codable в Swift 4
// https://habr.com/ru/post/414221/

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var switchControl: UISwitch?
    @IBOutlet private weak var textLabel: UILabel?
    @IBOutlet private weak var textLabelFromTF: UILabel?
    @IBOutlet private weak var textField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
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
    }
    
    private func loadData() {
        let value = UserDefaults.standard.bool(forKey: Keys.SwitchControlIsOnKey)
        switchControl?.isOn = value
        
        let textValue = UserDefaults.standard.string(forKey: Keys.StringKey)
        textLabel?.text = textValue ?? "-= text is Empty =-"
        
        let textFromTextField = UserDefaults.standard.string(forKey: Keys.StringKeyTextField) as? String
        if let text = textFromTextField {
            textLabelFromTF?.text = text
        } else {
           textLabelFromTF?.text = "-=TF.text text is Empty =-"
        }
         
    }
    
    private func clearData() {
        UserDefaults.standard.removeObject(forKey: Keys.SwitchControlIsOnKey)
        UserDefaults.standard.removeObject(forKey: Keys.StringKey)
        UserDefaults.standard.removeObject(forKey: Keys.StringKeyTextField)

        loadData() 
    }
    
    //MARK: - Actions
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

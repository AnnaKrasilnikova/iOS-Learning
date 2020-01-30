//
//  SettingsViewController.swift
//  epamPractice1_GuessNumber
//
//  Created by Anna Krasilnikova on 27.01.2020.
//  Copyright © 2020 Anna Krasilnikova. All rights reserved.
//

import UIKit
//protocol SettingsViewControllerDelegate: NSObjectProtocol {
//    func doSomethingWith(data: String)
//}

enum SettingsKeys: String {
    case startValue
    case endValue
}

class SettingsViewController: UIViewController {
    
    var inputHandling: (( Int, Int ) -> ())?
    
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var startOfRangeTextField: UITextField!
    @IBOutlet weak var endOfRangeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        warningLabel.isHidden = true
        getSettings()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonTapped (_ sender: UIButton) {
        inputHandling?(UserDefaults.standard.integer(forKey: SettingsKeys.startValue.rawValue),
            UserDefaults.standard.integer(forKey: SettingsKeys.endValue.rawValue))
        self.dismiss(animated: true)
    }
    
    @IBAction func saveButtonTapped (_ sender: UIButton) {
        saveSettings()
    }
    
//    let defaults = UserDefaults.standard
    
    func saveSettings(){
        guard let start = startOfRangeTextField.text,
            let end = endOfRangeTextField.text else {return}
        if let startInt = Int(start), let endInt = Int(end) {
            if startInt < endInt {
                UserDefaults.standard.set(startInt,
                    forKey: SettingsKeys.startValue.rawValue)
                UserDefaults.standard.set(endInt,
                    forKey: SettingsKeys.endValue.rawValue)
                warningLabel.isHidden = true
            } else {
                warningFunc()
                return
            }
        } else {
            warningFunc()
            return
        }
    }
    
    func getSettings() {
        startOfRangeTextField.text = UserDefaults.standard.string(forKey: SettingsKeys.startValue.rawValue)
        endOfRangeTextField.text = UserDefaults.standard.string(forKey: SettingsKeys.endValue.rawValue)
    }
    
    func warningFunc() {
        warningLabel.isHidden = false
        getSettings()
    }

}

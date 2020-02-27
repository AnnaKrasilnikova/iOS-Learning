//
//  ViewController.swift
//  epamPractice1_GuessNumber
//
//  Created by Anna Krasilnikova on 23.01.2020.
//  Copyright © 2020 Anna Krasilnikova. All rights reserved.
//

import UIKit

enum InfoKeys: String {
    case maxTriesKey
    case minTriesKey
    case countGamesKey
}

class GuessNumberViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var inputNumberTextField: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var chancelButton: UIButton!
    @IBOutlet weak var numberOfTriesLabel: UILabel!
    @IBOutlet weak var numberOfTriesInfoLabel: UILabel!
    @IBOutlet weak var rangeInfoLabel: UILabel!
    
    var startOfRangeVar: Int = 0
    var endOfRangeVar: Int = 100
    var genNumber: Int = 0
    var enteredNumber: Int = 0
    var numberOfTries: Int = 0
    var gameOver = false
    
    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    var inputInfoHandling: (( Int, Int, Int ) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultsSettings()
        startOfRangeVar = UserDefaults.standard.integer(forKey: SettingsKeys.startValue.rawValue)
        endOfRangeVar = UserDefaults.standard.integer(forKey: SettingsKeys.endValue.rawValue)
        gameOverFunc()
    }
    
    //MARK: Reset game button
    @IBAction func buttonChancel(_ sender: UIButton) {
        gameOverFunc()
    }
    
    //MARK: checking b number
    @IBAction func buttonAction(_ sender: UIButton) {
        if gameOver {
            gameOverFunc()
            return
        }
        if let text = inputNumberTextField.text, let enteredNumber = Int(text),
            enteredNumber >= startOfRangeVar, enteredNumber <= endOfRangeVar {
                chancelButton.isHidden = false
            switch enteredNumber{
            case _ where enteredNumber < genNumber:
                infoLabelTextChange(text: "Little")
            case _ where enteredNumber > genNumber:
                infoLabelTextChange(text: "Much")
            default:
                infoLabelTextChange(text: "Guessed!")
                gameOver = true
                guessButton.setTitle(NSLocalizedString("New game", comment: ""), for: .normal)
                chancelButton.isHidden = true
            }
            numberOfTries += 1
            numberOfTriesTextChange(number: numberOfTries)
            saveInfo(numberTries: numberOfTries)
        } else {
            inputNumberError()
        }
        inputNumberTextField.text = ""
    }
    
    //MARK: go to settings tab
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
        guard let settingsViewController = mainStoryboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else { return }
        settingsViewController.inputHandling = { [weak self] varA, varB in
            self?.startOfRangeVar = varA
            self?.endOfRangeVar = varB
            self?.gameOverFunc()
        }
        self.present(settingsViewController, animated: true)
    }
    
    //MARK: go to info tab
    @IBAction func infoButtonTapped(_ sender: UIButton) {
        guard let infoViewController = mainStoryboard.instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController else { return }
        inputInfoHandling?(UserDefaults.standard.integer(forKey: InfoKeys.maxTriesKey.rawValue),
                           UserDefaults.standard.integer(forKey: InfoKeys.minTriesKey.rawValue),
                           UserDefaults.standard.integer(forKey: InfoKeys.countGamesKey.rawValue))
        self.present(infoViewController, animated: true)
    }
    
    //MARK: generate new random number
    func generateNumber() -> Int {
        return Int.random(in: startOfRangeVar...endOfRangeVar)
    }
    
    //MARK: clear input textField
    func clearInputNumber() {
        inputNumberTextField.text = nil
    }
    
    //MARK: reset all game settings
    func gameOverFunc() {
        gameOver = false
        numberOfTries = 0
        enteredNumber = 0
        numberOfTriesTextChange(number: numberOfTries)
        infoLabel.text = ""
        rangeInfoLabel.text = NSLocalizedString("Guess the number", comment: "") + NSLocalizedString(" from ", comment: "") + String(startOfRangeVar) + NSLocalizedString(" to ",comment: "") + String(endOfRangeVar)
        clearInputNumber()
        genNumber = generateNumber()
        guessButton.setTitle(NSLocalizedString("Guess", comment: ""), for: .normal)
        chancelButton.isHidden = true
    }
    
    //MARK: set infoLabel text
    func infoLabelTextChange(text: String) {
        infoLabel.text = NSLocalizedString(text, comment: "")
    }
    
    //MARK: set numberOfTries text
    func numberOfTriesTextChange(number: Int) {
        numberOfTriesLabel.text = String(number)
    }
    
    //MARK: save info in defaults
    func saveInfo (numberTries: Int) {
        if numberTries > UserDefaults.standard.integer(forKey: InfoKeys.maxTriesKey.rawValue) {
            UserDefaults.standard.set(numberTries,
                                  forKey: InfoKeys.maxTriesKey.rawValue)
        }
        if UserDefaults.standard.string(forKey: InfoKeys.minTriesKey.rawValue) == "-"
        || numberTries < UserDefaults.standard.integer(forKey: InfoKeys.minTriesKey.rawValue) {
            UserDefaults.standard.set(numberTries,
                                  forKey: InfoKeys.minTriesKey.rawValue)
        }
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: InfoKeys.countGamesKey.rawValue) + 1,
                                  forKey: InfoKeys.countGamesKey.rawValue)
    }
    
    //MARK: set warning message
    func inputNumberError() {
        infoLabelTextChange(text: "Input correct number!")
    }
    
    //MARK: set default values for UserDefaults keys
    func setDefaultsSettings () {
        UserDefaults.standard.register(defaults: [SettingsKeys.startValue.rawValue : 0])
        UserDefaults.standard.register(defaults: [SettingsKeys.endValue.rawValue : 100])
        UserDefaults.standard.register(defaults: [InfoKeys.maxTriesKey.rawValue : "-"])
        UserDefaults.standard.register(defaults: [InfoKeys.minTriesKey.rawValue : "-"])
        UserDefaults.standard.register(defaults: [InfoKeys.countGamesKey.rawValue : 0])
    }
}

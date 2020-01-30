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
    @IBOutlet weak var inputNumber: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var chancelButton: UIButton!
    @IBOutlet weak var numberOfTriesLabel: UILabel!
    @IBOutlet weak var numberOfTriesInfoLabel: UILabel!
    @IBOutlet weak var rangeInfoText: UILabel!
    
    var a: Int = UserDefaults.standard.integer(forKey: SettingsKeys.startValue.rawValue)
    //MARK: add default value = 100
    var b: Int = UserDefaults.standard.integer(forKey: SettingsKeys.endValue.rawValue)
    var genNumber: Int = 0
    var enteredNumber: Int = 0
    var numberOfTries: Int = 0
    var gameOver = false
    
    let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    
    var inputInfoHandling: (( Int, Int, Int ) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        guard let text = inputNumber.text else { return }
        if text.isEmpty {
            inputNumberError()
            return
        }
        //MARK: add check
            enteredNumber = Int(text) ?? 0
            chancelButton.isHidden = false
            if enteredNumber < genNumber {
                infoLabelTextChange(text: "Little")
            } else if enteredNumber > genNumber {
                infoLabelTextChange(text: "Much")
            } else {
                infoLabelTextChange(text: "Guessed!")
                gameOver = true
                saveInfo(numberTries: numberOfTries + 1)
                guessButton.setTitle(NSLocalizedString("New game", comment: ""), for: .normal)
                chancelButton.isHidden = true
            //}
        }
        clearInputNumber()
        numberOfTries += 1
        numberOfTriesTextChange(number: numberOfTries)
    }
    
    //MARK: go to settings tab
    @IBAction func settingsButtonTapped(_ sender: UIButton) {
        guard let settingsViewController = mainStoryboard.instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else { return }
        settingsViewController.inputHandling = { [weak self] varA, varB in
            self?.a = varA
            self?.b = varB
            self?.gameOverFunc()
        }
        self.present(settingsViewController, animated: true)
    }
    
    //MARK: go to info tab
    @IBAction func infoButtonTapped(_ sender: UIButton) {
        //let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let infoViewController = mainStoryboard.instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController else { return }
        inputInfoHandling?(UserDefaults.standard.integer(forKey: InfoKeys.maxTriesKey.rawValue),
                           UserDefaults.standard.integer(forKey: InfoKeys.minTriesKey.rawValue),
                           UserDefaults.standard.integer(forKey: InfoKeys.countGamesKey.rawValue))
        self.present(infoViewController, animated: true)
    }
    
    //MARK: generate new random number
    func generateNumber() -> Int {
        return Int.random(in: a...b)
    }
    
    //MARK: clear input textField
    func clearInputNumber() {
        inputNumber.text = nil
    }
    
    //MARK: reset all game settings
    func gameOverFunc(){
        gameOver = false
        numberOfTries = 0
        enteredNumber = 0
        numberOfTriesTextChange(number: numberOfTries)
        //infoLabel.isHidden = true
        infoLabel.text = ""
        rangeInfoText.text = "Guess the number" + " from " + String(a) + " to " + String(b)
        clearInputNumber()
        genNumber = generateNumber()
        guessButton.setTitle(NSLocalizedString("Guess", comment: ""), for: .normal)
        chancelButton.isHidden = true
    }
    
    func infoLabelTextChange(text: String){
        //infoLabel.isHidden = true
        infoLabel.text = NSLocalizedString(text, comment: "")
    }
    
    func numberOfTriesTextChange(number: Int){
        numberOfTriesLabel.text = String(number)
    }
    
    //MARK: save info in defaults
    func saveInfo (numberTries: Int){
        UserDefaults.standard.set(numberTries,
                                  forKey: InfoKeys.maxTriesKey.rawValue)
        UserDefaults.standard.set(numberTries,
                                  forKey: InfoKeys.minTriesKey.rawValue)
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: InfoKeys.countGamesKey.rawValue) + 1,
                                  forKey: InfoKeys.countGamesKey.rawValue)
    }
    
    func inputNumberError(){
        infoLabelTextChange(text: "Input correct number!")
    }
}


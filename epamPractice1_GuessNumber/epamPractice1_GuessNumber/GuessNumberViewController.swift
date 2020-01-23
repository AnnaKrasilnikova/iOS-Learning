//
//  ViewController.swift
//  epamPractice1_GuessNumber
//
//  Created by Anna Krasilnikova on 23.01.2020.
//  Copyright © 2020 Anna Krasilnikova. All rights reserved.
//

import UIKit

class GuessNumberViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var inputNumber: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var chancelButton: UIButton!
    
    var a: Int = 0
    var b: Int = 0
    var gameOver = false
    
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
            infoLabel.text = "Введите число!"
            return
        }
        b = Int(text) ?? 0
        chancelButton.isHidden = false
        if a > b {
            infoLabel.text = "Мало"
        } else if a < b {
            infoLabel.text = "Много"
        } else {
            infoLabel.text = "Угадал"
            gameOver = true
            guessButton.setTitle("Новая игра", for: .normal)
            chancelButton.isHidden = true
        }
        clearInputNumber()
    }
    
    //MARK: generate new a number
    func generateNumber() -> Int {
        return Int.random(in: 0...5)
    }
    
    //MARK: clear input textField
    func clearInputNumber() {
        inputNumber.text = nil
    }
    
    //MARK: reset all game settings
    func gameOverFunc(){
        gameOver = false
        infoLabel.text = "Угадай число от 0 до 100"
        clearInputNumber()
        a = generateNumber()
        guessButton.setTitle("Мне повезёт!", for: .normal)
        chancelButton.isHidden = true
    }
    
}


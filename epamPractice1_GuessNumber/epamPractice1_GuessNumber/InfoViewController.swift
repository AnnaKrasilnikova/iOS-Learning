//
//  InfoViewController.swift
//  epamPractice1_GuessNumber
//
//  Created by Anna Krasilnikova on 30.01.2020.
//  Copyright © 2020 Anna Krasilnikova. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var maxTries: UILabel!
    @IBOutlet weak var minTries: UILabel!
    @IBOutlet weak var countGames: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            maxTries.text = UserDefaults.standard.string(forKey: InfoKeys.maxTriesKey.rawValue)
            minTries.text = UserDefaults.standard.string(forKey: InfoKeys.minTriesKey.rawValue)
            countGames.text = UserDefaults.standard.string(forKey: InfoKeys.countGamesKey.rawValue)
    }
    
    @IBAction func backToMainButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

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
            getInfoFunc()
    }
    
    
    //MARK: go to main tab
    @IBAction func backToMainButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    //MARK: clear info
    @IBAction func clearInfoButtonTapped(_ sender: Any) {
        setInfoFunc (maxTries: "-", minTries: "-", countGames: 0)
        getInfoFunc()
    }
    
    //MARK: get info from UserDefaults
    func getInfoFunc (){
        maxTries.text = UserDefaults.standard.string(forKey: InfoKeys.maxTriesKey.rawValue)
        minTries.text = UserDefaults.standard.string(forKey: InfoKeys.minTriesKey.rawValue)
        countGames.text = UserDefaults.standard.string(forKey: InfoKeys.countGamesKey.rawValue)
    }
    
    //MARK: save info in UserDefaults
    func setInfoFunc (maxTries: String, minTries: String, countGames: Int){
        UserDefaults.standard.set(maxTries, forKey: InfoKeys.maxTriesKey.rawValue)
        UserDefaults.standard.set(minTries, forKey: InfoKeys.minTriesKey.rawValue)
        UserDefaults.standard.set(countGames, forKey: InfoKeys.countGamesKey.rawValue)
    }
}

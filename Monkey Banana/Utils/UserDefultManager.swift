//
//  UserDefultManager.swift
//  Monkey Banana
//
//  Created by Abdelrahman Rafaat on 05/09/2023.
//

import Foundation

enum UserDefulatManager{
    
   case INSTANCE;
    
    func saveHighScore(score: Int){
        let userDefaults = UserDefaults.standard
        userDefaults.set(score, forKey: "HIGH_SCORE")
        userDefaults.synchronize()
    }
    
    func getHighScore() -> Int{
        UserDefaults.standard.integer(forKey: "HIGH_SCORE")
    }
    
}

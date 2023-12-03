//
//  Core.swift
//  SpaceWiz1
//
//  Created by relwas on 01/12/23.
//

import Foundation

class Core {

    static let shared = Core()

    func isNewUser() -> Bool {
        let isNewUser = !UserDefaults.standard.bool(forKey: "IsNewUser")
        print("IsNewUser:", isNewUser)
        return isNewUser
    }

    func saveUserName(_ name: String) {
        UserDefaults.standard.set(name, forKey: "UserName")
        setIsNotNewUser()
        print("User name saved:", name)
        print("IsNewUser flag set to false")
    }

    
//    func ifUserName

    func shouldShowNameEntry() -> Bool {
        let shouldShow = isNewUser() && UserDefaults.standard.value(forKey: "UserName") == nil
        print("Should show name entry:", shouldShow)
        return shouldShow
    }


    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "IsNewUser")
    }
}

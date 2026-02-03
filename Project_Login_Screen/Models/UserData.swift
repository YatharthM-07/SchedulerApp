//
//  UserData.swift
//  Project_Login_Screen
//
//  Created by GEU on 02/02/26.
//

class UserData {
    static let shared = UserData()
    private init() {}

    private(set) var users: [User] = []

    func saveUser(_ user: User) -> Bool {
        users.append(user)
        print("User saved successfully:")
        print(user)
        return true
    }
}

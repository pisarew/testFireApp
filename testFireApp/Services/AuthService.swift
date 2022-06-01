//
//  AuthService.swift
//  testFireApp
//
//  Created by Глеб Писарев on 03.05.2022.
//

import Foundation
import Firebase
import FirebaseAuth

class AuthService {
    static let shared = AuthService()
    private let auth = Auth.auth()
    
    func register(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void) {
        auth.createUser(withEmail: email!, password: password!) { result, error in
            guard result != nil else {
                completion(.failure(error!))
                return
            }
            completion(.success(result!.user))
        }
    }
    
    func signin(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void) {
        auth.signIn(withEmail: email!, password: password!) { result, error in
            guard result != nil else {
                completion(.failure(error!))
                return
            }
            completion(.success(result!.user))
        }
    }
}

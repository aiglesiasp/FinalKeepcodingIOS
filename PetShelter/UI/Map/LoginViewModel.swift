//
//  LoginViewModel.swift
//  PetShelter
//
//  Created by Joaquín Corugedo Rodríguez on 13/2/23.
//

import Foundation
import KeychainSwift

enum Status: Equatable {
    case none, loading, loaded, error(error: String)
}

final class LoginViewModel: ObservableObject {
    @Published var status = Status.none
    
    @Published var hasError = false
    
    @Published var navigateToDetail = false
    
    @Published var userId = ""
    
    private var repository: Repository
    private var keychain: KeychainSwift
    
    init(repository: Repository = RepositoryImpl(),
         keychain: KeychainSwift = KeychainSwift()) {
        self.repository = repository
        self.keychain = keychain
    }    
    
    func login(user: String, password: String) async {
        
        guard !user.isEmpty, !password.isEmpty else {
            self.status = .error(error: "Debe completar todos los campos")
            hasError = true
            return
        }
        self.status = .loading
        
        let result = await repository.login(user: user, password: password)
        
        switch result {
        case .success(let loginResponse):
            self.status = .loaded
            navigateToDetail = true
            print("Login Result \(loginResponse)")
            self.keychain.set(loginResponse[0], forKey: "AccessToken")
            self.userId = loginResponse[1]
            print("User Id: \(userId)")
        case .failure(let error):
            self.status = Status.error(error: "Usuario y/o Clave incorrectos")
            hasError = true
            print(error.localizedDescription)
        }
    }
}

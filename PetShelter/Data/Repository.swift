//
//  Repository.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 5/2/23.
//

import Foundation

protocol Repository {
    func fetchShelterPoints() async -> Result<[ShelterPointModel], NetworkError>
    func login(user: String, password: String) async -> Result<[String], NetworkError>
    func register(model: ShelterRegisterModel) async -> Result<RegisterState, NetworkError>
    func getShelterDetail(userId: String) async -> Result<ShelterPointModel, NetworkError>
    func updateShelter(userId: String, shelter: ShelterPointModel) async -> Result<ShelterPointModel, NetworkError>
    func uploadPhoto(userId: String, imageData: Data, completion: @escaping (Result<[String: Any], NetworkError>) -> Void)
}

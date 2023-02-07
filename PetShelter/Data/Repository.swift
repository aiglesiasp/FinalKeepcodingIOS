//
//  Repository.swift
//  PetShelter
//
//  Created by Francisco Javier Alarza Sanchez on 5/2/23.
//

import Foundation

protocol Repository {
    func fetchShelterPoints() async -> Result<[ShelterPointModel], NetworkError>
}
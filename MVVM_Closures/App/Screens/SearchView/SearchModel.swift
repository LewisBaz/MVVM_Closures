//
//  SearchModel.swift
//  MVVM_Closures
//
//  Created by Lewis on 10.10.2022.
//

enum SearchModel {
    
    struct BreedsModel: Decodable {
        let message: [String: [String]]
        let status: String
    }
    
    struct Breed {
        let name: String
    }
}

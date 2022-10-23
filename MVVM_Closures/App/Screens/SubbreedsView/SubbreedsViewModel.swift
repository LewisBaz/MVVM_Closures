//
//  SubbreedsViewModel.swift
//  MVVM_Closures
//
//  Created by Lewis on 12.10.2022.
//

final class SubbreedsViewModel {
    
    // MARK: - Closures
    
    var didRecieveBreeds: (([String]) -> Void)?
    var openBreedImages: ((String, String) -> Void)?
    
    // MARK: - Data Properties
    
    private(set) var subbreeds: [String] = []
    private var mainBreed: String
    
    // MARK: - Init
    
    init(subbreeds: [String], mainBreed: String) {
        self.subbreeds = subbreeds
        self.mainBreed = mainBreed
    }
    
    // MARK: - Public Methods
    
    func getBreeds() {
        didRecieveBreeds?(subbreeds)
    }
    
    func didSelectRow(with breed: String) {
        openBreedImages?(mainBreed, breed)
    }
}

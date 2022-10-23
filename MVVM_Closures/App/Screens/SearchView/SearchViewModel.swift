//
//  SearchViewModel.swift
//  MVVM_Closures
//
//  Created by Lewis on 10.10.2022.
//

final class SearchViewModel {
    
    // MARK: - Services
    
    private let networkingService: NetworkingService
    
    // MARK: - Closures
    
    var didRecieveBreeds: (([SearchModel.Breed]) -> Void)?
    var openSubbreeds: ((String, [String]) -> Void)?
    var openBreedImages: ((String) -> Void)?
    
    // MARK: - Data Properties
    
    private(set) var breeds: [String : [String]] = [:]
    
    private(set) var sortedMainBreeds: [SearchModel.Breed] = [] {
        didSet {
            didRecieveBreeds?(sortedMainBreeds)
        }
    }
    
    private var sortedMainBreedsDefault: [SearchModel.Breed] = []
    
    // MARK: - Logic Variables
    
    private var isFirstTimeOpened = true
    
    // MARK: - Init
    
    init(networkingService: NetworkingService) {
        self.networkingService = networkingService
    }
    
    // MARK: - Public Methods
    
    func getBreeds() {
        if isFirstTimeOpened {
            networkingService.getBreeds { [weak self] breeds in
                guard let self = self else { return }
                self.finishedGetBreeds(breeds)
                self.isFirstTimeOpened = false
            }
        } else {
            didRecieveBreeds?(sortedMainBreeds)
        }
    }
    
    func didSelectRow(with breed: String) {
        if let subBreeds = breeds[breed], !subBreeds.isEmpty {
            openSubbreeds?(breed, subBreeds)
        } else {
            openBreedImages?(breed)
        }
    }
    
    func textDidSearch(_ text: String) {
        if text.count == 0 {
            sortedMainBreeds = sortedMainBreedsDefault
        } else {
            sortedMainBreeds = sortedMainBreedsDefault.filter { $0.name.contains(text.lowercased()) }
        }
    }
}

// MARK: - Private Methods

extension SearchViewModel {
    
    func finishedGetBreeds(_ breeds: [String : [String]]) {
        self.breeds = breeds
        sortedMainBreeds = breeds.map { SearchModel.Breed(name: $0.key) }.sorted(by: { $0.name < $1.name })
        sortedMainBreedsDefault = sortedMainBreeds
    }
}

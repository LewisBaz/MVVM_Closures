//
//  BreedsImagesViewModel.swift
//  MVVM_Closures
//
//  Created by Lewis on 17.10.2022.
//

final class BreedsImagesViewModel {
    
    // MARK: - Services
    
    private let networkingService: NetworkingService
    
    // MARK: - Closures
    
    var didRecieveBreedsImages: ((BreedImagesResponse?) -> Void)?
    var didRecieveBreedName: ((String?) -> Void)?
    
    // MARK: - Data Properties
    
    private(set) var breedsImages: BreedImagesResponse? {
        didSet {
            didRecieveBreedsImages?(breedsImages)
        }
    }
    
    private(set) var breed: String? {
        didSet {
            didRecieveBreedName?(breed)
        }
    }
    
    // MARK: - Init
    
    init(breed: String, subbreed: String? = nil, networkingService: NetworkingService) {
        self.networkingService = networkingService
        self.getImages(for: breed, subbreed: subbreed)
    }
}

// MARK: - Private Methods

private extension BreedsImagesViewModel {
    
    func getImages(for breed: String, subbreed: String? = nil) {
        networkingService.getBreedImage(breed: breed, subbreed: subbreed) { [weak self] images in
            guard let self = self else { return }
            self.breedsImages = images
            if let subbreed {
                self.breed = subbreed
            } else {
                self.breed = breed
            }
        }
    }
}

//
//  SearchRouter.swift
//  MVVM_Closures
//
//  Created by Lewis on 12.10.2022.
//

import UIKit

final class SearchRouter {
    
    // MARK: - MVVM Properties
    
    unowned var viewModel: SearchViewModel
    
    // MARK: - Init
    
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Public Methods
    
    func openBreedImage(_ breed: String, from controller: UIViewController) {
        let networkingService = Networking()
        let viewModel = BreedsImagesViewModel(breed: breed, networkingService: networkingService)
        let viewController = BreedsImagesCollectionView(viewModel: viewModel)
        controller.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openBreedSubbreeds(breed: String, subBreeds: [String], from controller: UIViewController) {
        let viewModel = SubbreedsViewModel(subbreeds: subBreeds, mainBreed: breed)
        let router = SubbreedsRouter(viewModel: viewModel)
        let viewController = SubbreedsViewController(viewModel: viewModel, router: router)
        controller.navigationController?.pushViewController(viewController, animated: true)
    }
}

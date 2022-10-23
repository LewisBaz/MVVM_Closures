//
//  SubbreedsRouter.swift
//  MVVM_Closures
//
//  Created by Lewis on 12.10.2022.
//

import UIKit

final class SubbreedsRouter {
    
    // MARK: - MVVM Properties
    
    unowned var viewModel: SubbreedsViewModel
    
    // MARK: - Init
    
    init(viewModel: SubbreedsViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Public Methods
    
    func openBreedImage(_ breed: String, subbreed: String, from controller: UIViewController) {
        let networkingService = Networking()
        let viewModel = BreedsImagesViewModel(breed: breed, subbreed: subbreed, networkingService: networkingService)
        let viewController = BreedsImagesCollectionView(viewModel: viewModel)
        controller.navigationController?.pushViewController(viewController, animated: true)
    }
}

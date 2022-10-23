//
//  SceneDelegate.swift
//  MVVM_Closures
//
//  Created by Lewis on 10.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let networkingService = Networking()
        let viewModel = SearchViewModel(networkingService: networkingService)
        let router = SearchRouter(viewModel: viewModel)
        let viewController = SearchViewController(viewModel: viewModel, router: router)
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        window?.makeKeyAndVisible()
    }
}


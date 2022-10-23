//
//  Networking.swift
//  MVVM_Closures
//
//  Created by Lewis on 10.10.2022.
//

import Foundation

typealias BreedResponse = [String : [String]]
typealias BreedImagesResponse = [String]

protocol NetworkingService {
    func getBreeds(completion: @escaping (BreedResponse) -> Void)
    func getBreedImage(breed: String, subbreed: String?, completion: @escaping (BreedImagesResponse) -> Void)
}

final class Networking: NetworkingService {
    
    // MARK: - Properties
    
    private let session = URLSession.shared
    
    // MARK: - Data Properties
    
    private let baseURLString = "https://dog.ceo/api/breeds/"
    private let baseURLImageString = "https://dog.ceo/api/breed/"
    
    // MARK: - Protocol Methods
    
    func getBreeds(completion: @escaping (BreedResponse) -> Void) {
        let pathString = "list/all"
        let request = URLRequest(url: URL(string: baseURLString + pathString)!)
        let task = session.dataTask(with: request) { (data, _, _) in
            DispatchQueue.main.async {
                guard let data = data,
                      let response = try? JSONDecoder().decode(SearchModel.BreedsModel.self, from: data) else { return }
                completion(response.message)
            }
        }
        task.resume()
    }
    
    func getBreedImage(breed: String, subbreed: String? = nil, completion: @escaping (BreedImagesResponse) -> Void) {
        var urlString = baseURLImageString + breed
        if subbreed != nil {
            urlString.append("/\(subbreed ?? "")/images")
        } else {
            urlString.append("/images")
        }
        let request = URLRequest(url: URL(string: urlString)!)
        let task = session.dataTask(with: request) { (data, _, _) in
            DispatchQueue.main.async {
                guard let data = data,
                      let response = try? JSONDecoder().decode(BreedsImages.ImagesModel.self, from: data) else { return }
                completion(response.message)
            }
        }
        task.resume()
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, completion: @escaping (Data) -> Void) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                completion(data)
            }
        }
    }
}

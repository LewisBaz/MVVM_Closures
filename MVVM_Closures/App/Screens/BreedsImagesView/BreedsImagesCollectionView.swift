//
//  BreedsImagesCollectionView.swift
//  MVVM_Closures
//
//  Created by Lewis on 17.10.2022.
//

import UIKit

final class BreedsImagesCollectionView: UICollectionViewController {
    
    // MARK: - MVVM Properties
    
    private let viewModel: BreedsImagesViewModel
    
    // MARK: - Data Properties
    
    private var breedsImagesData: BreedImagesResponse = []
    
    // MARK: - Init
    
    init(viewModel: BreedsImagesViewModel) {
        self.viewModel = viewModel
        let layout = UICollectionViewFlowLayout()
        let inset: CGFloat = 10
        let itemSideSize = UIScreen.main.bounds.width - (inset * 2)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.itemSize = CGSize(width: itemSideSize, height: itemSideSize)
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
    }
}

private extension BreedsImagesCollectionView {
    
    func setupView() {
        collectionView.register(BreedImageCell.self, forCellWithReuseIdentifier: BreedImageCell.reuseIdentifier)
    }
    
    func setupViewModel() {
        viewModel.didRecieveBreedsImages = { [weak self] images in
            guard let self = self else { return }
            self.breedsImagesData = images ?? []
            self.collectionView.reloadData()
        }
        
        viewModel.didRecieveBreedName = { [weak self] breedName in
            guard let self = self else { return }
            self.title = breedName?.uppercased()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension BreedsImagesCollectionView {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return breedsImagesData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BreedImageCell.reuseIdentifier, for: indexPath) as! BreedImageCell
        cell.configure(with: breedsImagesData[indexPath.row])
        return cell
    }
}

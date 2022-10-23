//
//  BreedImageCell.swift
//  MVVM_Closures
//
//  Created by Lewis on 17.10.2022.
//

import UIKit

final class BreedImageCell: UICollectionViewCell {
    
    static let reuseIdentifier = "BreedImageCell"
    
    // MARK: - UI Elements
    
    private let breedImageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Managers
    
    private let networkingManager = Networking()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        breedImageView.image = nil
        activityIndicator.removeFromSuperview()
    }
    
    // MARK: - Public Methods
    
    func configure(with imageString: String) {
        guard let url = URL(string: imageString) else { return }
        addSubview(activityIndicator)
        activityIndicator.center = contentView.center
        activityIndicator.startAnimating()
        networkingManager.downloadImage(from: url) { [weak self] imageData in
            guard let self = self else { return }
            self.breedImageView.image = UIImage(data: imageData)
            self.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - Private Methods

private extension BreedImageCell {
    
    func setupView() {
        addViews()
        setupImageView()
    }
    
    func addViews() {
        addSubview(breedImageView)
    }
    
    func setupImageView() {
        breedImageView.frame = self.bounds
        breedImageView.contentMode = .scaleAspectFit
    }
}

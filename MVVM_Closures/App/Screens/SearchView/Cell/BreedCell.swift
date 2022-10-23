//
//  BreedCell.swift
//  MVVM_Closures
//
//  Created by Lewis on 10.10.2022.
//

import UIKit

final class BreedCell: UITableViewCell {
    
    static let reuseIdentifier = "BreedCell"
    
    // MARK: - UI Elements
    
    private let breedLabel = UILabel()
    
    // MARK: - Data Properties
    
    private(set) var breedName: String = ""
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Public Methods
    
    func configure(with text: String) {
        breedLabel.text = text
        breedName = text
    }
}

// MARK: - Private Methods

private extension BreedCell {
    
    func setupView() {
        separatorInset = .zero
        addViews()
        setupLabel()
        setupConstraints()
    }
    
    func addViews() {
        addSubview(breedLabel)
    }
    
    func setupConstraints() {
        breedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12).isActive = true
        breedLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 12).isActive = true
        breedLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        breedLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 12).isActive = true
    }
    
    func setupLabel() {
        breedLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}

//
//  SubbreedsViewController.swift
//  MVVM_Closures
//
//  Created by Lewis on 12.10.2022.
//

import UIKit

final class SubbreedsViewController: UITableViewController {
    
    // MARK: - MVVM Properties
    
    private let viewModel: SubbreedsViewModel
    private let router: SubbreedsRouter
    
    // MARK: - Data Properties
    
    private var breedsData: [String] = []
    
    // MARK: - Init
    
    init(viewModel: SubbreedsViewModel, router: SubbreedsRouter) {
        self.viewModel = viewModel
        self.router = router
        super.init(style: .plain)
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
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getBreeds()
    }
}

// MARK: - Private Methods

private extension SubbreedsViewController {
    
    func setupView() {
        view.backgroundColor = .white
        tableView.register(BreedCell.self, forCellReuseIdentifier: BreedCell.reuseIdentifier)
    }
    
    func setupViewModel() {
        viewModel.didRecieveBreeds = { [weak self] breeds in
            guard let self = self else { return }
            self.breedsData = breeds
            self.tableView.reloadData()
        }
        
        viewModel.openBreedImages = { [weak self] mainBreed, subbreed in
            guard let self = self else { return }
            self.router.openBreedImage(mainBreed, subbreed: subbreed, from: self)
        }
    }
}

// MARK: - UITableViewDataSource

extension SubbreedsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breedsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BreedCell.reuseIdentifier, for: indexPath) as! BreedCell
        cell.configure(with: breedsData[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SubbreedsViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BreedCell else { return }
        viewModel.didSelectRow(with: cell.breedName)
    }
}

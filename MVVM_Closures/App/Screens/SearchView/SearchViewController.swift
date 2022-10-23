//
//  SearchViewController.swift
//  MVVM_Closures
//
//  Created by Lewis on 10.10.2022.
//

import UIKit

final class SearchViewController: UITableViewController {
    
    // MARK: - MVVM Properties
    
    private let viewModel: SearchViewModel
    private let router: SearchRouter
    
    // MARK: - UI Elements
    
    private let searchBar = UISearchBar()
    
    // MARK: - Data Properties
    
    private var breedsData: [SearchModel.Breed] = []
    
    // MARK: - Init
    
    init(viewModel: SearchViewModel, router: SearchRouter) {
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
        setupSearchBar()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getBreeds()
    }
}

// MARK: - Private Methods

private extension SearchViewController {
    
    func setupView() {
        view.backgroundColor = .white
        tableView.register(BreedCell.self, forCellReuseIdentifier: BreedCell.reuseIdentifier)
        tableView.tableHeaderView = searchBar
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchBarStyle = .default
        searchBar.placeholder = "Search breed..."
        searchBar.sizeToFit()
    }
    
    func setupViewModel() {
        viewModel.didRecieveBreeds = { [weak self] breeds in
            guard let self = self else { return }
            self.breedsData = breeds
            self.tableView.reloadData()
        }
        
        viewModel.openSubbreeds = { [weak self] mainBreed, subBreeds in
            guard let self = self else { return }
            self.router.openBreedSubbreeds(breed: mainBreed, subBreeds: subBreeds, from: self)
        }
        
        viewModel.openBreedImages = { [weak self] breed in
            guard let self = self else { return }
            self.router.openBreedImage(breed, from: self)
        }
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breedsData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BreedCell.reuseIdentifier, for: indexPath) as! BreedCell
        cell.configure(with: breedsData[indexPath.row].name)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SearchViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? BreedCell else { return }
        viewModel.didSelectRow(with: cell.breedName)
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.textDidSearch(searchText)
    }
}

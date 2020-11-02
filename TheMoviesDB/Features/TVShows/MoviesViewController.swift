//
//  ViewController.swift
//  TheMoviesDB
//
//  Created by Lang Troyan on 01/11/2020.
//

import UIKit
import CoreData

class MoviesViewController: BaseViewController {

    // MARK: - Properties -
    // MARK: Public
    @IBOutlet weak var tableView: UITableView!
    // MARK: Private
    var viewModel: MoviesViewModel?

    // MARK: - Inits -
    
    // MARK: - Methods -
    
    // MARK: Public
    // MARK: Private
    
    // MARK: - UIViewController -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel = MoviesViewModel()
        viewModel?.loadMovies(in: Pagination.firstPage) { error in
            guard error == nil else {
                self.showErrorAlert(title: LocalizableKeys.error.localized, message: error?.localizedDescription ?? LocalizableKeys.defaultErrorMessage.localized) { _ in
                    self.viewModel?.loadMovies(in: Pagination.firstPage)
                }
                return
            }
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource -
extension MoviesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        if viewModel.hasNextPage() {
            return viewModel.getMoviesCount() + 1
        }
        else {
            return viewModel.getMoviesCount()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        if indexPath.row + 1 == tableView.numberOfRows(inSection: indexPath.section), viewModel.hasNextPage() {
            // TODO: Show loading cell
        }
        else if let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.Constants.identifier, for: indexPath) as? MovieCell {
            cell.movie = viewModel.getMovie(for: indexPath)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
}

// MARK: - UITableViewDelegate -
extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        if indexPath.row + 1 == tableView.numberOfRows(inSection: indexPath.section), viewModel.hasNextPage() {
            viewModel.loadNextPage() { error in
                guard error == nil else { return }
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel,
              let movie = viewModel.getMovie(for: indexPath),
              let vc = MovieDetailsViewControler.instantiate() else { return }
        vc.tvShow = movie
        navigationController?.present(vc, animated: true, completion: nil)
    }
}

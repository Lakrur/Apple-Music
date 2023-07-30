//
//  SearchViewController.swift
//  Apple Music
//
//  Created by Yehor Krupiei on 27.07.2023.
//

import UIKit

class SearchViewController: UITableViewController {
    
    var networkService = NetworkService()
    private var timer: Timer?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var tracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupSearchBar()
        
        tableView.register(TrackCell.loadNib(), forCellReuseIdentifier: TrackCell.reusableIdentifier)
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.reusableIdentifier, for: indexPath) as! TrackCell
        
        let track = tracks[indexPath.row]
        
        cell.trackImageView.backgroundColor = .red
        
        cell.trackNameLabel.text = track.trackName
        cell.artistNameLabel.text = track.artistName
        cell.collectionNameLabel.text = track.collectionName
        
//        cell.textLabel?.text = "\(track.trackName)\n\(track.artistName)"
//        cell.textLabel?.numberOfLines = 2
//        cell.imageView?.image = UIImage(imageLiteralResourceName: "wlr")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.networkService.fetchTracks(searchText: searchText) { [weak self] searchResults in
                self?.tracks = searchResults?.results ?? []
                self?.tableView.reloadData()
            }
        })
    }
    
}

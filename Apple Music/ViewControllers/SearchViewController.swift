//
//  SearchViewController.swift
//  Apple Music
//
//  Created by Yehor Krupiei on 27.07.2023.
//

import UIKit
import SDWebImage

class SearchViewController: UITableViewController {
    
    private var timer: Timer?
    private lazy var footerView = FooterView()
    
    var networkService = NetworkService()
    var tracks = [Track]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupSearchBar()
        
        tableView.register(TrackCell.loadNib(), forCellReuseIdentifier: TrackCell.reusableIdentifier)
        tableView.tableFooterView = footerView
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
        
        cell.trackNameLabel.text = track.trackName
        cell.artistNameLabel.text = track.artistName
        cell.collectionNameLabel.text = track.collectionName
        cell.trackImageView.sd_setImage(with: URL(string: track.posterURL ?? ""), completed: nil)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = tracks[indexPath.row]
        
       
        let window = UIApplication.shared.keyWindow
        let trackDetailView = Bundle.main.loadNibNamed("TrackDetailView", owner: self, options: nil)?.first as! TrackDetailView
        window?.addSubview(trackDetailView)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tracks.count > 0 {
            return nil
        } else {
            let label = UILabel()
            label.text = "Please enter search term above..."
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            return label
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tracks.count > 0 ? 0 : 250
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            if searchText.isEmpty {
                self.tracks.removeAll()
                self.tableView.reloadData()
                self.footerView.isHidden = true
                self.footerView.hideLoader()
            } else {
                self.footerView.isHidden = false
                self.footerView.showLoader()
            }
            
            self.networkService.fetchTracks(searchText: searchText) { [weak self] searchResults in
                self?.tracks = searchResults?.results ?? []
                self?.tableView.reloadData()
                
                if searchText.isEmpty {
                    self?.footerView.hideLoader()
                }
            }
        })
    }
}


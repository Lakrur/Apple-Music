//
//  TrackCell.swift
//  Apple Music
//
//  Created by Yehor Krupiei on 31.07.2023.
//

import UIKit

class TrackCell: UITableViewCell, HasCellID, NibLoading {
    
    @IBOutlet var trackNameLabel: UILabel!
    @IBOutlet var trackImageView: UIImageView!
    @IBOutlet var artistNameLabel: UILabel!
    @IBOutlet var collectionNameLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        
        trackImageView.image = nil
    }
}

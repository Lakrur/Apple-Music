//
//  TrackDetailView.swift
//  Apple Music
//
//  Created by Yehor Krupiei on 01.08.2023.
//

import UIKit
import SDWebImage
import AVKit

class TrackDetailView: UIView {
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var currentTimeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var authorTitleLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIStackView!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var playPauseButtonOutlet: UIButton!
    
    let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    // MARK: awakeFromNib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let scale: CGFloat = 0.8
        self.trackImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        
        trackTitle.layer.cornerRadius = 5
        
    }
    
    // MARK: Setup
    
    func set(trackModel: Track) {
        trackTitle.text = trackModel.trackName
        authorTitleLabel.text = trackModel.artistName
        
        let string600 = trackModel.posterURL?.replacingOccurrences(of: "100x100", with: "600x600")
        guard let url = URL(string: string600 ?? "") else { return }
        
        monitorStartTime()
        trackImageView.sd_setImage(with: url)
        playTrack(previewUrl: trackModel.previewUrl)
        
    }
    
    private func playTrack(previewUrl: String?) {
        
        guard let url = URL(string: previewUrl ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    // MARK: Time Setup
    
    private func monitorStartTime() {
        
        let time = CMTimeMake(value: 1, timescale: 3)
        let times = [NSValue(time: time)]
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) { [weak self] in
            self?.enlargeTrackImageView()
        }
    }
    
    // MARK: Animations
    
    private func enlargeTrackImageView() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.trackImageView.transform = .identity
        }, completion: nil)
    }
    
    private func reduceTrackImageView() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            let scale: CGFloat = 0.8
            self.trackImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: nil)
    }
    
    // MARK: @IBActions
    
    @IBAction func handleCurrentTimeSlider(_ sender: Any) {
    }
    
    
    @IBAction func handleVolumeSlider(_ sender: Any) {
    }
    
    @IBAction func dragDownButtonTapped(_ sender: Any) {
        
        self.removeFromSuperview()
    }
    
    @IBAction func previousTrack(_ sender: Any) {
    }
    
    
    @IBAction func nextTrack(_ sender: Any) {
    }
    
    @IBAction func playPauseAction(_ sender: Any) {
        if player.timeControlStatus == .paused {
            player.play()
            playPauseButtonOutlet.setImage(UIImage(named: "pause"), for: .normal)
            enlargeTrackImageView()
        } else if player.timeControlStatus == .playing {
            player.pause()
            playPauseButtonOutlet.setImage(UIImage(named: "play"), for: .normal)
            reduceTrackImageView()
        }
    }
}


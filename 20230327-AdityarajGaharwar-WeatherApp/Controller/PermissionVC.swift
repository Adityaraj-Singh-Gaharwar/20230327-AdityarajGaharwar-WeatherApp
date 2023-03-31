//
//  PermissionVC.swift
//  20230327-AdityarajGaharwar-WeatherApp
//
//  Created by Adityaraj Singh Gaharwar on 28/03/23.
//

import UIKit
import AVKit

/* This class is shown for getting user location permission and then showing the weather */
class PermissionVC: UIViewController {
    //MARK: - Variables
    var latitude: String?
    var longitude: String?
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        CurrentLocation.sharedInstance.getCurrentLocation { lat, long in
            self.latitude = lat
            self.longitude = long
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playVideoBackground()
    }
    
    //MARK: - Actions
    @IBAction func btnNextTap(_ sender: UIButton) {
        guard let vc = Storyboards.Main(controller: Controller.Weather) as? WeatherVC else {return}
        vc.latitude = self.latitude
        vc.longitude = self.longitude
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - flow func
    //Background video
    @objc func playerItemDidReachEnd(notification: Notification) {
        let playerItem: AVPlayerItem = notification.object as! AVPlayerItem
        playerItem.seek(to: .zero, completionHandler: nil)
    }
    
    private func playVideoBackground() {
        guard let url = Bundle.main.url(forResource: "background", withExtension: "mp4") else { return }
        let player = AVPlayer(url: url)
        let videoLayer = AVPlayerLayer(player: player)
        
        videoLayer.videoGravity = .resizeAspectFill
        player.volume = 0
        player.actionAtItemEnd = .none
        videoLayer.frame = self.view.layer.bounds
        self.view.backgroundColor = .clear
        self.view.layer.insertSublayer(videoLayer, at: 0)
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(playerItemDidReachEnd(notification:)),
                                                   name: .AVPlayerItemDidPlayToEndTime,
                                                   object: player.currentItem)
        player.play()
    }

}

//
//  VideoEditorController.swift
//  4makers
//
//  Created by baptiste Fehrenbach on 09/02/2016.
//  Copyright © 2016 AwH. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoEditorController: UIViewController {
    
    var videoUrl: String = ""
    
    @IBOutlet weak var videoView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let videoURL = NSURL(string: "file://" + videoUrl)
        let player = AVPlayer(URL: videoURL!)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.frame
        videoView.layer.addSublayer(playerLayer)
        player.play()
    }
    
}

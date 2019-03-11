//
//  VC+Extensions.swift
//  CatLover
//
//  Created by Jian Ting Li on 2/25/19.
//  Copyright © 2019 Jian Ting Li. All rights reserved.
//

import UIKit
import AVKit

extension UIViewController {
    public func showAlert(title: String, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    public func playFirstLaunchVideo() {
        if let _ = UserDefaults.standard.object(forKey: UserDefaultsKeys.appFirstLaunch) as? Bool {
            return
        } else {
            if let path = Bundle.main.path(forResource: "CatFirstTimeVideo", ofType: "MP4") {
                let video = AVPlayer(url: URL(fileURLWithPath: path))
                let videoPlayer = AVPlayerViewController()
                videoPlayer.player = video
                present(videoPlayer, animated: true, completion: {
                    video.play()
                })
            }
            UserDefaults.standard.set(true, forKey: UserDefaultsKeys.appFirstLaunch)
        }
    }
}

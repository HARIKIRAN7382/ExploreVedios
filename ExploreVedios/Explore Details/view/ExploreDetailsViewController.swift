//
//  ExploreDetailsViewController.swift
//  ExploreVedios
//
//  Created by iOS Developer on 27/04/21.
//

import UIKit
import AVKit

class ExploreDetailsViewController: UIViewController {
    
    @IBOutlet weak var explorePlayerView: UIView!
    
    var avpController = AVPlayerViewController()
    var   vediosNodes: [Node]?
    var  selectedIndex:Int?
    var  selectionType:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectionType = selectionType{
            self.title = selectionType
        }
        
        guard let videoURL = URL(string: vediosNodes?[selectedIndex ?? 0].video?.encodeURL ?? "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8") else {
            return
        }
        playTheURLVedio(videoURL: videoURL)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipeUp(_:)))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipeDown(_:)))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRigth(_:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func swipeRigth(_ sender:UIGestureRecognizer){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func swipeUp(_ sender:UIGestureRecognizer) {
        if let selectedIndex = self.selectedIndex, selectedIndex < ((self.vediosNodes?.count ?? 0) - 1){
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
                self.explorePlayerView.center.y -= self.view.bounds.height
                self.explorePlayerView.layoutIfNeeded()
            } completion: { (bool) in
                self.explorePlayerView.center.y += self.view.bounds.height
            }
            self.selectedIndex = selectedIndex + 1
            guard let videoURL = URL(string: self.vediosNodes?[self.selectedIndex ?? 0].video?.encodeURL ?? "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8") else {
                return
            }
            self.playTheURLVedio(videoURL: videoURL)
        }else{
            self.showToast(message: "You reached all of vedios\nSwipe up to see more.", font: .systemFont(ofSize: 16, weight: .semibold), toastPosition: .middle)
        }
    }
    
    @objc func swipeDown(_ sender:UIGestureRecognizer) {
        if let selectedIndex = self.selectedIndex, selectedIndex != 0{
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) {
                self.explorePlayerView.center.y += self.view.bounds.height
                self.explorePlayerView.layoutIfNeeded()
            } completion: { (bool) in
                self.explorePlayerView.center.y -= self.view.bounds.height
            }
            self.selectedIndex = selectedIndex - 1
            guard let videoURL = URL(string: self.vediosNodes?[self.selectedIndex ?? 0].video?.encodeURL ?? "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8") else {
                return
            }
            self.playTheURLVedio(videoURL: videoURL)
        }else{
            self.showToast(message: "You reached all of vedios\nSwipe down to see more.", font: .systemFont(ofSize: 16, weight: .semibold), toastPosition: .middle)
        }
    }
    
    
    
    func playTheURLVedio(videoURL:URL){
        
        let player = AVPlayer(url: videoURL)
        
        avpController.player = player
        
        avpController.view.backgroundColor = .white
        
        avpController.view.frame.size.height = explorePlayerView.frame.size.height
        
        avpController.view.frame.size.width = explorePlayerView.frame.size.width
        
        if(self.explorePlayerView.subviews.contains(avpController.view)){
            avpController.player?.play()
        }else{
            self.explorePlayerView.addSubview(avpController.view)
            avpController.player?.play()
        }
    }
    
}

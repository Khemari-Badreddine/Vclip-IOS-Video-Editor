//
//  VideoPlayerView.swift
//  YouTubeMiniPlayer
//
//  Created by Ginger on 14/02/2021.
//

import SwiftUI
import AVKit

struct testVideoPlayerView: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        
        let controller = AVPlayerViewController()
        
        // Video URL
        if let bundle_url = Bundle.main.path(forResource: "video", ofType: "mp4") {
            let video_url = URL(fileURLWithPath: bundle_url)
            
            // Player
            let player = AVPlayer(url: video_url)
            
            print("this is the video url:", video_url)
            
            controller.player = player
            
            // Hiding Controls
            controller.showsPlaybackControls = false
            controller.player?.pause()
            controller.videoGravity = .resizeAspectFill
        } else {
            print("Video file not found in the bundle.")
        }
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        // Update logic if needed
    }
}


struct VideoPlayerPreviews: PreviewProvider {
    static var previews: some View {
        testVideoPlayerView()
    }
}

//
//  VideoHelper.swift
//  Vclip App
//
//  Created by Pedro on 5/2/2024.
//

import Foundation
import VideoEditorSDK
import AVKit

class VideoHelper {
    
    static func getThumbnail(from player: AVPlayer, at time: CMTime) -> CGImage? {
        do {
            guard let currentItem = player.currentItem else { return nil }
            let asset = currentItem.asset
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: time, actualTime: nil)
            return cgImage
        } catch _ {
            return nil
        }
    }
    
    static func getThumbnail(from asset: AVAsset?, at time: CMTime) -> CGImage? {
        do {
            guard let asset = asset else { return nil }
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: time, actualTime: nil)
            return cgImage
        } catch _ {
            return nil
        }
    }
    
    static func generateThumbnailImages(_ player: AVPlayer, _ containerSize: CGSize) -> [UIImage] {
        var images: [UIImage] = []
        guard let currentItem = player.currentItem else { return images }
        guard let track = player.currentItem?.asset.tracks(withMediaType: AVMediaType.video).first else { return images }
        let assetSize = track.naturalSize.applying(track.preferredTransform)
        let height = containerSize.height
        let ratio = assetSize.width / assetSize.height
        let width = height * ratio
        let thumbnailCount = Int(ceil(containerSize.width / abs(width)))
        let interval = currentItem.asset.duration.seconds / Double(thumbnailCount)
        for i in 0..<thumbnailCount {
            guard let thumbnail = VideoHelper.getThumbnail(from: currentItem.asset, at: CMTime(seconds: Double(i) * interval, preferredTimescale: 1000)) else { return images }
            images.append(UIImage(cgImage: thumbnail))
        }
        return images
    }
    
    static func getVideoAspectRatio(_ player: AVPlayer) -> CGFloat? {
        guard let track = player.currentItem?.asset.tracks(withMediaType: AVMediaType.video).first else { return nil}
        let assetSize = track.naturalSize.applying(track.preferredTransform)
        return assetSize.width / assetSize.height
    }
    
    static func getCurrentTime(_ player: AVPlayer) -> CMTime? {
        guard let currentItem = player.currentItem else { return nil }
        return currentItem.currentTime()
    }
    
    static func getDuration(_ player: AVPlayer) -> CMTime? {
        guard let currentItem = player.currentItem else { return nil }
        return currentItem.asset.duration
    }
    
    static func getDurationInMinutes(_ player: AVPlayer) -> String? {
        guard let duration = getDuration(player) else { return nil }
        let totalSeconds = CMTimeGetSeconds(duration)
        let minutes = Int(totalSeconds / 60)
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    static func getCurrentTimeInMinutes(_ player: AVPlayer) -> String? {
        guard let currentTime = getCurrentTime(player) else { return nil }
        let currentSeconds = CMTimeGetSeconds(currentTime)
        let minutes = Int(currentSeconds / 60)
        let seconds = Int(currentSeconds.truncatingRemainder(dividingBy: 60))
        return String(format: "%02d:%02d", minutes, seconds)
    }


}


//
//  CustomVideoPlayer.swift
//  Vclip App
//
//  Created by Pedro on 8/2/2024.
//

import Foundation
import AVKit
import SwiftUI

class AVPlayerCoordinator: NSObject, ObservableObject {
    @Published var isFullScreen: Bool = false
}

struct CustomVideoPlayer: UIViewControllerRepresentable {
    let player: AVPlayer
    @ObservedObject var coordinator: AVPlayerCoordinator

    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.delegate = context.coordinator
        return controller
    }

    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        if coordinator.isFullScreen {
            enterFullscreen(playerViewController: uiViewController)
            uiViewController.showsPlaybackControls = true

        }
        else {
            uiViewController.showsPlaybackControls = false

        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    private func enterFullscreen(playerViewController: AVPlayerViewController) {

        let selectorName: String = {
            if #available(iOS 11.3, *) {
                return "_transitionToFullScreenAnimated:interactive:completionHandler:"
            } else {
                return "_transitionToFullScreenViewControllerAnimated:completionHandler:"
            }
        }()
        let selectorToForceFullScreenMode = NSSelectorFromString(selectorName)

        if playerViewController.responds(to: selectorToForceFullScreenMode) {
            playerViewController.perform(selectorToForceFullScreenMode, with: true, with: nil)
        }
    }

    class Coordinator: NSObject, AVPlayerViewControllerDelegate {
        var parent: CustomVideoPlayer

        init(parent: CustomVideoPlayer) {
            self.parent = parent
        }

        func playerViewController(
            _ playerViewController: AVPlayerViewController,
            willBeginFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator
        ) {
            parent.coordinator.isFullScreen = true
        }

        func playerViewController(
            _ playerViewController: AVPlayerViewController,
            willEndFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator
        ) {
            parent.coordinator.isFullScreen = false
        }
    }
}



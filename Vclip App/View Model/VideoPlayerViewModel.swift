//
//  VideoPlayerViewModel.swift
//  Vclip App
//
//  Created by Pedro on 8/2/2024.
//

import Foundation
import SwiftUI

class VideoPlayerViewModel: ObservableObject {

    @Published var offset: CGFloat = 0
    @Published var width: CGFloat = UIScreen.main.bounds.width
    @Published var height: CGFloat =  UIScreen.main.bounds.height
}

//
//  VideoEditorView.swift
//  Vclip App
//
//  Created by Pedro on 3/2/2024.
//

import SwiftUI
import AVKit

struct VideoEditorView: View {
    
    @EnvironmentObject var playermetrics: VideoPlayerViewModel
    
    @State private var player: AVPlayer? = {
        if let bundle = Bundle.main.path(forResource:"video", ofType: "mp4"){
            return .init(url: URL(filePath: bundle))
        }
        return nil
    }()
    
    @State private var isPlaying: Bool = false
    @State private var currentTime: CGFloat = 0
    @State private var isTracking: Bool = false
    @StateObject private var coordinator = AVPlayerCoordinator()
    
    var body: some View {
        ZStack{
            
            VStack {
                
                HStack{
                    
                    Image(systemName: "house")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                    
                    Spacer()
                    
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                    
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(Color.black)
            
            
            VStack{
                if let player {
                    CustomVideoPlayer(player: player,coordinator: coordinator)
                        .frame(width: 300 , height: 360)
                    
                    
                    ControllsView(player: player, isPlaying: $isPlaying,currentTime:$currentTime, coordinator: coordinator)
                    
                    Spacer()
                    
                    VideoScrollPreview(player: player, isPlaying: $isPlaying, currentTime: $currentTime, isTracking: $isTracking)
                        .frame(height: 100)
                    
                    HStack(spacing:20){
                        Image("add")
                            .resizable()
                            .frame(maxWidth: 30,maxHeight:30,alignment:.center)
                            .padding(.bottom,10)
                        
                        customToolview(text: "Music", imageName: "music.note")
                        customToolview(text: "Voice", imageName: "mic")
                        customToolview(text: "Text", imageName: "text")
                        customToolview(text: "Effect", imageName: "star")
                        customToolview(text: "Overlay", imageName: "overlay")
                        //  customToolview(text: "Ratio", imageName: "ratio")
                        
                    }
                    
                }
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            
        }
        
    }
}

struct VideoScrollPreview: View {
    
    let player: AVPlayer
    
    @Binding var isPlaying: Bool
    @Binding var currentTime: CGFloat
    @Binding var isTracking: Bool
    
    @State private var images: [UIImage] = []
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                VStack {
                    
                    Spacer()
                    HStack {
                        HStack() {
                            Image("text")
                            Text("Flow Lifestyle")
                                .foregroundColor(.white)
                                .font(.title3)
                        }
                        .padding(10)
                        .frame(width:300,height: 40,alignment: .leading)
                        .background(Color("purplish"))
                        .cornerRadius(20)
                        Spacer()
                        
                    }
                    
                    HStack {
                        HStack() {
                            Image("overlay")
                            Text("Color overlay")
                                .foregroundColor(.white)
                                .font(.title3)
                        }
                        .padding(10)
                        .frame(width:200,height: 40,alignment: .leading)
                        .background(.pink)
                        .cornerRadius(20)
                        Spacer()
                        
                    }
                    
                    
                    
                    HStack(spacing: 0) {
                        ForEach(images, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                        }
                    }
                    .frame(height: 60)
                    .cornerRadius(20)
                    
                    Spacer()
                    
                }
                .frame(height:200,alignment:.bottom)
                
                
                
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .frame(width: 4, height: 220)
                    .position(x: currentTime * geometry.size.width, y: geometry.size.height-10 )
                    .foregroundColor(.white)
                    .shadow(radius: 10)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,maxHeight:220)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({
                        isTracking = true
                        if isPlaying {
                            player.pause()
                        }
                        currentTime = min(geometry.size.width, max(0, $0.location.x)) / geometry.size.width
                        guard let duration = VideoHelper.getDuration(player) else { return }
                        let targetTime = CMTimeMultiplyByFloat64(duration, multiplier: Float64(currentTime))
                        player.seek(to: targetTime)
                    })
                    .onEnded({ _ in
                        isTracking = false
                        if isPlaying {
                            player.play()
                        }
                    })
            )
            .position(x: geometry.frame(in: .local).midX, y: geometry.frame(in: .local).minY)
            .onAppear {
                images = VideoHelper.generateThumbnailImages(player, geometry.size)
            }
        }
    }
}

struct VideoPlayerControls: View {
    
    var player: AVPlayer
    
    @Binding var currentTime: CGFloat
    
    var height: CGFloat = 50
    var actionImage: String = "plus"
    
    @Binding var isPlaying: Bool
    @State private var isTracking: Bool = false
    @State private var timeObserver: Any?
    
    var action: (() -> Void)?
    
    var body: some View {
        HStack(spacing: 0) {
            Button {
                isPlaying ? player.pause() : player.play()
                isPlaying.toggle()
            } label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .resizable()
                    .padding()
                    .frame(width: height, height: height, alignment: .center)
            }
            .foregroundColor(.white)
            .overlay(Rectangle().frame(width: 1, height: nil).foregroundColor(Color.black), alignment: .trailing)
            
            VideoScrollPreview(player: player, isPlaying: $isPlaying, currentTime: $currentTime, isTracking: $isTracking)
                .padding(4)
                .frame(width: nil, height: height)
            
            if let action = action {
                Button {
                    action()
                } label: {
                    Image(systemName: actionImage)
                        .resizable()
                        .padding()
                        .frame(width: height, height: height, alignment: .center)
                }
                .foregroundColor(.white)
                .overlay(Rectangle().frame(width: 1, height: nil).foregroundColor(Color.black), alignment: .leading)
            }
        }
        .background(.gray)
        .cornerRadius(5)
        .onAppear {
            startPeriodicTimeObserver()
        }
        .onDisappear {
            stopPeriodicTimeObserver()
        }
    }
    
    func startPeriodicTimeObserver() {
        timeObserver = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: nil) { time in
            guard isTracking == false else { return }
            guard let duration = VideoHelper.getDuration(player) else { return }
            self.currentTime = CGFloat(CMTimeGetSeconds(time) / CMTimeGetSeconds(duration))
            if self.currentTime == 1.0 {
                self.isPlaying = false
            }
        }
    }
    
    func stopPeriodicTimeObserver() {
        guard let observer = timeObserver else { return }
        player.removeTimeObserver(observer)
    }
}

struct ControllsView: View {
    
    var player: AVPlayer
    @Binding var isPlaying: Bool
    @Binding var currentTime: CGFloat
    @ObservedObject var coordinator: AVPlayerCoordinator
    @State private var timeObserver: Any?
    
    var height: CGFloat = 50
    var actionImage: String = "plus"
    
    @State private var isTracking: Bool = false
    
    
    var body: some View {
        @State var currentTimemins = VideoHelper.getCurrentTimeInMinutes(player)
        
        let duration = VideoHelper.getDuration(player)
        
        let durationMins = VideoHelper.getDurationInMinutes(player)
        
        let currenttimeMins = formatTime(seconds: currentTime * CGFloat(CMTimeGetSeconds(duration!)))
        
        HStack{
            Button(action: {
                isPlaying ? player.pause() : player.play()
                isPlaying.toggle()
            }, label: {
                Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        ZStack {
                            Circle()
                                .fill(.gray.opacity(0.4))
                        }
                    )
                    .font(.system(size: 16))
            })
            Spacer()
            
            Button(action: {
                
            }, label: {
                Image(systemName: "arrowshape.turn.up.backward")
                    .foregroundColor(.white)
                    .padding()
                
                    .font(.system(size: 16))
            })
            
            Text("\(currenttimeMins)")
                .foregroundColor(.white)
                .font(.system(size: 16))
            
            Text(durationMins!)
                .foregroundColor(.white)
                .font(.system(size: 16))
            
            
            Button(action: {
                
            }, label: {
                Image(systemName: "arrowshape.turn.up.forward")
                    .foregroundColor(.white)
                    .padding()
                
                    .font(.system(size: 16))
            })
            
            Spacer()
            
            Button(action: {
                
                coordinator.isFullScreen.toggle()
                
            }, label: {
                Image( "fullscreen")
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        ZStack {
                            Circle()
                                .fill(.gray.opacity(0.4))
                        }
                    )
                    .font(.system(size: 16))
            })
            
        }
        .onAppear {
            startPeriodicTimeObserver()
        }
        .onDisappear {
            stopPeriodicTimeObserver()
        }
    }
    
    func startPeriodicTimeObserver() {
        timeObserver = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.1, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: nil) { time in
            guard isTracking == false else { return }
            guard let duration = VideoHelper.getDuration(player) else { return }
            self.currentTime = CGFloat(CMTimeGetSeconds(time) / CMTimeGetSeconds(duration))
            if self.currentTime == 1.0 {
                self.isPlaying = false
            }
        }
    }
    
    func stopPeriodicTimeObserver() {
        guard let observer = timeObserver else { return }
        player.removeTimeObserver(observer)
    }
    
    
    func formatTime(seconds: CGFloat) -> String {
        let totalSeconds = Int(seconds)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
}

struct VideoEditor: View {
    let initialVideoURL: URL? = Bundle.main.url(forResource: "video2", withExtension: "mov")
    @State  var videoURL: URL?
    @State private var trimmedVideoURL: URL?
    @State private var startTime: CMTime = .zero
    @State private var endTime: CMTime = .zero
    @State private var sliderValue: Double = 0
    
    init() {
        _videoURL = State(initialValue: initialVideoURL)
    }
    
    var body: some View {
        VStack {
            if let videoURL = videoURL {
                VideoPlayer(player: AVPlayer(url: videoURL))
                    .frame(height: 200)
            }
            
            HStack {
                Button("Trim Video") {
                    self.trimVideo()
                }
                
                Slider(value: $sliderValue, in: 0...1) {
                    Text("Trimming Progress: \(sliderValue)")
                }
            }
            
            if let trimmedVideoURL = trimmedVideoURL {
                VideoPlayer(player: AVPlayer(url: trimmedVideoURL))
                    .frame(height: 200)
            }
        }
        .onAppear {
            guard let url = videoURL else { return }
            let asset = AVAsset(url: url)
            self.startTime = CMTime(seconds: 0, preferredTimescale: 600)
            self.endTime = asset.duration
            self.sliderValue = 0
        }
    }
    
    private func trimVideo() {
        guard let videoURL = videoURL else { return }
        
        let asset = AVAsset(url: videoURL)
        let exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetHighestQuality)
        let timeRange = CMTimeRange(start: startTime, duration: CMTimeSubtract(endTime, startTime))
        
        exportSession?.outputURL = FileManager.default.temporaryDirectory.appendingPathComponent("trimmedVideo.mp4")
        exportSession?.outputFileType = .mp4
        exportSession?.timeRange = timeRange
        
        exportSession?.exportAsynchronously {
            DispatchQueue.main.async {
                self.trimmedVideoURL = exportSession?.outputURL
            }
        }
    }
    
    private func updateEndTime() {
        guard let url = videoURL else { return }
        
        let asset = AVAsset(url: url)
        
        endTime = CMTimeAdd(startTime, CMTimeMake(value: Int64(Double(asset.duration.seconds) * sliderValue), timescale: 600))
        
    }
}

class VideoEditorWrapper: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private let videoEditor: VideoEditor
    
    init(videoEditor: VideoEditor) {
        self.videoEditor = videoEditor
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let videoURL = info[.mediaURL] as? URL {
            videoEditor.videoURL = videoURL
        }
        picker.dismiss(animated: true)
    }
}

private struct customToolview :View {
    
    var text,imageName: String
    
    var body: some View {
        
        Button(action: {
            
        },
               label: {
            
            VStack{
                Image(imageName)
                Text(text)
                    .foregroundColor(.gray)
                    .font(.system(size:15))
            }
            
            
        })
        
    }
}

#Preview {
    VideoEditorView()
}

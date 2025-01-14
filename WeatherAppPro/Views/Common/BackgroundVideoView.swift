//
//  BackgroundVideoView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-19.
//

import SwiftUI
import AVKit
import AVFoundation

struct BackgroundVideoView: UIViewRepresentable {
    @Binding var videoName: String
    let videoType: String

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let player = AVPlayer()
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(playerLayer)

        context.coordinator.player = player
        context.coordinator.playerLayer = playerLayer

        DispatchQueue.main.async {
            playerLayer.frame = view.bounds
        }

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        guard let player = context.coordinator.player,
              let playerLayer = context.coordinator.playerLayer else { return }

        if context.coordinator.currentVideoName != videoName {
            context.coordinator.currentVideoName = videoName

            if let videoURL = Bundle.main.url(forResource: videoName, withExtension: videoType) {
                let newItem = AVPlayerItem(url: videoURL)
                player.replaceCurrentItem(with: newItem)
                player.play()

                NotificationCenter.default.addObserver(
                    forName: .AVPlayerItemDidPlayToEndTime,
                    object: newItem,
                    queue: .main
                ) { _ in
                    player.seek(to: .zero)
                    player.play()
                }
            } else {
                print("Video file not found: \(videoName)")
            }
        }

        playerLayer.frame = uiView.bounds
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject {
        var player: AVPlayer?
        var playerLayer: AVPlayerLayer?
        var currentVideoName: String?
    }
}

struct VideoBackgroundContainer: View {
    @State private var videoName: String = ""
    private let videoType = "mp4"
    let weatherCode: Int
    let timeZoneOffset: Double

    private func isDaytime() -> Bool {
        let utcTime = Date()
        let offsetInSeconds = Int(timeZoneOffset * 3600)

        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!

        guard let locationTime = calendar.date(byAdding: .second, value: offsetInSeconds, to: utcTime) else {
            print("Invalid time zone offset")
            return false
        }

        let currentHour = calendar.component(.hour, from: locationTime)
        return currentHour >= 6 && currentHour < 18
    }

    private func getVideoName() {
        let isDay = isDaytime()

        switch weatherCode {
        case 200...232:
            videoName = "thunder"
        case 300...321:
            videoName = "raining-day"
        case 500...504:
            videoName = isDay ? "raining-day" : "raining-night"
        case 520...531:
            videoName = isDay ? "raining-day" : "raining-night"
        case 600...622:
            videoName = isDay ? "snow-day" : "snow-night"
        case 701...781:
            videoName = isDay ? "cloud-day-4" : "cloud-night-2"
        case 800:
            videoName = isDay ? "clear-day" : "clear-night"
        case 801:
            videoName = isDay ? "cloud-day-1" : "cloud-night-1"
        case 802:
            videoName = isDay ? "cloud-day-2" : "cloud-night-1"
        case 803:
            videoName = isDay ? "cloud-day-3" : "cloud-night-2"
        case 804:
            videoName = isDay ? "cloud-day-4" : "cloud-night-2"
        default:
            videoName = isDay ? "clear-day" : "clear-night"
        }
    }

    var body: some View {
        BackgroundVideoView(videoName: $videoName, videoType: videoType)
            .ignoresSafeArea()
            .onAppear {
                getVideoName()
            }
            .onChange(of: weatherCode) {
                getVideoName()
            }
            .onChange(of: timeZoneOffset) {
                getVideoName()
            }
    }
}

#Preview {
    VideoBackgroundContainer(weatherCode: 803, timeZoneOffset: 5.5)
}

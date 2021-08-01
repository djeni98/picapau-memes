//
//  SFXPlayer.swift
//  Picapau Memes
//
//  Created by Djenifer Renata Pereira on 01/08/21.
//

import Foundation
import AVFoundation

class SFXPlayer {
    static let shared = SFXPlayer()
    var player: AVAudioPlayer?

    fileprivate init() {}

    func playMusic(name: String, extention: String) {
        player?.stop()

        guard let url = Bundle.main.url(forResource: name, withExtension: extention) else {
            print("No url")
            return
        }

        // now use declared path 'url' to initialize the player
        player = try! AVAudioPlayer (contentsOf: url)
        // after initialization play audio its just like click on play button
        player?.play()
    }

    func stopMusic() {
        player?.stop()
    }

    func playMusic(music: Music?) {
        guard let music = music else { return }
        playMusic(name: music.name, extention: music.type)
    }

}

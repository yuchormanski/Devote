//
//  SoundPalyer.swift
//  Devote
//
//  Created by Nikolay  Yuchormanski on 4.05.24.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String)  {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Can notfound the selected sound file in the bundle")
        }
    }
}

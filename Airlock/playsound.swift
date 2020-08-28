//
//  playsound.swift
//  Airlock
//
//  Created by Laurent B on 28/08/2020.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String) {
    audioPlayer?.volume = 5
    let path = Bundle.main.path(forResource: sound, ofType: nil)!
    let url = URL(fileURLWithPath: path)

    do {
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer?.play()
    } catch {
        print("couldn't load file :(")
    }
}
func stopSound() {
    audioPlayer?.stop()
}

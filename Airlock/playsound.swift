//
//  playsound.swift
//  Airlock
//
//  Created by Laurent B on 28/08/2020.
//

import AVFoundation


var audioPlayer: AVAudioPlayer?
    
func playSound(sound: String) {
    audioPlayer?.volume = 0.0
        //settings.volume
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

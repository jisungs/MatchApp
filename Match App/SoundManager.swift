//
//  SoundManager.swift
//  Match App
//
//  Created by The book on 2018. 8. 18..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation
import AVFoundation

class SoundManager {
    static var audioPlayer:AVAudioPlayer?
    
    enum SoundEffect {
        case flip
        case shuffle
        case match
        case nomatch
    }
    
    static func playSound(_ effect:SoundEffect) {
        
        var soundFilename = ""
        
        
        //Determin which sound effect we want to play
        // And set the aproch sound file
        switch effect {
        
        case .flip:
            soundFilename = "cardflip"
            
        case .shuffle:
            soundFilename = "shuffle"
            
        case .match:
            soundFilename = "dingcorrect"
            
        case .nomatch:
            soundFilename = "dingwrong"

        }
        //get the path to the sound file inside the bundle
       let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        
        guard bundlePath != nil else {
            print("Couldn't find file \(soundFilename) in the bundle")
            return
        }
        
        //Create a URL object from this string path
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        do {
        //Create audio player object
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            
            //Play sound
            audioPlayer?.play()
        } catch {
            // Couldn't create audio playter object, log the error
            print("Couldn't create the audio player object for sound file \(soundFilename)")
        }
    }
}

//
//  BackgroundMusicManager.swift
//  Choices
//
//  Created by Afonso Lucas on 11/04/23.
//

import Foundation
import AVFoundation

class BackgroundMusicManager: NSObject, AVAudioPlayerDelegate {
    
    static public var shared = BackgroundMusicManager()
    
    private var player: AVAudioPlayer?
    private var isPlaying: Bool = false
    
    private override init() {
        super.init()
    }
    
    public func playSadMusic() {
        guard !isPlaying else { return }
        
        let musicPath = Bundle.main.url(forResource: "gymnopedie", withExtension: "mp3")!
        
        do {
            self.player = try AVAudioPlayer(contentsOf: musicPath, fileTypeHint: AVFileType.wav.rawValue)
            self.player?.delegate = self
//            self.player?.numberOfLoops = -1
            self.player?.volume = 1
            self.player?.prepareToPlay()
            self.player?.play()
            self.player?.setVolume(1, fadeDuration: 2)
            self.isPlaying = true
        } catch {
            print(error)
        }
    }
    
    public func playHappyMusic() {
        guard !isPlaying else { return }
        
        let musicPath = Bundle.main.url(forResource: "joao_maria", withExtension: "mp3")!
        
        do {
            self.player = try AVAudioPlayer(contentsOf: musicPath, fileTypeHint: AVFileType.mp3.rawValue)
            self.player?.delegate = self
//            self.player?.numberOfLoops = -1
            self.player?.volume = 0
            self.player?.prepareToPlay()
            self.player?.play()
            self.player?.setVolume(1, fadeDuration: 2)
            self.isPlaying = true
        } catch {
            print(error)
        }
    }
    
    public func playMenuMusic() {
        guard !isPlaying else { return }
        
        let musicPath = Bundle.main.url(forResource: "menu_background", withExtension: "mp3")!
        
        do {
            self.player = try AVAudioPlayer(contentsOf: musicPath, fileTypeHint: AVFileType.mp3.rawValue)
            self.player?.delegate = self
            self.player?.numberOfLoops = -1
            self.player?.volume = 0
            self.player?.prepareToPlay()
            self.player?.play()
            self.player?.setVolume(0.8, fadeDuration: 2)
            self.isPlaying = true
        } catch {
            print(error)
        }
    }
    
    public func stopMusic() {
        guard player != nil, isPlaying else { return }
        self.isPlaying = false
        self.player?.setVolume(0, fadeDuration: TimeInterval(1))
        self.player?.stop()
        self.player = nil
    }
}

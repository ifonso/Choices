//
//  ParkScene.swift
//  Choices
//
//  Created by Afonso Lucas on 10/04/23.
//

import Foundation
import SpriteKit

class ParkScene: SKScene {
    
    lazy var mainBackground: SKSpriteNode = {
        let image = SKSpriteNode(imageNamed: "park_base")
        image.zPosition = 1
        image.position = .center
        image.size = size
        return image
    }()
    
    // MARK: - First option scenarios
    lazy var firstSoloBackground: SKSpriteNode = {
        let image = SKSpriteNode(imageNamed: "park_inspiration")
        image.zPosition = 1
        image.position = .center
        image.size = size
        return image
    }()
    
    lazy var secondSoloBackground: SKSpriteNode = {
        let image = SKSpriteNode(imageNamed: "park_hope")
        image.zPosition = 1
        image.position = .center
        image.size = size
        return image
    }()
    
    // MARK: - Second option scenarios
    lazy var firstSheBackground: SKSpriteNode = {
        let image = SKSpriteNode(imageNamed: "park_she")
        image.zPosition = 1
        image.position = .center
        image.size = size
        return image
    }()
    
    lazy var secondSheBackground: SKSpriteNode = {
        let image = SKSpriteNode(imageNamed: "park_ending")
        image.zPosition = 1
        image.position = .center
        image.size = size
        return image
    }()
    
    // MARK: - General
    lazy var grainOverlay: SKSpriteNode = {
        let grain = SKSpriteNode()
        let grainTextures = [
            SKTexture(imageNamed: "grain-1"),
            SKTexture(imageNamed: "grain-2"),
            SKTexture(imageNamed: "grain-3"),
            SKTexture(imageNamed: "grain-4")
        ]
        
        grain.zPosition = 100
        grain.alpha = 0.3
        grain.size = size
        grain.position = .center
        grain.run(.repeatForever(.animate(with: grainTextures, timePerFrame: 0.6)))
        return grain
    }()
    
    lazy var blackOverlay: SKSpriteNode = {
        let overlay = SKSpriteNode(color: .black, size: size)
        overlay.zPosition = 201
        overlay.position = .center
        return overlay
    }()
    
    lazy var waitButton: SKSpriteNode = {
        let button = ButtonNode(
            defaultTexture: "button",
            size: CGSize(width: 160, height: 40),
            action: thinkAct
        )
        
        let label = SKLabelNode(
            attributedText: NSAttributedString(
                string: "Relax for a moment",
                attributes: [.font: UIFont.systemFont(ofSize: 10, weight: .regular),
                             .foregroundColor: UIColor.black
                ])
        )
        label.position = CGPoint(x: 0, y: -5)
        button.position = CGPoint(x: 10 + button.size.width, y: button.size.height + 10)
        button.addChild(label)
        return button
    }()
    
    lazy var playButton: SKSpriteNode = {
        let button = ButtonNode(
            defaultTexture: "button",
            size: CGSize(width: 160, height: 40),
            action: playAct
        )
        let label = SKLabelNode(
            attributedText: NSAttributedString(
                string: "Try to play",
                attributes: [.font: UIFont.systemFont(ofSize: 10, weight: .regular),
                             .foregroundColor: UIColor.black
                ])
        )
        label.position = CGPoint(x: 0, y: -5)
        button.position = CGPoint(x: size.width - (10 + button.size.width), y: button.size.height + 10)
        button.addChild(label)
        return button
    }()
    
    // MARK: - Audio
    lazy var dayAmbienceAudio: SKAudioNode = {
        var audio = SKAudioNode(fileNamed: "park_background.mp3")
        audio.autoplayLooped = true
        
        return audio
    }()
    
    lazy var ambienceAudio: SKAudioNode = {
        var audio = SKAudioNode(fileNamed: "park_background.mp3")
        audio.autoplayLooped = true
        
        return audio
    }()
    
    lazy var ambiencePlayingAudio: SKAudioNode = {
        var audio = SKAudioNode(fileNamed: "playing_background.mp3")
        audio.autoplayLooped = true
        
        return audio
    }()
    
    lazy var thinkChord: SKAudioNode = {
        var audio = SKAudioNode(fileNamed: "think_chord.wav")
        audio.autoplayLooped = false
        audio.alpha = 0.5
        
        return audio
    }()
    
    lazy var playChord: SKAudioNode = {
        var audio = SKAudioNode(fileNamed: "play_chord.wav")
        audio.autoplayLooped = false
        audio.alpha = 0.5
        
        return audio
    }()
    
    var isFirstEnd: Bool? = nil
    
    override func sceneDidLoad() {
        self.addChild(mainBackground)
        self.addChild(grainOverlay)
        self.addChild(waitButton)
        self.addChild(playButton)
    }
    
    override func didMove(to view: SKView) {
        self.preAct()
        self.setupBackgroundAudio()
    }
    
    override func willMove(from view: SKView) {
        let removeBackgroundAudio = SKAction.run { [weak self] in
            guard let self = self else { return }
            self.dayAmbienceAudio.run(.fadeAlpha(to: 0, duration: 1))
        }
        
        self.run(removeBackgroundAudio)
    }
    
    private func setupBackgroundAudio() {
        self.ambienceAudio.alpha = 0
        ambiencePlayingAudio.alpha = 0
        self.addChild(ambienceAudio)
        self.addChild(ambiencePlayingAudio)
        self.ambiencePlayingAudio.run(.fadeIn(withDuration: 2))
        self.ambienceAudio.run(.fadeIn(withDuration: 2))
    }
    
    private func preAct() {
        let presentButtons = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.playButton.alpha = 0
            self.waitButton.alpha = 0
            self.playButton.run(.fadeIn(withDuration: 1))
            self.waitButton.run(.fadeIn(withDuration: 1))
        }
        
        let waitPresent = SKAction.wait(forDuration: 1)
        
        self.run(.sequence([presentButtons, waitPresent]))
    }
    
    private func thinkAct() {
        guard isFirstEnd == nil else { return }
        
        isFirstEnd = true
        
        let playChord = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.ambiencePlayingAudio.run(.changeVolume(to: 0, duration: 0.2))
            
            self.addChild(thinkChord)
            self.thinkChord.run(.changeVolume(to: 0.3, duration: 0.1))
            self.thinkChord.run(.play())
        }
        
        let waitPlayChord = SKAction.wait(forDuration: 1)
        
        let addOverlay = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.blackOverlay.alpha = 0
            self.addChild(self.blackOverlay)
            self.blackOverlay.run(.fadeIn(withDuration: 2))
        }
        
        let waitOverlay = SKAction.wait(forDuration: 2.0)
        
        let removeButtons = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.waitButton.removeFromParent()
            self.playButton.removeFromParent()
        }
        
        let removeOverlay = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.blackOverlay.alpha = 1
            self.blackOverlay.run(.fadeOut(withDuration: 1)) {
                self.blackOverlay.removeFromParent()
            }
        }
        
        let changeToSecondScene = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.mainBackground.removeFromParent()
            self.ambienceAudio.run(.changeVolume(to: 0.3, duration: 1))
            self.addChild(self.firstSoloBackground)
        }
        
        let fadeOutPlaying = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.ambiencePlayingAudio.run(.changeVolume(to: 0, duration: 1)) {
                self.ambiencePlayingAudio.removeFromParent()
            }
        }
        
        let waitFadeOutSound = SKAction.wait(forDuration: 1)
        
        let waitInSecond = SKAction.wait(forDuration: 2)
        
        let breath = SKAction.playSoundFileNamed("breath.mp3", waitForCompletion: true)
        
        let changeToThirdScene = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.firstSoloBackground.removeFromParent()
            self.addChild(self.secondSoloBackground)
        }
        
        let moveThirdScene = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.secondSoloBackground.run(.moveBy(x: -60, y: 0, duration: 15))
            self.secondSoloBackground.run(.scale(to: 1.4, duration: 15))
        }
        
        let waitFinalScene = SKAction.wait(forDuration: 8)
        
        let fadeOutBackground = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.ambienceAudio.run(.changeVolume(to: 0, duration: 2)) {
                self.ambienceAudio.removeFromParent()
            }
        }
        
        let waitFadeOutBackground = SKAction.wait(forDuration: 8)
        
        let playMusic = SKAction.run {
            BackgroundMusicManager.shared.playSadMusic()
        }
        
        let waitLazyRemoveOverlay = SKAction.wait(forDuration: 3)
        
        let lazyRemoveOverlay = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.blackOverlay.alpha = 1
            self.blackOverlay.run(.fadeOut(withDuration: 3)) {
                self.blackOverlay.removeFromParent()
            }
        }
        
        self.run(.sequence([
            playChord,
            waitPlayChord,
            
            addOverlay,
            waitOverlay,
            removeButtons,
            
            changeToSecondScene,
            fadeOutPlaying,
            waitFadeOutSound,
            removeOverlay,
            waitOverlay,

            waitInSecond,
            breath,
            
            addOverlay,
            waitOverlay,
            fadeOutBackground,
            playMusic,
            waitFadeOutBackground,
            
            changeToThirdScene,
            lazyRemoveOverlay,
            waitLazyRemoveOverlay,
            moveThirdScene,
            waitFinalScene
        ])) { [weak self] in
            self?.goToEndScene()
        }
    }
    
    private func playAct() {
        guard isFirstEnd == nil else { return }
        
        isFirstEnd = false
        
        let playChord = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.ambiencePlayingAudio.run(.changeVolume(to: 0.2, duration: 0.2))
            
            self.addChild(self.playChord)
            self.playChord.run(.changeVolume(to: 0.3, duration: 0.1))
            self.playChord.run(.play())
        }
        
        let waitPlayChord = SKAction.wait(forDuration: 1)
        
        let addOverlay = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.blackOverlay.alpha = 0
            self.addChild(self.blackOverlay)
            self.blackOverlay.run(.fadeIn(withDuration: 1))
        }
        
        let playBallAudio = SKAction.playSoundFileNamed("ballhit.mp3", waitForCompletion: true)
        
        let stopBackgroundPlay = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.ambiencePlayingAudio.run(.changeVolume(to: 0, duration: 0.2))
        }
        
        let removeButtons = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.waitButton.removeFromParent()
            self.playButton.removeFromParent()
        }
        
        let waitOverlay = SKAction.wait(forDuration: 1.0)
        
        let removeOverlay = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.blackOverlay.alpha = 1
            self.blackOverlay.run(.fadeOut(withDuration: 2)) {
                self.blackOverlay.removeFromParent()
            }
        }
        
        let changeToSecondScene = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.mainBackground.removeFromParent()
            self.addChild(self.firstSheBackground)
        }
        
        let waitInScene = SKAction.wait(forDuration: 4)
        
        let changeToThirdScene = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.firstSheBackground.removeFromParent()
            self.addChild(self.secondSheBackground)
            BackgroundMusicManager.shared.playHappyMusic()
        }
        
        let waitMusicInOverlay = SKAction.wait(forDuration: 4)
        
        let moveThirdScene = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.secondSheBackground.run(.moveBy(x: -60, y: 0, duration: 14))
            self.secondSheBackground.run(.scale(to: 1.4, duration: 14))
        }
        
        let waitFinalScene = SKAction.wait(forDuration: 10)
        
        self.run(.sequence([
            playChord,
            waitPlayChord,
            
            addOverlay,
            stopBackgroundPlay,
            waitOverlay,
            playBallAudio,
            removeButtons,
            
            changeToSecondScene,
            removeOverlay,
            waitOverlay,
            waitInScene,
            
            addOverlay,
            waitOverlay,
            changeToThirdScene,
            waitMusicInOverlay,
            removeOverlay,
            waitOverlay,
            moveThirdScene,
            waitFinalScene
        ])) { [weak self] in
            self?.goToEndScene()
        }
    }
    
    private func goToEndScene() {
        if isFirstEnd == true {
            view?.presentScene(TheaterScene(size: .defaultSceneSize), transition: .fade(withDuration: 5))
        } else {
            view?.presentScene(HomeScene(size: .defaultSceneSize), transition: .fade(withDuration: 5))
        }
    }
}

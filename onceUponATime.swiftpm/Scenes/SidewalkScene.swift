//
//  SidewalkScene.swift
//  onceUponATime
//
//  Created by Afonso Lucas on 08/04/23.
//

import Foundation
import SpriteKit

class SidewalkScene: SKScene {
    
    lazy var background: SKSpriteNode = {
       let image = SKSpriteNode(imageNamed: "sidewalk_background")
        image.zPosition = 1
        image.position = .center
        image.size = size
        return image
    }()
    
    lazy var paperBackground: SKSpriteNode = {
        let image = SKSpriteNode(imageNamed: "guitar_classes_paper")
         image.zPosition = 1
         image.position = .center
         image.size = size
         return image
    }()
    
    lazy var paper: SKSpriteNode = {
        let image = SKSpriteNode(imageNamed: "paper_sidewalk")
        image.zPosition = 2
        image.position = .center
        image.size = size
        return image
    }()
    
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
    
    lazy var subjectNode: SKSpriteNode = {
        let subject = SKSpriteNode(imageNamed: "he_sidewalk")
        subject.zPosition = 2
        subject.size = size
        subject.position = .center
        return subject
    }()
    
    // MARK: - Buttons
    lazy var catchButton: SKSpriteNode = {
        let button = ButtonNode(
            defaultTexture: "button",
            size: CGSize(width: 100, height: 40),
            action: catchAct
        )
        
        let label = SKLabelNode(
            attributedText: NSAttributedString(
                string: "catch",
                attributes: [.font: UIFont.systemFont(ofSize: 12, weight: .regular),
                             .foregroundColor: UIColor.black
                            ])
        )
        label.position = CGPoint(x: 0, y: -5)
        button.position = CGPoint(x: size.width/2, y: button.size.height + 10)
        button.addChild(label)
        return button
    }()
    
    // MARK: - Audio
    lazy var ambienceAudio: SKAudioNode = {
        var audio = SKAudioNode(fileNamed: "sidewalk_background.mp3")
        audio.autoplayLooped = true
        
        return audio
    }()
    
    lazy var firstChord: SKAudioNode = {
        var audio = SKAudioNode(fileNamed: "initial_chord.wav")
        audio.autoplayLooped = false
        audio.alpha = 0.5
        
        return audio
    }()
    
    var taken: Bool? = nil
    
    override func sceneDidLoad() {
        self.addChild(background)
        self.addChild(paper)
        self.addChild(grainOverlay)
    }
    
    override func didMove(to view: SKView) {
        preAct()
        setupBackgroundAudio()
    }
    
    override func willMove(from view: SKView) {
        let removeBackgroundAudio = SKAction.run { [weak self] in
            guard let self = self else { return }
            self.ambienceAudio.run(.fadeAlpha(to: 0, duration: 2))
        }
        
        self.run(removeBackgroundAudio)
    }
    
    private func setupBackgroundAudio() {
        let addBackgroundAudio = SKAction.run { [weak self] in
            guard let self = self else { return }
            self.addChild(self.ambienceAudio)
            self.ambienceAudio.alpha = 0
            self.ambienceAudio.run(.play())
            self.ambienceAudio.run(.fadeAlpha(to: 1, duration: 2))
        }
        
        self.run(addBackgroundAudio)
    }
    
    private func preAct() {
        let wait = SKAction.wait(forDuration: 4.0)
        let addOverlay = SKAction.run { [weak self] in
            guard let self = self else { return }
            self.blackOverlay.alpha = 0
            self.addChild(self.blackOverlay)
            self.blackOverlay.run(.fadeIn(withDuration: 2))
        }
        
        let waitOverlay = SKAction.wait(forDuration: 2.0)
        
        let playStepsComing = SKAction.playSoundFileNamed("steps_coming.mp3", waitForCompletion: true)
        
        let addNewElement = SKAction.run { [weak self] in
            guard let self = self else { return }
            self.addChild(self.subjectNode)
        }
        
        let removeOverlay = SKAction.run { [weak self] in
            guard let self = self else { return }
            self.blackOverlay.alpha = 1
            self.blackOverlay.run(.fadeOut(withDuration: 1)) {
                self.blackOverlay.removeFromParent()
            }
        }
        
        let sequence = SKAction.sequence([
            wait,
            addOverlay,
            waitOverlay,
            addNewElement,
            playStepsComing,
            removeOverlay
        ])
        
        self.run(sequence) { [weak self] in
            guard let self = self else { return }
            
            self.addChild(self.catchButton)
        }
    }
    
    private func catchAct() {
        guard taken == nil else { return }
        self.taken = true
        
        let playChord = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.addChild(firstChord)
            self.firstChord.run(.changeVolume(to: 0.3, duration: 0.1))
            self.firstChord.run(.play())
        }
        
        let waitPlayChord = SKAction.wait(forDuration: 1)
        
        let addOverlay = SKAction.run { [weak self] in
            guard let self = self else { return }
            self.blackOverlay.alpha = 0
            self.addChild(self.blackOverlay)
            self.blackOverlay.run(.fadeIn(withDuration: 2))
        }
        
        let waitOverlay = SKAction.wait(forDuration: 2.0)
        
        let playPaper = SKAction.playSoundFileNamed("paper.mp3", waitForCompletion: true)
        
        let removeOverlay = SKAction.run { [weak self] in
            guard let self = self else { return }
            self.blackOverlay.alpha = 1
            self.blackOverlay.run(.fadeOut(withDuration: 2)) {
                self.blackOverlay.removeFromParent()
            }
        }
        
        let removeElements = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.background.removeFromParent()
            self.catchButton.removeFromParent()
            self.paper.removeFromParent()
            self.subjectNode.removeFromParent()
        }
        
        let addNewBackground = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.addChild(paperBackground)
        }
        
        let waitInScene = SKAction.wait(forDuration: 3)
        
        self.run(.sequence([
            playChord,
            waitPlayChord,
            
            addOverlay,
            waitOverlay,
            playPaper,
            removeElements,
            addNewBackground,
            removeOverlay,
            waitOverlay,
            waitInScene
        ])) { [weak self] in
            guard let self = self else { return }
            cleanScene(withPaper: false)
        }
    }
    
    private func cleanScene(withPaper: Bool) {
        let addOverlay = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.blackOverlay.alpha = 0
            self.addChild(self.blackOverlay)
            self.blackOverlay.run(.fadeIn(withDuration: 2))
        }
        
        let playStepsGoing = SKAction.playSoundFileNamed("steps_going.mp3", waitForCompletion: true)
        
        let waitOverlay = SKAction.wait(forDuration: 2.0)
        let waitInScene = SKAction.wait(forDuration: 3.0)
        
        let removeOverlay = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.blackOverlay.alpha = 1
            self.blackOverlay.run(.fadeOut(withDuration: 2)) {
                self.blackOverlay.removeFromParent()
            }
        }
        
        let manageElements = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.paperBackground.removeFromParent()
            self.addChild(background)
            
            if withPaper {
                self.addChild(paper)
            }
        }
        
        self.run(.sequence([
            addOverlay,
            waitOverlay,
            playStepsGoing,
            manageElements,
            removeOverlay,
            waitOverlay,
            waitInScene
        ])) { [weak self] in
            self?.nextScene()
        }
    }
    
    private func nextScene() {
        let label = SKSpriteNode()
        let texture = SKTexture(imageNamed: "then_a_day")
        label.texture = texture
        label.size = size
        
        if taken == true {
            view?.presentScene(
                TransitionScene(size: .defaultSceneSize,
                                label: label,
                                next: ParkScene(size: .defaultSceneSize)),
                transition: .fade(withDuration: 4))
        } else {
//            view?.presentScene(
//                TransitionScene(size: .defaultSceneSize,
//                                label: label,
//                                next: MainSceneController(size: .defaultSceneSize)),
//                transition: .fade(withDuration: 2))
        }
    }
}

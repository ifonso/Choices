//
//  FinalScenes.swift
//  Choices
//
//  Created by Afonso Lucas on 10/04/23.
//

import Foundation
import SpriteKit

class TheaterScene: SKScene {
    
    lazy var mainBackground: SKSpriteNode = {
        let image = SKSpriteNode(imageNamed: "show_solo")
        image.zPosition = 1
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
        grain.run(.repeatForever(.animate(with: grainTextures, timePerFrame: 1)))
        return grain
    }()
    
    lazy var choicesLabel: SKSpriteNode = {
        let label = SKSpriteNode()
        let labelTextures = [
            SKTexture(imageNamed: "choices_1"),
            SKTexture(imageNamed: "choices_2"),
            SKTexture(imageNamed: "choices_3"),
            SKTexture(imageNamed: "choices_4")
        ]
        
        label.zPosition = 99
        label.alpha = 1
        label.size = CGSize(width: 180, height: 40)
        label.position = CGPoint(x: size.width/2, y: size.height - 60)
        label.run(.repeatForever(.animate(with: labelTextures, timePerFrame: 1)))
        return label
    }()
    
    lazy var choicesText: SKSpriteNode = {
       let image = SKSpriteNode(imageNamed: "end_text")
        image.zPosition = 100
        image.position = CGPoint(x: size.width/2, y: 80)
        image.size = CGSize(width: 160, height: 30)
        return image
    }()
    
    lazy var againButton: SKSpriteNode = {
        let button = ButtonNode(
            defaultTexture: "button",
            size: CGSize(width: 100, height: 30),
            action: againAction
        )
        
        let label = SKLabelNode(
            attributedText: NSAttributedString(
                string: "Again",
                attributes: [.font: UIFont.systemFont(ofSize: 10, weight: .regular),
                             .foregroundColor: UIColor.black
                            ])
        )
        label.position = CGPoint(x: 0, y: -5)
        button.position = CGPoint(x: size.width/2, y: button.size.height + 10)
        button.addChild(label)
        return button
    }()

    override func sceneDidLoad() {
        self.addChild(mainBackground)
        self.addChild(grainOverlay)
        
        mainBackground.setScale(1.8)
    }
    
    override func didMove(to view: SKView) {
        endAct()
    }
    
    private func endAct() {
        let scaleNormal = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.mainBackground.run(.scale(to: 1, duration: 10)) {
                self.run(.wait(forDuration: 1)) {
                    self.addChild(self.choicesLabel)
                    self.run(.wait(forDuration: 0.5)) {
                        self.addChild(self.choicesText)
                        self.run(.wait(forDuration: 2)) {
                            self.againButton.alpha = 0
                            self.addChild(self.againButton)
                            self.againButton.run(.fadeIn(withDuration: 2))
                        }
                    }
                }
            }
        }
        
        self.run(.sequence([scaleNormal]))
    }
    
    private func againAction() {
        BackgroundMusicManager.shared.stopMusic()
        self.view?.presentScene(SceneController.shared.mainMenu, transition: .fade(withDuration: 1))
    }
}


class HomeScene: SKScene {
    
    lazy var mainBackground: SKSpriteNode = {
        let image = SKSpriteNode(imageNamed: "family_band")
        image.zPosition = 1
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
        grain.run(.repeatForever(.animate(with: grainTextures, timePerFrame: 1)))
        return grain
    }()
    
    lazy var choicesLabel: SKSpriteNode = {
        let label = SKSpriteNode()
        let labelTextures = [
            SKTexture(imageNamed: "choices_1"),
            SKTexture(imageNamed: "choices_2"),
            SKTexture(imageNamed: "choices_3"),
            SKTexture(imageNamed: "choices_4")
        ]
        
        label.zPosition = 99
        label.alpha = 1
        label.size = CGSize(width: 180, height: 40)
        label.position = CGPoint(x: size.width/2, y: size.height - 60)
        label.run(.repeatForever(.animate(with: labelTextures, timePerFrame: 1)))
        return label
    }()
    
    lazy var choicesText: SKSpriteNode = {
       let image = SKSpriteNode(imageNamed: "end_text")
        image.zPosition = 100
        image.position = CGPoint(x: size.width/2, y: 80)
        image.size = CGSize(width: 160, height: 30)
        return image
    }()
    
    lazy var againButton: SKSpriteNode = {
        let button = ButtonNode(
            defaultTexture: "button",
            size: CGSize(width: 100, height: 30),
            action: againAction
        )
        
        let label = SKLabelNode(
            attributedText: NSAttributedString(
                string: "Again",
                attributes: [.font: UIFont.systemFont(ofSize: 10, weight: .regular),
                             .foregroundColor: UIColor.black
                            ])
        )
        label.position = CGPoint(x: 0, y: -5)
        button.position = CGPoint(x: size.width/2, y: button.size.height + 10)
        button.addChild(label)
        return button
    }()
    
    override func sceneDidLoad() {
        self.addChild(mainBackground)
        self.addChild(grainOverlay)
        
        mainBackground.setScale(1.8)
    }
    
    override func didMove(to view: SKView) {
        endAct()
    }
    
    private func endAct() {
        let scaleNormal = SKAction.run { [weak self] in
            guard let self = self else { return }
            
            self.mainBackground.run(.scale(to: 1, duration: 10)) {
                self.run(.wait(forDuration: 1)) {
                    self.addChild(self.choicesLabel)
                    self.run(.wait(forDuration: 0.5)) {
                        self.addChild(self.choicesText)
                        self.run(.wait(forDuration: 2)) {
                            self.againButton.alpha = 0
                            self.addChild(self.againButton)
                            self.againButton.run(.fadeIn(withDuration: 2))
                        }
                    }
                }
            }
        }
        
        self.run(.sequence([scaleNormal]))
    }
    
    private func againAction() {
        BackgroundMusicManager.shared.stopMusic()
        self.view?.presentScene(SceneController.shared.mainMenu, transition: .fade(withDuration: 1))
    }
}

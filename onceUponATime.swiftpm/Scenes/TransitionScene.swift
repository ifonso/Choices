//
//  TransitionScene.swift
//  onceUponATime
//
//  Created by Afonso Lucas on 08/04/23.
//

import Foundation
import SpriteKit

class TransitionScene: SKScene {
    
    var label: SKSpriteNode
    var nextScene: SKScene
    var music: String? = nil
    
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
    
    init(size: CGSize, label: SKSpriteNode, music: String? = nil, next: SKScene) {
        self.label = label
        self.nextScene = next
        if let musicName = music {
            self.music = musicName
        }
        super.init(size: size)
    }
    
    override func sceneDidLoad() {
        label.zPosition = 3
        label.position = .center
        
        self.backgroundColor = .black
        self.addChild(grainOverlay)
        self.addChild(label)
    }
    
    override func didMove(to view: SKView) {
        if let music = music {
            self.run(.playSoundFileNamed(music, waitForCompletion: false))
        }
        
        self.run(.wait(forDuration: 2)) { [weak self] in
            guard let self = self else { return }
            
            self.view?.presentScene(self.nextScene, transition: .fade(withDuration: 1))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

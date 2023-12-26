//
//  MainSceneController.swift
//  onceUponATime
//
//  Created by Afonso Lucas on 07/04/23.
//

import Foundation
import SpriteKit

class SceneController {
    
    public static var shared = SceneController()
    
    public let mainMenu = MainSceneController(size: .defaultSceneSize)
    public var currentScene: SKScene
    
    private init() {
        self.currentScene = mainMenu
    }
}

class MainSceneController: SKScene {
    
    lazy var background: SKSpriteNode = {
       let image = SKSpriteNode(imageNamed: "menu_screen")
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
        grain.alpha = 0.2
        grain.size = size
        grain.position = .center
        grain.run(.repeatForever(.animate(with: grainTextures, timePerFrame: 0.6)))
        return grain
    }()
    
    lazy var startButton = {
        let startButton = ButtonNode(
            defaultTexture: "start",
            size: CGSize(width: 120, height: 120)
        ) { [weak self] in
            self?.start()
        }
        startButton.position = .center
        return startButton
    }()
    
    override func sceneDidLoad() {
        self.addChild(background)
        self.addChild(grainOverlay)
        self.addChild(startButton)
        
        BackgroundMusicManager.shared.playMenuMusic()
    }
    
    override func didMove(to view: SKView) {
        BackgroundMusicManager.shared.playMenuMusic()
    }
    
    override func willMove(from view: SKView) {
        BackgroundMusicManager.shared.stopMusic()
    }
    
    private func start() {
        let label = SKSpriteNode()
        let texture = SKTexture(imageNamed: "once_upon")
        label.texture = texture
        label.size = size
        
        view?.presentScene(
            TransitionScene(size: .defaultSceneSize,
                            label: label,
                            next: SidewalkScene(size: .defaultSceneSize)),
            transition: .fade(withDuration: 2))
    }

}

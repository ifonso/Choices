//
//  ButtonNode.swift
//  onceUponATime
//
//  Created by Afonso Lucas on 07/04/23.
//

import Foundation
import SpriteKit

class ButtonNode: SKSpriteNode {
    
    let defaultTexture: SKTexture
    let action: () -> Void
    
    init(defaultTexture: String, size: CGSize, action: @escaping () -> Void) {
        self.defaultTexture = SKTexture(imageNamed: defaultTexture)
        self.action = action
        
        super.init(texture: self.defaultTexture, color: .clear, size: size)
        
        zPosition = 200
        isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.run(.fadeAlpha(to: 0.7, duration: 0.1))
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.run(.fadeAlpha(to: 1, duration: 0.1))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.run(.fadeAlpha(to: 1, duration: 0.1))
        action()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

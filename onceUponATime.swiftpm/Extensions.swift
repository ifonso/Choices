//
//  Extensions.swift
//  onceUponATime
//
//  Created by Afonso Lucas on 07/04/23.
//

import Foundation
import SwiftUI

extension CGSize {
    static let defaultSceneSize: CGSize = CGSize(width: 480, height: 360)
}

extension CGPoint {
    static let center: CGPoint = CGPoint(x: 240, y: 180)
}

extension View {
    func topLeading() -> some View {
        return VStack {
            HStack {
                self
                Spacer()
            }
            Spacer()
        }
    }
}

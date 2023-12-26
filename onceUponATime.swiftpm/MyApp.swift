import SwiftUI
import SpriteKit

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            MainView().preferredColorScheme(.dark)
        }
    }
}

struct MainView: View {
    
    let controller = SceneController.shared
    
    @State var alredyShowWarning  = false
    
    var body: some View {
        ZStack {
            SpriteView(scene: controller.currentScene)
            
            if !alredyShowWarning {
                Overlay().onTapGesture(perform: dismissOverlay)
            }
        }
        .ignoresSafeArea(.all)
        .statusBar(hidden: true)
    }
    
    func dismissOverlay() {
        withAnimation(.easeIn(duration: 1)) {
            alredyShowWarning = true
        }
    }
}

struct Overlay: View {
    var body: some View {
        ZStack {
            Image(systemName: "xmark")
                .resizable()
                .scaledToFit()
                .frame(height: 16)
                .topLeading()
            
            VStack(spacing: 16) {
                Spacer()
                Image(systemName: "airpods.gen3")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 32)
                
                Text("For a better experience, use headphones")
                    .multilineTextAlignment(.center)
                    .font(.body)
                Spacer()
            }
        }
        .padding(32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.thinMaterial)
    }
}

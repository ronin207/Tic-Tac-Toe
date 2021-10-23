//
//  GameView.swift
//  Tic-Tac-Toe
//
//  Created by Takumi Otsuka on 22/10/21.
//

import SwiftUI

struct GameView: View {
    
    @StateObject private var vm = GameViewModel()
    
    var body: some View {
        // Create Game Board UI
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: vm.columns, spacing: 5) {
                    ForEach(0 ..< 9) { i in
                        ZStack {
                            GameSquareView(proxy: geometry)
                            PlayerIndicator(systemImageName: vm.moves[i]?.indicator ?? "")
                        }
                        .onTapGesture {
                            vm.ProcessPlayerMove(for: i)
                        }
                    }
                }
                Spacer()
            }
            .disabled(vm.isGameboardDisabled)
            .padding()
            .alert(item: $vm.alertItem) { alertItem in
                Alert(
                    title: alertItem.title,
                    message: alertItem.message,
                    dismissButton: .default(alertItem.buttonTitle, action: { vm.resetGame() })
                )
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

// Create Move Object
enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

struct GameSquareView: View {
    
    var proxy: GeometryProxy
    
    var body: some View {
        Circle()
            .foregroundColor(.teal)
            .opacity(0.5)
            .frame(
                width: proxy.size.width / 3 - 15,
                height: proxy.size.width / 3 - 15
            )
    }
}

struct PlayerIndicator: View {
    
    var systemImageName: String
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}

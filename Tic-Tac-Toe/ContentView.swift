//
//  ContentView.swift
//  Tic-Tac-Toe
//
//  Created by Takumi Otsuka on 22/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isHumansTurn = true
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        // Create Game Board UI
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: columns, spacing: 5) {
                    ForEach(0 ..< 9) { i in
                        ZStack {
                            Circle()
                                .foregroundColor(.teal)
                                .opacity(0.5)
                                .frame(
                                    width: geometry.size.width / 3 - 15,
                                    height: geometry.size.width / 3 - 15
                                )
                            
                            Image(systemName: moves[i]?.indicator ?? "")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                        .onTapGesture {
                            if isSquareOccupied(in: moves, forIndex: i) { return }
                            moves[i] = Move(player: isHumansTurn ? .human : .computer, boardIndex: i)
                            isHumansTurn.toggle()
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index })
    }
    
    func determineComputerMovePosition(in moves: [Move?]) -> Int {
        var movePosition = Int.random(in: 0 ..< 9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            var movePosition = Int.random(in: 0 ..< 9)
        }
        
        return movePosition
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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

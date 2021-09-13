//
//  ContentView.swift
//  TicTacToe
//
//  Created by David Malicke on 9/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var moves: [String] = Array(repeating: "", count: 9)
    @State var currentUser = false
    
    @State var message = ""
    @State var gameOver = false
    
    var body: some View {
        NavigationView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 15), count: 3), spacing: 15, content: {
                ForEach(0..<9) { index in
                    ZStack {
                        Color.blue
                        Color.white
                            .opacity(moves[index] == "" ? 1 : 0)
                        Text(moves[index])
                            .font(.system(size: 55))
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                    }
                    .frame(width: width, height: width)
                    .cornerRadius(15)
                    .rotation3DEffect(.init(degrees: moves[index] != "" ? 180 : 0),
                                      axis: (x: 0.0, y: 1.0, z: 0),
                                      anchor: .center,
                                      anchorZ: 0.0,
                                      perspective: 1.0)
                    .onTapGesture {
                        withAnimation(Animation.easeIn(duration: 0.3)) {
                            if moves[index] == "" {
                                moves[index] = currentUser ? "x" : "o"
                                self.currentUser.toggle()
                            }
                        }
                        
                    }
                }
            }).padding()
            .preferredColorScheme(.dark)
            .navigationTitle("Tic Tac Toe")
            .onChange(of: moves, perform: { value in
                declareWinner()
            })
            .alert(isPresented: $gameOver, content: {
                Alert(title: Text("Winner"), message: Text(message), dismissButton: .destructive(Text("Play Again"), action: {
                    withAnimation(Animation.easeIn(duration: 0.45)) {
                        moves.removeAll()
                        moves = Array(repeating: "", count: 9)
                        currentUser = false
                    }
                }))
            })
        }
        
    }
    
    var width: CGFloat {
        return (UIScreen.main.bounds.width - 60) / 3
    }
    
    func declareWinner() {
        
        if checkMoves(player: "x") {
            message = "Player X won the game!!"
            self.gameOver.toggle()
        }
        
        else if checkMoves(player: "o") {
            message = "Player o won the game!!"
            self.gameOver.toggle()
        }
        else {
            let status = moves.contains {
                (value) -> Bool in
                return value == ""
            }
            if !status {
                message = " Game is tie"
                gameOver.toggle()
            }
        }
        
    }
    
    func checkMoves(player: String) -> Bool {
        
        // horizontal check
        for i in stride(from: 0, to: 9, by: 3) {
            if moves[i] == player && moves[i + 1] == player && moves[i + 2] == player {
                return true
            }
        }
        // vertical check
        for i in 0...2 {
            if moves[i] == player && moves[i + 3] == player && moves[i + 6] == player {
                return true
            }
        }
        // diagonal checks
        if moves[0] == player && moves[4] == player && moves[8] == player {
            return true
        }
        
        if moves[2] == player && moves[4] == player && moves[6] == player {
            return true
        }
        
        return false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

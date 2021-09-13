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
        }
    }
    
    var width: CGFloat {
        return (UIScreen.main.bounds.width - 60) / 3
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

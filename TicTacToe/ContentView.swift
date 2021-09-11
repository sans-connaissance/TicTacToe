//
//  ContentView.swift
//  TicTacToe
//
//  Created by David Malicke on 9/10/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 15), count: 3), spacing: 15, content: {
                ForEach(0..<9) { index in
                    Color.white
                        .frame(width: width, height: width)
                        .cornerRadius(15)
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

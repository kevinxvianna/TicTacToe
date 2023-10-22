//
//  ContentView.swift
//  TicTacToe
//
//  Created by Kevin Quinalia on 21/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var gameState = GameState()
    
    var body: some View {
        let borderSize = CGFloat(5)
        
        Text(gameState.turnToString())
            .font(.title)
            .bold()
            .padding()
        
        Spacer()
        
        Text(gameState.scoreToString(Tile.Cross))
            .font(.system(size: 25))
            .bold()
            .padding()
        
        VStack(spacing: borderSize) {
            ForEach(0...2, id: \.self) {
                row in
                HStack(spacing: borderSize) {
                    ForEach(0...2, id: \.self) {
                        column in
                        let cell = gameState.board[row][column]
                        Text(cell.displayTile() )
                            .font(.system(size: 50))
                            .foregroundColor(cell.displayColor())
                            .bold()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .aspectRatio(1, contentMode: .fit)
                            .background(Color.white)
                            .onTapGesture {
                                gameState.placeTile(row, column)
                            }
                    }
                }
            }
        }
        .background(Color.black)
        .padding(24)
        .alert(isPresented: $gameState.shouldShowAlert) {
            Alert(title: Text(gameState.alertMessage),
                  dismissButton: .default(Text("Ok")) {
                gameState.resetBoard()
            })
        }
        
        Text(gameState.scoreToString(Tile.Nought))
            .font(.system(size: 25))
            .bold()
            .padding()
        
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  GameState.swift
//  TicTacToe
//
//  Created by Kevin Quinalia on 21/10/23.
//

import Foundation

class GameState: ObservableObject {
    @Published var board = [[Cell]]()
    @Published var turn = Tile.Cross
    @Published var crosses = 0
    @Published var noughts = 0
    @Published var shouldShowAlert = false
    @Published var alertMessage = ""
    
    
    init() {
        resetBoard()
    }
    
    func turnToString() -> String {
        return getGameTurn() == Tile.Cross ? "Turn: X" : "Turn: O"
    }
    
    func scoreToString(_ tile: Tile) -> String {
        if(tile == Tile.Cross) {
            return "Crosses: " + String(crosses)
        } else {
            return "Noughts: " + String(noughts)
        }
    }
    
    func placeTile(_ row: Int,_ column: Int) {
        if(board[row][column].tile != Tile.Empty) {
            return
        }
        
        let actualTurn = getGameTurn();
        
        board[row][column].tile = actualTurn;
        
        
        if(checkForVictory()) {
            if (actualTurn == Tile.Cross) {
                crosses += 1
            }
            
            if(actualTurn == Tile.Nought) {
                noughts += 1
            }
            
            let winner = turn == Tile.Cross ? "Crosses" : "Noughts"
            alertMessage = winner + " win!"
            shouldShowAlert = true
        }
        
        if(checkForDraw()) {
            alertMessage = "Draw!"
            shouldShowAlert = true
        }
        
        nextTurn()
    }
    
    func getGameTurn() -> Tile {
        let isCrossTurn = turn == Tile.Cross
        
        return isCrossTurn ? Tile.Cross : Tile.Nought
    }
    
    func nextTurn() {
        if(turn == Tile.Cross) {
            turn = Tile.Nought
        } else {
            turn = Tile.Cross
        }
    }

    func checkForVictory() -> Bool {
        
        //vertical
        if isTurnTile(0, 0) && isTurnTile(1, 0) && isTurnTile(2, 0) {
            return true
        }
        
        if isTurnTile(0, 1) && isTurnTile(1, 1) && isTurnTile(2, 1) {
            return true
        }
        
        if isTurnTile(0, 2) && isTurnTile(1,2) && isTurnTile(2, 2) {
            return true
        }
        
        //horizontal
        if isTurnTile(0, 0) && isTurnTile(0, 1) && isTurnTile(0, 2) {
            return true
        }
        
        if isTurnTile(1, 0) && isTurnTile(1, 1) && isTurnTile(1, 2) {
            return true
        }
        
        if isTurnTile(2, 0) && isTurnTile(2, 1) && isTurnTile(2, 2) {
            return true
        }
        
        //diagonal
        if isTurnTile(0, 0) && isTurnTile(1, 1) && isTurnTile(2, 2) {
            return true
        }
        
        if isTurnTile(0, 2) && isTurnTile(1, 1) && isTurnTile(2, 0) {
            return true
        }
        
        if isTurnTile(0, 2) && isTurnTile(1,2) && isTurnTile(2, 2) {
            return true
        }
        
        return false
    }
    
    func checkForDraw() -> Bool {
        for row in board {
            for cell in row {
                if (cell.tile == Tile.Empty) {
                    return false
                }
            }
        }
        
        return true
    }
    
    func isTurnTile(_ row: Int,_ column: Int) -> Bool {
        return board[row][column].tile == turn
    }
    
    func resetBoard() {
        var newBoard = [[Cell]]()
        
        for _ in 0...2 {
            var row = [Cell]()
            
            for _  in 0...2 {
                row.append(Cell(tile: Tile.Empty))
            }
            
            newBoard.append(row);
        }
        
        board = newBoard
    }
}

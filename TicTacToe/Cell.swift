//
//  Cell.swift
//  TicTacToe
//
//  Created by Kevin Quinalia on 21/10/23.
//

import Foundation
import SwiftUI

struct Cell {
    var tile: Tile
    
    func displayTile() -> String {
        switch(tile) {
        case Tile.Nought:
            return "O"
        case Tile.Cross:
            return "X"
        default:
            return ""
            
        }
    }
    
    func displayColor() -> Color {
        switch(tile) {
            case Tile.Nought:
                return Color.red
            case Tile.Cross:
                return Color.black
            default:
                return Color.black
        }
    }
}

enum Tile {
    case Nought
    case Cross
    case Empty
}

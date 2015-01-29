//
//  Switftris.swift
//  Swiftris
//
//  Created by Adriana Gustavson on 1/21/15.
//  Copyright (c) 2015 Adriana Gustavson. All rights reserved.
//


// #1
let NumColumns = 10
let NumRows = 20

let StartingColumn = 4
let StartingRow = 0

let PreviewColumn = 12
let PreviewRow = 1

let PointsPerLine = 10
let LevelThreshold = 1000


protocol SwiftrisDelegate {
    
    // invoked when the cirrent round of Swiftris ends
    func gameDidEnd(swiftris: Swiftris)
    
    // invoked immeditely after a new game has begun
    func gameDidBegin(swiftris: Swiftris)
    
    // invoked when the falling shape has become part of the game board
    func gameShapeDidLand(swiftris: Swiftris)
    
    // invoked when the falling shape has changed its location
    func gameShapeDidMove(swiftris: Swiftris)
    
    // invoked when the galling shape has changed its location after being dropped
    func gameShapeDidDrop(swiftris: Swiftris)
    
    // invoked when the game has reached a new level
    func gameDidLevelUp(swiftris: Swiftris)
    
}


class Swiftris {
    var blockArray: Array2D<Block>
    var nextShape: Shape?
    var fallingShape: Shape?
    var delegate:SwiftrisDelegate?
    
    var score: Int
    var level: Int
    
    init() {
            score = 0
            level = 1
        fallingShape = nil
        nextShape = nil
        blockArray = Array2D<Block>(columns: NumColumns, rows: NumRows)
    }
    
    func beginGame() {
        if (nextShape == nil) {
            nextShape = Shape.random(PreviewColumn, startingRow: PreviewRow)
        }
          delegate?.gameDidBegin(self)
        
    }
// #2
        func newShape() -> (fallingShape: Shape?, nextShape: Shape?) {
            fallingShape = nextShape
            nextShape = Shape.random(PreviewColumn, startingRow: PreviewRow)
            fallingShape?.moveTo(StartingColumn, row: StartingRow)
         
// #1 (playing by the rules)
            if detectIllegalPlacement() {
                nextShape = fallingShape
                nextShape!.moveTo(PreviewColumn, row: PreviewRow)
                endGame()
                return (nil, nil)
            }
            
            return (fallingShape, nextShape)
        }
    
// #2 (playing by the rulles)
    func detectIllegalPlacement() -> Bool {
        if let shape = fallingShape {
            for block in shape.blocks {
                if block.column < 0 || block.column >= NumColumns
                    || block.row < 0 || block.row >= NumRows {
                    return true
                } else if blockArray[block.column, block.row] != nil {
                    return true
                }
            }
        }
        return false
    }
    
// #1 (1.3 playing by the rules)
    func settleShape() {
        if let shape = fallingShape {
            for block in shape.blocks {
                blockArray[block.column, block.row] = block
            }
            fallingShape = nil
            delegate?.gameShapeDidLand(self)
        }
    }
    
// #2 (2.3 playing by the rules)
    func detectTouch() -> Bool {
        if let shape = fallingShape {
            for bottomBlock in shape.bottomBlocks {
                if bottomBlock.row == NumRows - 1 ||
                    blockArray[bottomBlock.column, bottomBlock.row + 1] != nil {
                        return true
                }
            }
        }
        return false
    }
    
    func endGame() {
            score = 0
            level = 1
        delegate?.gameDidEnd(self)
    }
    
// #1 (1.4 playing by the rules)
        
    func removeCompletedLines() -> (linesRemoved: Array<Array<Block>>, fallenBlocks: Array<Array<Block>>) {
        var removedLines = Array<Array<Block>>()
        for var row = NumRows - 1; row > 0; row-- {
            var rowOfBlocks = Array<Block>()
//#2 (2.4 playing by the rules)
            for column in 0..<NumColumns {
                if let block = blockArray[column, row] {
                    rowOfBlocks.append(block)
                }
            }
            if rowOfBlocks.count == NumColumns {
                removedLines.append(rowOfBlocks)
                for block in rowOfBlocks {
                    blockArray[block.column, block.row] = nil
                }
            }
        }
        
// #3 (3.4 playing by the rules)
        
        if removedLines.count == 0 {
            return ([], [])
        }
        let pointsEarned = removedLines.count * PointsPerLine * level
        score += pointsEarned
        if score >= level * LevelThreshold {
            level += 1
            delegate?.gameDidLevelUp(self)
        }
        
        var fallenBlocks = Array<Array<Block>>()
        for column in 0..<NumColumns {
            var fallenBlocksArray = Array<Block>()
            
// #5 (5.4 playing by the rules)
            for var row = removedLines[0][0].row - 1; row > 0; row-- {
                if let block = blockArray[column, row] {
                    var newRow = row
                    while (newRow < NumRows - 1 && blockArray[column, newRow + 1] == nil) {
                        newRow++
                    }
                    block.row = newRow
                    blockArray[column, row] = nil
                    blockArray[column, newRow] = block
                    fallenBlocksArray.append(block)
            }
        }
            if fallenBlocksArray.count > 0 {
                fallenBlocks.append(fallenBlocksArray)
            }
            
    }
        return (removedLines, fallenBlocks)
    }
    
    func removeAllBlocks() -> Array<Array<Block>> {
        var allBlocks = Array<Array<Block>>()
        for row in 0..<NumRows {
            var rowOfBlocks = Array<Block>()
            for column in 0..<NumColumns {
                if let block = blockArray[column, row] {
                    rowOfBlocks.append(block)
                    blockArray[column, row] = nil
                }
            }
            allBlocks.append(rowOfBlocks)
        }
        return allBlocks
    }
    
// #1 (#1.2 playing by the rules)
    func dropShape() {
        if let shape = fallingShape {
            while detectIllegalPlacement() == false {
                shape.lowerShapeByOneRow()
            }
            shape.raiseShapeByOneRow()
            delegate?.gameShapeDidDrop(self)
        }
    }
    
    
// #2 (#2.2 playing by the rules)
    func letShapeFall() {
        if let shape = fallingShape {
            shape.lowerShapeByOneRow()
            if detectIllegalPlacement() {
                shape.raiseShapeByOneRow()
                if detectIllegalPlacement() {
                    endGame()
                } else {
                    settleShape()
                }
                } else {
                    delegate?.gameShapeDidMove(self)
                    if detectTouch() {
                        settleShape()
                    }
                }
            }
        }
    
// #3 (3.2 playing by the rules)
    func rotateShape() {
        if let shape = fallingShape {
            shape.rotateClockwise()
            if detectIllegalPlacement() {
                shape.rotateCounterClockwise()
            } else {
                delegate?.gameShapeDidMove(self)
            }
        }
    }
    
// #4 (4.2 playing by the rules)
    func moveShapeLeft() {
        if let shape = fallingShape {
            shape.shiftLeftByOneColumn()
            if detectIllegalPlacement() {
                shape.shiftRightByOneColumn()
                return
            }
            delegate?.gameShapeDidMove(self)
        }
    }
    
    func moveShapeRight() {
        if let shape = fallingShape {
            shape.shiftRightByOneColumn()
            if detectIllegalPlacement() {
                shape.shiftLeftByOneColumn()
                return
                
            }
            delegate?.gameShapeDidMove(self)
        }
    }
    
    

    
// end Swiftris class
}





















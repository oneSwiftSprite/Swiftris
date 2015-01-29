//
//  LineShape.swift
//  Swiftris
//
//  Created by Adriana Gustavson on 1/20/15.
//  Copyright (c) 2015 Adriana Gustavson. All rights reserved.
//

class LineShape: Shape {
    
    /*

Orientation 0

  * | 0 |
    | 1 |
    | 2 |
    | 3 |

Orientation 90

  *
| 0 | 1 | 2 | 3 |


* marks the row/column indicator

 */
  
    
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:           [(1,0), (1,1), (1,2), (1,3)],
            Orientation.Ninety:         [(0,1), (1,1), (2,1), (3,1)],
            Orientation.OneEighty:      [(1,0), (1,1), (1,2), (1,3)],
            Orientation.TwoSeventy:     [(0,1), (1,1), (2,1), (3,1)]
    ]
    
}



    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
        
            Orientation.Zero:       [blocks[FourthBlockIdx]],
            Orientation.Ninety:     [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.OneEighty:  [blocks[FourthBlockIdx]],
            Orientation.TwoSeventy: [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
        ]
    }


}















//
//  TShape.swift
//  Swiftris
//
//  Created by Adriana Gustavson on 1/20/15.
//  Copyright (c) 2015 Adriana Gustavson. All rights reserved.
//


class TShape: Shape {
    
    /*
    Orientation 0

      * | 0 |
    | 1 | 2 | 3 |

    Orientation 90

      * | 1 |
        | 2 | 0 |
        | 3 |


    Orientation 180

      *
    | 3 | 2 | 1 |
        | 0 |

    Orientation 270

      * | 3 |
    | 0 | 2 |
        | 1 |


    * marks the row/column indicator

*/
    
    
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:           [(1,0), (0,1), (1,1), (2,1)],
            Orientation.Ninety:         [(2,1), (1,0), (1,1), (1,2)],
            Orientation.OneEighty:      [(1,2), (2,1), (1,1), (0,1)],
            Orientation.TwoSeventy:     [(0,1), (1,2), (1,1), (1,0)]
        
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero:           [blocks[SecondBlockIdx], blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety:         [blocks[FirstBlockIdx], blocks[FourthBlockIdx]],
            Orientation.OneEighty:      [blocks[FourthBlockIdx], blocks[FirstBlockIdx], blocks[SecondBlockIdx]],
            Orientation.TwoSeventy:     [blocks[FirstBlockIdx], blocks[SecondBlockIdx]]
        
            
        ]
    }

}



















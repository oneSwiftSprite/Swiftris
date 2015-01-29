//
//  JShape.swift
//  Swiftris
//
//  Created by Adriana Gustavson on 1/20/15.
//  Copyright (c) 2015 Adriana Gustavson. All rights reserved.
//

class JShape: Shape {
    
    
    /*

Orientation 0

  * | 0 |
    | 1 |
| 3 | 2 |

Orientation 90

  *
| 3 |
| 2 | 1 | 0 |


Orientation 180

  * | 2 | 3 |
    | 1 |
    | 0 |

Orientation 270

 *
| 0 | 1 | 2 |
        | 3 |


* marks row/column indicator

*/
    
  


    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:       [(1,0), (1,1), (1,2), (0,1)],
            Orientation.Ninety:     [(2,2), (1,2), (0,2), (0,1)],
            Orientation.OneEighty:  [(1,2), (1,1), (1,0), (2,0)],
            Orientation.TwoSeventy: [(0,1), (1,1), (2,1), (2,2)]
    
        ]
    }

    
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero:       [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety:     [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[ThirdBlockIdx]],
            Orientation.OneEighty:  [blocks[FirstBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoSeventy: [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[FourthBlockIdx]]
        
        ]
    }
}













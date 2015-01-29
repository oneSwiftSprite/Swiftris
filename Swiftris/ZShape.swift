//
//  ZShape.swift
//  Swiftris
//
//  Created by Adriana Gustavson on 1/20/15.
//  Copyright (c) 2015 Adriana Gustavson. All rights reserved.
//

class ZShape: Shape {
    
    /*

Orientation 0

*
| 0 | 1 |
    | 2 | 3 |

Orientation 90

      * | 0 |
    | 2 | 1 |
    | 3 |

Orientation 180

    | 3*| 2 |
        | 1 | 0 |

Orientation 270

*     | 3 |
  | 1 | 2 |
  | 0 |

 
* marks the row/column indicator

 */
    
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:           [(0,1), (1,1), (1,2), (2,2)],
            Orientation.Ninety:         [(1,0), (1,1), (0,1), (0,2)],
            Orientation.OneEighty:      [(2,1), (1,1), (1,0), (0,0)],
            Orientation.TwoSeventy:     [(1,2), (1,1), (2,1), (2,0)]
            
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero:           [blocks[FirstBlockIdx], blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety:         [blocks[SecondBlockIdx], blocks[FourthBlockIdx]],
            Orientation.OneEighty:      [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoSeventy:     [blocks[FirstBlockIdx], blocks[ThirdBlockIdx]]
        
        
        ]
    }
}















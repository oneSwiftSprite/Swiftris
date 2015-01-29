//
//  SShape.swift
//  Swiftris
//
//  Created by Adriana Gustavson on 1/20/15.
//  Copyright (c) 2015 Adriana Gustavson. All rights reserved.
//

class SShape: Shape {
    
    
    /*

Orientation 0

* | 0 |
  | 1 | 2 |
      | 3 |

Orientation 90

 *  | 1 | 0 |
| 3 | 2 |

Orientation 180

  * | 3 |
    | 2 | 1 |
        | 0 |

Orientation 270

*
    | 2 | 3 |
| 0 | 1 |


 * marks row/column indicator

*/
    
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>] {
        return [
            Orientation.Zero:       [(1,0), (1,1), (2,1), (2,2)],
            Orientation.Ninety:     [(2,0), (1,0), (1,1), (0,1)],
            Orientation.OneEighty:  [(2,2), (2,1), (1,1), (1,0)],
            Orientation.TwoSeventy: [(0,2), (1,2), (1,1), (2,1)]
        
        ]
    
    }
    
    override var bottomBlocksForOrientations: [Orientation: Array<Block>] {
        return [
            Orientation.Zero:       [blocks[SecondBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety:     [blocks[FirstBlockIdx], blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.OneEighty:  [blocks[FirstBlockIdx], blocks[ThirdBlockIdx]],
            Orientation.TwoSeventy: [blocks[FirstBlockIdx], blocks[SecondBlockIdx], blocks[FourthBlockIdx]]
        
        
        ]
    }


}






















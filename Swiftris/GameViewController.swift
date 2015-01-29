//
//  GameViewController.swift
//  Swiftris
//
//  Created by Adriana Gustavson on 1/19/15.
//  Copyright (c) 2015 Adriana Gustavson. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController, SwiftrisDelegate, UIGestureRecognizerDelegate {
    
    var scene: GameScene!
    var swiftris: Swiftris!
    
    var panPointReference: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    //Configure the view
        let skView = view as SKView
        skView.multipleTouchEnabled = false
        
        
    //Create and configure the scene
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
// #1 ( connection drawing layer to logic layer with user interface class)
        scene.tick = didTick
        
        swiftris = Swiftris()
            swiftris.delegate = self
        swiftris.beginGame()
        
        
    //Present the scene
        skView.presentScene(scene)
        
// #2 ( connection drawing layer to logic layer with user interface class)
// removed in Playing By the Rules
/*        scene.addPreviewShapeToScene(swiftris.nextShape!) {
            self.swiftris.nextShape?.moveTo(StartingColumn, row: StartingRow)
            self.scene.movePreviewShape(self.swiftris.nextShape!) {
                let nextShapes = self.swiftris.newShape()
                self.scene.startTicking()
                self.scene.addPreviewShapeToScene(nextShapes.nextShape!) {}
            }
        }
*/
        
    }

    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
// #3 ( connection drawing layer to logic layer with user interface class)
    
    
    @IBAction func didTap(sender: UITapGestureRecognizer) {
        swiftris.rotateShape()
    }
    
    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        let currentPoint = sender.translationInView(self.view)
        if let originalPoint = panPointReference {
            
            if abs(currentPoint.x - originalPoint.x) > (BlockSize * 0.9) {
                
                if sender.velocityInView(self.view).x > CGFloat(0) {
                    swiftris.moveShapeRight()
                    panPointReference = currentPoint
                } else {
                    swiftris.moveShapeLeft()
                    panPointReference = currentPoint
                }
            }
        }  else if sender.state == .Began {
            panPointReference = currentPoint
        }
    }
    
    func didTick() {
// #1 (1.1 playing by the rules)
        swiftris.letShapeFall()
/*        swiftris.fallingShape?.lowerShapeByOneRow()
        scene.redrawShape(swiftris.fallingShape!, completion: {})
*/
    }
    
    func nextShape() {
        let newShapes = swiftris.newShape()
        if let fallingShape = newShapes.fallingShape {
            self.scene.addPreviewShapeToScene(newShapes.nextShape!) {}
            self.scene.movePreviewShape(fallingShape) {
// #2 (2.1 playing by the rules)
                self.view.userInteractionEnabled = true
                self.scene.startTicking()
            }
        }
    }
    
    func gameDidBegin(swiftris: Swiftris) {
        //the following is false when restarting a new game
        if swiftris.nextShape != nil && swiftris.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(swiftris.nextShape!) {
                self.nextShape()
            }
        } else {
            nextShape()
        }
    }
    
    func gameDidEnd(swiftris: Swiftris) {
        view.userInteractionEnabled = false
        scene.stopTicking()
    }
    
    func gameDidLevelUp(swiftris: Swiftris) {
        
    }
    
    func gameShapeDidDrop(swiftris: Swiftris) {
        
    }
    
    func gameShapeDidLand(swiftris: Swiftris) {
        scene.stopTicking()
        nextShape()
    }
    
// #3 (3.1 playing by the rules)
    func gameShapeDidMove(swiftris: Swiftris) {
        scene.redrawShape(swiftris.fallingShape!) {}
    }

}



















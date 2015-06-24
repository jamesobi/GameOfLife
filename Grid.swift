//
//  Grid.swift
//  GameOfLife
//
//  Created by James Sobieski on 6/23/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import UIKit
import Foundation

let GridRows = 8
let GridColumns = 10

class Grid: CCSprite {
    
    var totalAlive = 0
    var generation = 0
    
    var cellWidth: CGFloat = 0
    var cellHeight: CGFloat = 0
    
    var gridArray: [[Creature]]!
    
    weak var populationCount: CCLabelTTF!
    weak var generationCount: CCLabelTTF!
    weak var grid: Grid!
    
    var timer = CCTimer()
    
    
    override func onEnter() {
        super.onEnter()
        setUpGrid()
        userInteractionEnabled = true
    }
    
    func setUpGrid(){
        cellWidth = contentSize.width / CGFloat(GridColumns)
        cellHeight = contentSize.height / CGFloat(GridRows)
        
        gridArray = []
        
        for row in 0..<GridRows {
            gridArray.append([])
            for column in 0..<GridColumns {
                var creature = Creature()
                creature.position = CGPoint(x: cellWidth * CGFloat(column), y: cellHeight * CGFloat(row))
                
                addChild(creature)
                gridArray[row].append(creature)
                
                creature.isAlive = false
            }
        }
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        var touchLocation = touch.locationInNode(self)
        var creature = creatureForTouchPosition(touchLocation)
        
        creature.isAlive = !creature.isAlive
    }
    
    func creatureForTouchPosition(touchLocation: CGPoint) -> Creature{
        var row = Int(touchLocation.y / cellHeight)
        var col = Int(touchLocation.x / cellWidth)
        
        return gridArray[row][col]
    }
    
    
    func isValid(row:Int, col:Int) -> Bool {
        var done:Bool = true
        if row < 0 || col < 0 {
            done = false
        }
        if row > GridRows - 1  || col > (GridRows - 1) {
            done = false
        }
        return done
    }
    
    func countNeighbors(){
        /*var done = 0
        for row in 0..<GridRows {
            for column in 0..<GridColumns {
                
                //var currentCreature:Creature = gridArray[row][column]
                
                for var r = -1; r < 2; r += 1 {
                    for var c = -1; c < 2; c += 1 {
                        if isValid((row + r), col: (column + c)) {
                            if (!(r == 0 && c==0)) {
                                if gridArray[row + r][column + c].isAlive {
                                    done++
                                    
                                    println("row: \(row + r) col: \(column + c)")
                                    println("matches")
                                    println("row: \(row) col: \(column)")
                                    println("-----")
                                }
                            }
                        }
                    }
                }
                
                /*if isValid(row, col: column + 1) && gridArray[row][column + 1].isAlive {
                    done++
                }
                if isValid(row, col: column - 1) && gridArray[row][column - 1].isAlive {
                    done++
                }
                if isValid(row+1, col: column + 1) && gridArray[row + 1][column + 1].isAlive {
                    done++
                }
                if isValid(row+1, col: column - 1) && gridArray[row + 1][column - 1].isAlive {
                    done++
                }
                if isValid(row+1, col: column) && gridArray[row + 1][column].isAlive {
                    done++
                }
                if isValid(row-1, col: column + 1) && gridArray[row - 1][column + 1].isAlive {
                    done++
                }
                if isValid(row-1, col: column - 1) && gridArray[row - 1][column - 1].isAlive {
                    done++
                }
                if isValid(row-1, col: column) && gridArray[row - 1][column].isAlive {
                    done++
                }*/
                
                gridArray[row][column].livingNeighborsCount = done
            }
        }*/
        
        
        for row in 0..<gridArray.count {
            for column in 0..<gridArray[row].count {
                
                var currentCreature = gridArray[row][column]
                currentCreature.livingNeighborsCount = 0
                
                for x in (row - 1)...(row + 1) {
                    for y in (column - 1)...(column + 1) {
                        
                        var validIndex = isValid( x, col: y)
                        
                        if validIndex && !(x == row && y == column) {
                            
                            var neighbor = gridArray[x][y]
                            
                            if neighbor.isAlive {
                                currentCreature.livingNeighborsCount++
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    func updateCreatures(){
        println("made it to the update function")
        
        totalAlive = 0
        for row in 0..<GridRows {
            for column in 0..<GridColumns {
                var currentCreature:Creature = gridArray[row][column]
                var currentNeighborCount = currentCreature.livingNeighborsCount
                
                if gridArray[row][column].livingNeighborsCount < 2 {
                    gridArray[row][column].isAlive = false
                } else if (gridArray[row][column].isAlive && currentNeighborCount == 2) || gridArray[row][column].livingNeighborsCount == 3 {
                    gridArray[row][column].isAlive = true
                    totalAlive++
                } else if gridArray[row][column].livingNeighborsCount > 3 {
                    gridArray[row][column].isAlive = false
                }
                
            }
        }
    }
    
    func evolveStep() {
        println("made it to the evolve function")
        countNeighbors()
        updateCreatures()
        generation++
    }
    
}

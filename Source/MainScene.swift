import Foundation

class MainScene: CCNode {
    weak var populationBalloon: CCLabelTTF!
    weak var generationBalloon: CCLabelTTF!
    weak var grid: Grid!

    var timer = CCTimer()
    
    
    
    func play(){
        println("made it to the play function")
        schedule("step", interval: CCTime(0.5))
        //grid.countNeighbors()
        //grid.updateCreatures()
        
        
    }
    func pause(){
        unschedule("step")
        grid.generation = 0
    }
    func step(){
        //println("made it to the grid function")
        
        grid.evolveStep()
        
        generationBalloon.string = "\(grid.generation)"
        populationBalloon.string = "\(grid.totalAlive)"
    }
}

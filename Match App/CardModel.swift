//
//  CardModel.swift
//  Match App
//
//  Created by The book on 2018. 8. 15..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation

class CardModel {
    
    func getCard() -> [Card]{
        //Decare an array to store the generated cards
        var generatedCardArray = [Card]()
        
        //Randomly generate pairs of cards
        
        for _ in 1...8 {
            
                //get a randomNumber
                let randomNumber = arc4random_uniform(13) + 1
            
              //log number
            print(randomNumber)
            
              //Create the first card object
                let cardOne = Card()
                cardOne.imageName = "card\(randomNumber)"
            
                generatedCardArray.append(cardOne)
            
            //Create the secon card object
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
            
                generatedCardArray.append(cardTwo)
            //Optional : Make it so we only have unique pairs of cards
        }
        
        //TODO :Randomize the array
        
        //Returned array
        
        return generatedCardArray
    }
}

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
        
        //Declare an array to store numbers we've already generated
        var generatedNumbersArray = [Int]()
        
        //Decare an array to store the generated cards
        var generatedCardArray = [Card]()
        
        //Randomly generate pairs of cards
        
        while generatedNumbersArray.count < 8 {
            
                //get a randomNumber
                let randomNumber = arc4random_uniform(13) + 1
            
            //Ensure that the random nuber isn't one we already have
            if generatedNumbersArray.contains(Int(randomNumber)) == false {
                
                //log number
                print(randomNumber)
                
                //Store the number into the generatedNumbersArray
                generatedNumbersArray.append(Int(randomNumber))
                
                //Create the first card object
                let cardOne = Card()
                cardOne.imageName = "card\(randomNumber)"
                
                generatedCardArray.append(cardOne)
                
                //Create the secon card object
                let cardTwo = Card()
                cardTwo.imageName = "card\(randomNumber)"
                
                generatedCardArray.append(cardTwo)
                
            }
            
            // Make it so we only have unique pairs of cards
        }
        
        //TODO :Randomize the array
        for i in 0 ... generatedCardArray.count-1 {
            //Find a random index to swap with
            let randomNumber = Int(arc4random_uniform(UInt32(generatedCardArray.count)))
            
            //Swap the two cards
            let temporaryStorage = generatedCardArray[i]
            generatedCardArray[i] = generatedCardArray[randomNumber]
            generatedCardArray[randomNumber] = temporaryStorage
        }
        //Returned array
        
        return generatedCardArray
    }
}

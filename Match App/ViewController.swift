//
//  ViewController.swift
//  Match App
//
//  Created by The book on 2018. 8. 15..
//  Copyright © 2018년 The book. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    var timer:Timer?
    var milliseconds:Float = 10 * 1000 // 10 seconds

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call the get card method of the card model
        cardArray =  model.getCard()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //Create Timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Timer Methods
    @objc func timerElapsed() {
        
        milliseconds -= 1
        
        // Conver to seconds
        let seconds = String(format: "%.2f", milliseconds/1000)
        
        //Set label
        timerLabel.text = "Timer Remaing: \(seconds)"
        
        //When the timer has reached 0
        if milliseconds <= 0 {
            
            //Stop the timer
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            
            //Check if there are any cards unmatched
            checkGameEnded()
        }
    }
    
    
    //MARK: - UICollectionView Protocol Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //GEt a CardCollectionViewCell object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        
        //Get the card that the collection view is trying to display
        let card = cardArray[indexPath.row]
        
        //Set that for the cell
        cell.setCard(card)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Check if there's any time left
        if milliseconds <= 0 {
            return
        }
        
        //Get the cell that user selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        //Get the card that user selected
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false && card.isMatched == false {
            
            //flip the card
            cell.flip()
            
            //Set the status of the card
            card.isFlipped = true
            
            //Determine if it's the first card or second card that's flipped over.
            if firstFlippedCardIndex == nil {
                //This is the first card being flipped
                firstFlippedCardIndex = indexPath
                
            } else {
                //This is the second card being flipped
                
                // Perform the matching logic
                checkForMatches(indexPath)
                
            }
            
        }
        
    }// Ending of didSelectItemAt method
    
    //MARK : - Game Logic Method
    func checkForMatches(_ secondFlippedCardIndex:IndexPath){
        
        //Get the cells for the two cards were revealed
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        // Get the card for the two cards were revealed
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        //Compare the two cards
       if cardOne.imageName == cardTwo.imageName {
            // It's a match
            
            //Set the statuses of the cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            //Remove the card of the gird
            cardOneCell?.remove()
            cardTwoCell?.remove()
        
         //Check if there are any cards left unmatched
        checkGameEnded()
            
       } else {
            //it's not a match
        
            //Set the status of the card
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
        
            //Flip back both cards
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        
        }
        //Tell the collectionview to reload the cell of the first card if it is nill
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        
        //Reset the property that tracks the first card flipped
        firstFlippedCardIndex = nil
    }
    
    func checkGameEnded() {
        //Determine if there are any cards unmatched
        var isWon = true
        
        for card in cardArray {
            if card.isMatched == false{
                isWon = false
                break
              }
            }
            //Messaging variables
        var title = ""
        var message = ""
        
            // If not, then user has won, stop the timer
        if isWon == true {
            
            if milliseconds > 0 {
                timer?.invalidate()
            }
            
           
        } else {
            //If there are unmatched card, check if there;s any time left
            if milliseconds > 0 {
                return
            }
            title = "Game Over"
            message = "You've lost"
        }
    showAlert(title, message)
        
    }
    
    func showAlert(_ title:String, _ message:String) {
        //Show won/lost massaging
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}//Ending of VeiwControllerCalss



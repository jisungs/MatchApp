//
//  ViewController.swift
//  Match App
//
//  Created by The book on 2018. 8. 15..
//  Copyright © 2018년 The book. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call the get card method of the card model
        cardArray =  model.getCard()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        //Get the cell that user selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        //Get the card that user selected
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false {
            
            //flip the card
            cell.flip()
            
            //Set the status of the card
            card.isFlipped = true
            
        }else {
            //Flip the card back
            cell.flipBack()
            
            //Set the status of the card
            card.isFlipped = false
        }
        
        
        
    }
}



//
//  CardCollectionViewCell.swift
//  Match App
//
//  Created by The book on 2018. 8. 15..
//  Copyright © 2018년 The book. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func setCard(_ card:Card) {
        
        //Keep track of the card that gets passed in
        self.card = card
        
        frontImageView.image = UIImage(named: card.imageName)
        
        //Determine if the card is a fliped up state or fliped down state
        if card.isFlipped == true {
            //Make sure the frontimageView is on top
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
            
        } else {
            //Make sure the backimageview is on top
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
            
        }
    }
    
    func flip() {
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    }
    
    func flipBack() {
        UIView.transition(from: frontImageView, to: backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        
    }
}

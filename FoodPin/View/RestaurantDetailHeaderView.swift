//
//  RestaurantDetailHeaderView.swift
//  FoodPin
//
//  Created by Sravan Goud on 19/01/25.
//

import UIKit

class RestaurantDetailHeaderView: UIView {
    
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = 0
            
            if let customFont = UIFont(name: "Nunito-Bold", size: 40.0) {
                nameLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
            }
        }
    }
    @IBOutlet var typeLabel: UILabel!{
        didSet {
            if let customFont = UIFont(name: "Nunito-Bold", size: 20.0) {
                nameLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
            }
        }
    }
    @IBOutlet var heartButton: UIButton!

}

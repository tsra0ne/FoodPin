//
//  RestaurantTableViewCell.swift
//  FoodPin
//
//  Created by Sravan Goud on 14/01/25.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var heartImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tintColor = .systemYellow
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  RestaurantDiffableDataSource.swift
//  FoodPin
//
//  Created by Sravan Goud on 18/01/25.
//

import UIKit

enum Section {
    case all
}

class RestaurantDiffableDataSource: UITableViewDiffableDataSource<Section, Restaurant> {
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

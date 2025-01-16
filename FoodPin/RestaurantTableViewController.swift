//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Sravan Goud on 14/01/25.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurantNames = [
        "Cafe Deadend",
        "Homei",
        "Teakha",
        "Cafe Loisl",
        "Petite Oyster",
        "For Kee Restaurant",
        "Po's Atelier",
        "Bourke Street Bakery",
        "Haigh's Chocolate",
        "Palomino Espresso",
        "Upstate",
        "Traif",
        "Graham Avenue Meats And Deli",
        "Waffle & Wolf",
        "Five Leaves",
        "Cafe Lore",
        "Confessional",
        "Barrafina",
        "Donostia",
        "Royal Oak",
        "CASK Pub and Kitchen"
    ]
    
    var restaurantImages = [
        "cafedeadend",
        "homei",
        "teakha",
        "cafeloisl",
        "petiteoyster",
        "forkee",
        "posatelier",
        "bourkestreetbakery",
        "haigh",
        "palomino",
        "upstate",
        "traif",
        "graham",
        "waffleandwolf",
        "fiveleaves",
        "cafelore",
        "confessional",
        "barrafina",
        "donostia",
        "royaloak",
        "cask"
    ]
    
    var restaurantLocations = [
        "Hong Kong",
        "Hong Kong",
        "Hong Kong",
        "Hong Kong",
        "Hong Kong",
        "Hong Kong",
        "Hong Kong",
        "Sydney",
        "Sydney",
        "Sydney",
        "New York",
        "New York",
        "New York",
        "New York",
        "New York",
        "New York",
        "New York",
        "London",
        "London",
        "London",
        "London"
    ]
    
    var restaurantTypes = [
        "Coffee & Tea Shop",
        "Cafe",
        "Tea House",
        "Austrian / Causual Drink",
        "French",
        "Bakery",
        "Bakery",
        "Chocolate",
        "Cafe",
        "American / Seafood",
        "American",
        "American",
        "Breakfast & Brunch",
        "Coffee & Tea",
        "Coffee & Tea",
        "Latin American",
        "Spanish",
        "Spanish",
        "Spanish",
        "British",
        "Thai"
    ]
    
    var restaurantIsFavorites = Array(repeating: false, count: 21)
    
    lazy var dataSource = configureDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.dataSource = dataSource
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurantNames, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    enum Section {
        case all
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section, String> {
        let cellIdentifier = "dataCell"
        
        let dataSource = UITableViewDiffableDataSource<Section, String>(tableView: tableView) { tableView, indexPath, restaurantName in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
            cell.nameLabel.text = restaurantName
            cell.locationLabel.text = self.restaurantLocations[indexPath.row]
            cell.typeLabel.text = self.restaurantTypes[indexPath.row]
            cell.thumbnailImageView.image = UIImage(named: self.restaurantImages[indexPath.row])
            cell.accessoryType = self.restaurantIsFavorites[indexPath.row] ? .checkmark : .none
            return cell
        }
        
        return dataSource
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let optionMenu = UIAlertController(title: nil, message: "what do you want to do?", preferredStyle: .actionSheet)
        
        if let popOverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popOverController.sourceView = cell
                popOverController.sourceRect = cell.bounds
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        optionMenu.addAction(cancelAction)
        
        let reservationHandler = { (action: UIAlertAction) -> Void in
            let alertMessage = UIAlertController(title: "Not available yet", message: "Sorry, this feature is not available yet. Please retry later.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        
        let reserveAction = UIAlertAction(title: "Reserve a table", style: .default, handler: reservationHandler)
        optionMenu.addAction(reserveAction)
        
        let selectedRestaurantPresentInFavorites = restaurantIsFavorites[indexPath.row]
        let favoriteActionTitle = selectedRestaurantPresentInFavorites ? "Remove from favorites" : "Mark as favorite"
        
        let favoriteAction = UIAlertAction(title: favoriteActionTitle, style: .default) { action in
            let cell = tableView.cellForRow(at: indexPath)
            if !selectedRestaurantPresentInFavorites {
                cell?.accessoryType = .checkmark
                self.restaurantIsFavorites[indexPath.row] = true
            } else {
                cell?.accessoryType = .none
            }
        }
        optionMenu.addAction(favoriteAction)
        
        present(optionMenu, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }

}

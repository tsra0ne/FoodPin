//
//  RestaurantTableViewController.swift
//  FoodPin
//
//  Created by Sravan Goud on 14/01/25.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    
    var restaurants: [Restaurant] = [
        Restaurant(name: "Cafe Deadend", type: "Coffee & Tea Shop", location:"Hong Kong", image: "cafedeadend", isFavorite: false),
        Restaurant(name: "Homei", type: "Cafe", location: "Hong Kong", image: "homei", isFavorite: false),
        Restaurant(name: "Teakha", type: "Tea House", location: "Hong Kong", image: "teakha", isFavorite: false),
        Restaurant(name: "Cafe loisl", type: "Austrian / Causual Drink", location: "Hong Kong", image: "cafeloisl", isFavorite: false),
        Restaurant(name: "Petite Oyster", type: "French", location: "Hong Kong", image: "petiteoyster", isFavorite: false),
        Restaurant(name: "For Kee Restaurant", type: "Bakery", location: "Hong Kong", image: "forkee", isFavorite: false),
        Restaurant(name: "Po's Atelier", type: "Bakery", location: "Hong Kong", image: "posatelier", isFavorite: false),
        Restaurant(name: "Bourke Street Backery", type: "Chocolate", location: "Sydney", image: "bourkestreetbakery", isFavorite: false),
        Restaurant(name: "Haigh's Chocolate", type: "Cafe", location: "Sydney", image: "haigh", isFavorite: false),
        Restaurant(name: "Palomino Espresso", type: "American / Seafood", location: "Sydney", image: "palomino", isFavorite: false),
        Restaurant(name: "Upstate", type: "American", location: "New York", image: "upstate", isFavorite: false),
        Restaurant(name: "Traif", type: "American", location: "New York", image: "traif", isFavorite: false),
        Restaurant(name: "Graham Avenue Meats", type: "Breakfast & Brunch", location: "New York", image: "graham", isFavorite: false),
        Restaurant(name: "Waffle & Wolf", type: "Coffee & Tea", location: "New York", image: "waffleandwolf", isFavorite: false),
        Restaurant(name: "Five Leaves", type: "Coffee & Tea", location: "New York", image: "fiveleaves", isFavorite: false),
        Restaurant(name: "Cafe Lore", type: "Latin American", location: "New York", image: "cafelore", isFavorite: false),
        Restaurant(name: "Confessional", type: "Spanish", location: "New York", image: "confessional", isFavorite: false),
        Restaurant(name: "Barrafina", type: "Spanish", location: "London", image: "barrafina", isFavorite: false),
        Restaurant(name: "Donostia", type: "Spanish", location: "London", image: "donostia", isFavorite: false),
        Restaurant(name: "Royal Oak", type: "British", location: "London", image: "royaloak", isFavorite: false),
        Restaurant(name: "CASK Pub and Kitchen", type: "Thai", location: "London", image: "cask", isFavorite: false)
        ]
    
    lazy var dataSource = configureDataSource()
    
    // MARK: - View controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.dataSource = dataSource
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Restaurant>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurants, toSection: .all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // MARK: - UITableView Diffable Data Source
    
    func configureDataSource() -> RestaurantDiffableDataSource {
        let cellIdentifier = "dataCell"
        
        let dataSource = RestaurantDiffableDataSource(tableView: tableView) { tableView, indexPath, restaurant in
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
            cell.nameLabel.text = restaurant.name
            cell.locationLabel.text = restaurant.location
            cell.typeLabel.text = restaurant.type
            cell.thumbnailImageView.image = UIImage(named: restaurant.image)
            cell.heartImageView.isHidden = self.restaurants[indexPath.row].isFavorite ? false : true
            return cell
        }
        
        return dataSource
    }
    
    // MARK: - UITableViewDelegate Protocol
    
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
        
        let selectedRestaurantPresentInFavorites = restaurants[indexPath.row].isFavorite
        let favoriteActionTitle = selectedRestaurantPresentInFavorites ? "Remove from favorites" : "Mark as favorite"
        
        let favoriteAction = UIAlertAction(title: favoriteActionTitle, style: .default) { action in
            let cell = tableView.cellForRow(at: indexPath) as? RestaurantTableViewCell
            if selectedRestaurantPresentInFavorites {
                cell?.heartImageView.isHidden = true
                self.restaurants[indexPath.row].isFavorite = false
            } else {
                cell?.heartImageView.isHidden = false
                self.restaurants[indexPath.row].isFavorite = true
            }
        }
        optionMenu.addAction(favoriteAction)
        
        present(optionMenu, animated: true)
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Get the selected restaurant
        guard let restaurant = self.dataSource.itemIdentifier(for: indexPath) else { return UISwipeActionsConfiguration() }
        
        // Delete Action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, sourceView, completionHandler in
            var snapshot = self.dataSource.snapshot()
            snapshot.deleteItems([restaurant])
            self.dataSource.apply(snapshot, animatingDifferences: true)
            completionHandler(true)
        }
        
        // Share Action
        let shareAction = UIContextualAction(style: .normal, title: "Share") { action, sourceView, completionHandler in
            let defaultText = "Just checking in at " + restaurant.name
            
            let activityController: UIActivityViewController
            
            if let imageToShare = UIImage(named: restaurant.image) {
                activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
            } else {
                activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            }
            
            if let popoverController = activityController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            
            self.present(activityController, animated: true)
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = UIColor.systemRed
        deleteAction.image = UIImage(systemName: "trash")
        
        shareAction.backgroundColor = UIColor.systemOrange
        shareAction.image = UIImage(systemName: "square.and.arrow.up")
        
        // Configure both actions as swipe action
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
        return swipeConfiguration
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let selectedRestaurantPresentInFavorites = restaurants[indexPath.row].isFavorite
        
        let favoriteAction = UIContextualAction(style: .normal, title: nil) { action, sourceView, completionHandler in
            if let cell = tableView.cellForRow(at: indexPath) as? RestaurantTableViewCell {
                if selectedRestaurantPresentInFavorites {
                    cell.heartImageView.isHidden = true
                    self.restaurants[indexPath.row].isFavorite = false
                } else {
                    cell.heartImageView.isHidden = false
                    self.restaurants[indexPath.row].isFavorite = true
                }
            }
            completionHandler(true)
        }
        
        if selectedRestaurantPresentInFavorites {
            favoriteAction.image = UIImage(systemName: "heart.slash.fill")
        } else {
            favoriteAction.image = UIImage(systemName: "heart.fill")
        }
        favoriteAction.backgroundColor = UIColor.systemYellow
        
        let swipeConfiguration = UISwipeActionsConfiguration(actions: [favoriteAction])
        return swipeConfiguration
    }
    
}

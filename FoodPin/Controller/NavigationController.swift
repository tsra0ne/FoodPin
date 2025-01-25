//
//  NavigationController.swift
//  FoodPin
//
//  Created by Sravan Goud on 25/01/25.
//

import UIKit

class NavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }

}

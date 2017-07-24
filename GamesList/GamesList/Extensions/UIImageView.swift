//
//  UIImageView.swift
//  GamesList
//
//  Created by Leandro Sousa on 23/07/17.
//  Copyright © 2017 Leandro Sousa. All rights reserved.
//

import UIKit

extension UIImageView {
	
	func loadIconWith(shortTitle: String) {
		GLDataController.shared.loadIcon(imageView: self, shortTitle: shortTitle)
	}
}

//
//  UIView.swift
//  GamesList
//
//  Created by Leandro Sousa on 24/07/17.
//  Copyright © 2017 Leandro Sousa. All rights reserved.
//

import UIKit

extension UIView {
	
	func roundCorners(radius: CGFloat = 8.0) {
		self.layer.cornerRadius = radius
		self.layer.masksToBounds = true
	}
}

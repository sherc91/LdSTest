//
//  GLViewManager.swift
//  GamesList
//
//  Created by Leandro Sousa on 24/07/17.
//  Copyright © 2017 Leandro Sousa. All rights reserved.
//

import UIKit

class GLViewManager {
	
	class func gameDetailsViewController() -> UIViewController? {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		return storyboard.instantiateViewController(withIdentifier: "gameDetailsID")
	}
}

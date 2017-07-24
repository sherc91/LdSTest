//
//  GLGameDetailsViewController.swift
//  GamesList
//
//  Created by Leandro Sousa on 23/07/17.
//  Copyright © 2017 Leandro Sousa. All rights reserved.
//

import UIKit

class GLGameDetailsViewController: UIViewController {
	
	@IBOutlet weak var gameIcon: UIImageView!
	@IBOutlet weak var gameTitle: UILabel!
	
	var game: GLGame?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard let game = self.game else {
			self.gameIcon.image = UIImage.placeholder()
			self.gameTitle.text = ""
			return
		}
		
		self.gameIcon.roundCorners()
		self.gameIcon.loadIconWith(shortTitle: game.shortTitle)
		self.gameTitle.text = String(htmlEncodedString: game.title)
	}
}

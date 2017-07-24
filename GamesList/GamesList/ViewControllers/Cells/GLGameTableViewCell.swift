//
//  GLGameTableViewCell.swift
//  GamesList
//
//  Created by Leandro Sousa on 23/07/17.
//  Copyright © 2017 Leandro Sousa. All rights reserved.
//

import UIKit

class GLGameTableViewCell: UITableViewCell {
	
	@IBOutlet weak var gameIcon: UIImageView!
	@IBOutlet weak var gameTitle: UILabel!
	
	var game: GLGame?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.gameIcon.image = UIImage.placeholder()
		self.gameTitle.text = ""
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		self.gameIcon.image = UIImage.placeholder()
		self.gameTitle.text = ""
	}
	
	func loadCellWith(game: GLGame) {
		
		self.game = game
		
		self.gameIcon.roundCorners()
		self.gameIcon.loadIconWith(shortTitle: game.shortTitle)
		self.gameTitle.text = String(htmlEncodedString: game.title)
	}
}

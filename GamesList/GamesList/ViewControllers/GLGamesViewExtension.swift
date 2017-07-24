//
//  GLGamesViewExtension.swift
//  GamesList
//
//  Created by Leandro Sousa on 24/07/17.
//  Copyright © 2017 Leandro Sousa. All rights reserved.
//

import UIKit

extension GLGamesViewController: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.games.count
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		return tableView.dequeueReusableCell(withIdentifier: reuseIdentifierGameCell)!.frame.height
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let game = self.games[indexPath.row]
		
		let gameCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifierGameCell, for: indexPath) as! GLGameTableViewCell
		gameCell.loadCellWith(game: game)
		return gameCell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		UIApplication.shared.beginIgnoringInteractionEvents()
		
		let cell = tableView.cellForRow(at: indexPath)
		
		if let gameCell = cell as? GLGameTableViewCell {
			guard let game = gameCell.game else {
				UIApplication.shared.endIgnoringInteractionEvents()
				return
			}
			
			self.presentGameDetailsView(game: game)
		}
		
		UIApplication.shared.endIgnoringInteractionEvents()
	}
}

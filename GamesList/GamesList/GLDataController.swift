//
//  GLDataController.swift
//  GamesList
//
//  Created by Leandro Sousa on 23/07/17.
//  Copyright © 2017 Leandro Sousa. All rights reserved.
//

import UIKit
import AlamofireImage

enum ResponseStatus {
	case connectionError
	case error
	case success
}

class GLDataController {
	
	static let shared = GLDataController()
	private init() { }
	
	func gamesList(_ completionHandler: @escaping (_ status: ResponseStatus, _ games: [GLGame]?) -> ()) {
		
		GLConnectionManager.shared.gamesList { (json, error) in
			
			var games: [GLGame] = []
			
			guard let responseJson = json as? NSArray else {
				completionHandler(.connectionError, nil)
				return
			}
			
			for payload in responseJson {
				if let payload = payload as? NSDictionary, let game = GLGame(json: payload) {
					games.append(game)
				}
			}
			
			completionHandler(.success, games)
		}
	}
	
	func gameDetails(gameID: Int, _ completionHandler: @escaping (_ status: ResponseStatus, _ game: GLGame?) -> ()) {
		
		GLConnectionManager.shared.gameDetails(gameID: gameID) { (json, error) in
			
			guard let responseJson = json as? NSDictionary else {
				completionHandler(.connectionError, nil)
				return
			}
			
			if let game = GLGame(json: responseJson) {
				completionHandler(.success, game)
				return
			}
			else {
				completionHandler(.error, nil)
				return
			}
		}
	}
	
	func loadIcon(imageView: UIImageView, shortTitle: String) {
		
		let placeholder = UIImage.placeholder()
		let address = URLs.kGameIcon(shortTitle: shortTitle)
		
		if let url = URL(string: address) {
			imageView.af_setImage(withURL: url, placeholderImage: placeholder, imageTransition: .crossDissolve(0.15))
		}
	}
}

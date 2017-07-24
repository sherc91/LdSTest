//
//  GLURL.swift
//  GamesList
//
//  Created by Leandro Sousa on 23/07/17.
//  Copyright © 2017 Leandro Sousa. All rights reserved.
//

struct URLs {
	
	private init() { }
	
	private static let kServer = "https://api.atmosplay.com/game/"
	private static let kImages = "https://demos.atmosplay.com/"
	private static let kIcon   = "/icon.png"
	
	static let kSchema = "atmos://"
	
	static let kGamesList = kServer + "get/tests"
	
	static func kGameDetails(gameID: Int) -> String {
		return URLs.kServer + String(gameID)
	}
	
	static func kGameIcon(shortTitle: String) -> String {
		return URLs.kImages + shortTitle + URLs.kIcon
	}
}

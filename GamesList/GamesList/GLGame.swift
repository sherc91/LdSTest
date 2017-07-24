//
//  GLGame.swift
//  GamesList
//
//  Created by Leandro Sousa on 23/07/17.
//  Copyright © 2017 Leandro Sousa. All rights reserved.
//

import UIKit

class GLGame: NSObject, NSCoding {
	
	var id         : Int     = 0
	var title      : String  = ""
	var shortTitle : String  = ""
	
	private var payload: NSDictionary?
	
	convenience required init?(coder aDecoder: NSCoder) {
		guard let payload = aDecoder.decodeObject(forKey: "payload") as? NSDictionary else {
			return nil
		}
		self.init(json: payload)
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(payload, forKey: "payload")
	}
	
	init?(json: NSDictionary) {
		super.init()
		
		payload = json
		
		id         = json["id"]         as? Int    ?? 0
		title      = json["title"]      as? String ?? ""
		shortTitle = json["shortTitle"] as? String ?? ""
	}
	
	override var description: String {
		
		print()
		print("Game:")
		print("ID:         ", self.id)
		print("Title:      ", self.title)
		print("ShortTitle: ", self.shortTitle)
		print()
		
		return "Game: \(self.id) " + self.title
	}
}

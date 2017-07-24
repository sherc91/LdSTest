//
//  String.swift
//  GamesList
//
//  Created by Leandro Sousa on 24/07/17.
//  Copyright © 2017 Leandro Sousa. All rights reserved.
//

import UIKit

extension String {
	
	init(htmlEncodedString: String) {
		self.init()
		
		guard let encodedData = htmlEncodedString.data(using: .utf8) else {
			self = htmlEncodedString
			return
		}
		
		let attributedOptions: [String : Any] = [
			NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
			NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
		]
		
		do {
			let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
			self = attributedString.string
		} catch {
			print("Error: \(error)")
			self = htmlEncodedString
		}
	}
}

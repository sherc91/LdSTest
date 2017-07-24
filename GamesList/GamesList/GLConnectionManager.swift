//
//  GLConnectionManager.swift
//  GamesList
//
//  Created by Leandro Sousa on 23/07/17.
//  Copyright © 2017 Leandro Sousa. All rights reserved.
//

import UIKit
import Alamofire

class GLConnectionManager {
	
	static let shared = GLConnectionManager()
	
	private var alamoFireManager = Alamofire.SessionManager.default
	
	private init() {
		let configuration = URLSessionConfiguration.default
		configuration.timeoutIntervalForRequest  = 20 // seconds
		configuration.timeoutIntervalForResource = 30
		self.alamoFireManager = Alamofire.SessionManager(configuration: configuration)
	}
	
	private func getRequest(address: String, completionHandler: @escaping (_ json: Any?, _ error: Bool) -> (Void)) {
		
		print("GET ", address)
		
		UIApplication.shared.isNetworkActivityIndicatorVisible = true
		
		self.alamoFireManager.request(address, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
			
			DispatchQueue.main.async() {
				UIApplication.shared.isNetworkActivityIndicatorVisible = false
			}
			
			switch response.result {
			case .success(let JSON):
				let response = JSON
				completionHandler(response, false)
			case .failure:
				completionHandler(nil, true)
			}
		}
	}
	
	func gamesList(_ completionHandler: @escaping (_ json: Any?, _ error: Bool?) -> Void) {
		
		let address = URLs.kGamesList
		
		self.getRequest(address: address) { (json, error) -> (Void) in
			completionHandler(json, error)
		}
	}
	
	func gameDetails(gameID: Int, _ completionHandler: @escaping (_ json: Any?, _ error: Bool?) -> Void) {
		
		let address = URLs.kGameDetails(gameID: gameID)
		
		self.getRequest(address: address) { (json, error) -> (Void) in
			completionHandler(json, error)
		}
	}
}

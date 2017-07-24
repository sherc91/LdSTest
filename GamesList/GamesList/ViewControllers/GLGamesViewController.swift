//
//  GLGamesViewController.swift
//  GamesList
//
//  Created by Leandro Sousa on 23/07/17.
//  Copyright © 2017 Leandro Sousa. All rights reserved.
//

import UIKit

class GLGamesViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	
	let gameModelKey = "gameModelKey"
	let reuseIdentifierGameCell  = "gameCell"
	
	var refreshControl: UIRefreshControl?
	
	var games: [GLGame] = []
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
		
		self.refreshControl = UIRefreshControl()
		self.refreshControl?.addTarget(self, action: #selector(refreshUpdate), for: UIControlEvents.valueChanged)
		self.tableView.addSubview(self.refreshControl!)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		if let data = UserDefaults.standard.object(forKey: self.gameModelKey) as? Data, let games = NSKeyedUnarchiver.unarchiveObject(with: data) as? [GLGame] {
			self.loadDataCompletion(games: games)
			self.refreshUpdate()
		}
		else {
			self.updateDataFromServer()
		}
	}
	
	func updateDataFromServer() {
		
		GLDataController.shared.gamesList { (status, games) in
			
			guard let games = games, status == .success else {
				let alert = UIAlertController(title: Strings.kError, message: Strings.kConnectionError, preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: Strings.kOK, style: .default, handler: nil))
				self.present(alert, animated: true, completion: nil)
				return
			}
			
			UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: games), forKey: self.gameModelKey)
			self.loadDataCompletion(games: games)
		}
	}
	
	func refreshUpdate() {
		
		GLDataController.shared.gamesList { (status, games) in
			
			guard let games = games, status == .success else {
				self.refreshControl?.endRefreshing()
				return
			}
			
			UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: games), forKey: self.gameModelKey)
			self.loadDataCompletion(games: games)
			self.refreshControl?.endRefreshing()
		}
	}
	
	func loadDataCompletion(games: [GLGame]) {
		self.games = games
		self.tableView.reloadData()
	}
	
	func presentGameDetailsView(game: GLGame) {
		let gameDetailsView = GLViewManager.gameDetailsViewController() as! GLGameDetailsViewController
		gameDetailsView.game = game
		self.navigationController?.pushViewController(gameDetailsView, animated: true)
	}
}

//
//  GLQRReaderViewController.swift
//  GamesList
//
//  Created by Leandro Sousa on 24/07/17.
//  Copyright © 2017 Leandro Sousa. All rights reserved.
//

import UIKit
import AVFoundation

class GLQRReaderViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
	
	var captureSession: AVCaptureSession?
	var videoPreviewLayer: AVCaptureVideoPreviewLayer?
	var qrCodeFrameView: UIView?
	
	let supportedCodeTypes = [AVMetadataObjectTypeQRCode]
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		UIApplication.shared.isIdleTimerDisabled = true
		
		let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
		
		do {
			let input = try AVCaptureDeviceInput(device: captureDevice)
			
			captureSession = AVCaptureSession()
			captureSession?.addInput(input)
			
			let captureMetadataOutput = AVCaptureMetadataOutput()
			captureSession?.addOutput(captureMetadataOutput)
			
			captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
			captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
			
			videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
			videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
			videoPreviewLayer?.frame = view.layer.bounds
			view.layer.addSublayer(videoPreviewLayer!)
			
			captureSession?.startRunning()
			
			qrCodeFrameView = UIView()
			
			if let qrCodeFrameView = qrCodeFrameView {
				qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
				qrCodeFrameView.layer.borderWidth = 2
				view.addSubview(qrCodeFrameView)
				view.bringSubview(toFront: qrCodeFrameView)
			}
		}
		catch {
			print(error)
			return
		}
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		UIApplication.shared.isIdleTimerDisabled = false
	}
	
	func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
		
		if metadataObjects == nil || metadataObjects.count == 0 {
			qrCodeFrameView?.frame = CGRect.zero
			return
		}
		
		guard let metadataObj = metadataObjects[0] as? AVMetadataMachineReadableCodeObject else {
			print("Error MetadataObj")
			return
		}
		
		if supportedCodeTypes.contains(metadataObj.type) {
			
			captureSession?.stopRunning()
			
			if let qrString = metadataObj.stringValue, let gameID = getGameID(qrString: qrString) {
				
				if let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj) {
					qrCodeFrameView?.frame = barCodeObject.bounds
				}
				
				getGame(gameID: gameID)
			}
			else {
				
				let alert = UIAlertController(title: Strings.kError, message: Strings.kInvalidQRCode, preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: Strings.kOK, style: .default) { _ in
					self.captureSession?.startRunning()
				})
				self.present(alert, animated: true, completion: nil)
				
				return
			}
		}
	}
	
	func getGameID(qrString: String) -> Int? {
		
		if qrString.range(of: URLs.kSchema) != nil {
			
			if let range = qrString.range(of: "(?<=://)[^.]+(?=)", options: .regularExpression) {
				
				let found = qrString.substring(with: range)
				if let gameID = Int(found) {
					return gameID
				}
			}
		}
		
		return nil
	}
	
	func getGame(gameID: Int) {
		
		GLDataController.shared.gameDetails(gameID: gameID) { (status, gameData) in
			
			if let game = gameData, status == .success {
				self.presentGameDetailsView(game: game)
			}
			else {
				let alert = UIAlertController(title: Strings.kError, message: Strings.kGameNotFound, preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: Strings.kOK, style: .default) { _ in
					self.captureSession?.startRunning()
					self.qrCodeFrameView?.frame = CGRect.zero
				})
				self.present(alert, animated: true, completion: nil)
			}
		}
	}
	
	func presentGameDetailsView(game: GLGame?) {
		let gameDetailsView = GLViewManager.gameDetailsViewController() as! GLGameDetailsViewController
		gameDetailsView.game = game
		self.navigationController?.pushViewController(gameDetailsView, animated: true)
	}
}

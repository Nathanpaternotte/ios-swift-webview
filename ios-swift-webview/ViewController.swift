//
//  ViewController.swift
//  ios-swift-webview
//
//  Created by Eric Fernberg on 2/22/15.
//
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

	@IBOutlet weak var webView: UIWebView!
	var webViewController: WKWebView?
	let tweaks = Tweaks()
	let defaultUrl = "http://192.168.1.102:8080/examples/"
	
	override func loadView() {
		super.loadView()
	
		var config = WKWebViewConfiguration()
		var preferences = WKPreferences()
	
		preferences.javaScriptCanOpenWindowsAutomatically = true
	
		config.preferences = preferences
	
		self.webViewController = WKWebView(
			frame: view.bounds,
			configuration: config
		)
	
		self.view = self.webViewController!
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
		self.webViewController!.navigationDelegate = self
	
		tweaks.tweakActionForCategory("Web View", collectionName: "AppUrl", name: "Url", defaultValue: "http://192.168.1.102:8080/examples/", action: { (currentValue) -> () in
			var updatedValue = currentValue as String
			var updatedUrl = NSURL(string: updatedValue)
			var updatedRequest = NSURLRequest(URL: updatedUrl!)
	
			self.webViewController!.loadRequest(updatedRequest)
		})
	
		//		let url = NSURL(string: "http://192.168.1.102:8080/examples/")
		let TweakUrl = Tweaks.tweakValueForCategoy("Web View", collectionName: "AppUrl", name: "Url", defaultValue: "http://192.168.1.102:8080/examples/")
		let url = NSURL(string: TweakUrl)
		let request = NSURLRequest(URL: url!)

		self.webViewController!.loadRequest(request)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func webView(webView: WKWebView!, didFinishNavigation navigation: WKNavigation!) {
		println("Finished load")
	}
	
	override func prefersStatusBarHidden() -> Bool {
		return true
	}

}

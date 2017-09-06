//
//  EDAlertController.swift
//  EDAlertController
//
//  Created by Eugene Kalyada on 06.09.17.
//  Copyright © 2017 Eugene Kalyada. All rights reserved.
//

import UIKit
import EDLocalizator

public enum AlertViewType : String {
	case warning = "warning"
	case error = "error"
	case info = "info"
}

public class AlertHelper {

	public static func alertWithTitle(_ title:String, message: String, controller:UIViewController, buttons:Array<String>?, completion:((UIAlertAction, UIViewController, Int) -> Void)?)->UIAlertController {
		let alert = UIAlertController(title: title.localized, message: message.localized, preferredStyle: .alert)
		if let aButtons = buttons {
			for (index, text) in aButtons.enumerated() {
				let action = UIAlertAction(title: text.localized, style: .default, handler: { (action:UIAlertAction) in
					if( completion != nil) {
						completion!(action, controller, index)
					}
				})
				alert.addAction(action)
			}
		}
		else {
			let action = UIAlertAction(title: "Button.ok".localized, style: .default, handler: { (action:UIAlertAction) in
				alert.dismiss(animated: true, completion: nil)
				if( completion != nil) {
					completion!(action, controller, 0)
				}
			})
			alert.addAction(action)
		}
		return alert
	}

}

extension UIViewController {
	public func alertWithType(type: AlertViewType, message: String){
		alertWithType(type: type, message: message, buttons: nil, completion: nil)
	}

	public  func alertWithType(type: AlertViewType, message: String, buttons:Array<String>?, completion:((UIAlertAction, UIViewController, Int) -> Void)?)  {
		alertWithTitle(alertTitleWithType(type: type), message: message, buttons: buttons, completion: completion)

	}

	public func alertWithTitle(_ title:String, message: String, buttons:Array<String>?, completion:((UIAlertAction, UIViewController, Int) -> Void)?) {
		let alert = AlertHelper.alertWithTitle(title, message: message, controller: self, buttons: buttons) { (action, controller, index) in
			if( completion != nil) {
				completion!(action, self, index)
			}
		}
		present(alert, animated: true, completion: nil)
	}

	public func alertWithError(_ error: Error) {
		alertWithType(type: .error, message: error.localizedDescription, buttons: nil, completion: nil)
	}

	public func alertTitleWithType(type: AlertViewType) -> String {
		return "Alert.Title.\(type.rawValue)"
	}
}

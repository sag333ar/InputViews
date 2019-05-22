//
//  ViewController.swift
//  Example
//
//  Created by sagar kothari on 22/05/19.
//  Copyright © 2019 Sagar R Kothari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet var datePicker: UITextField? {
		didSet {
			guard let datePicker = datePicker else { return }
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
	}

}

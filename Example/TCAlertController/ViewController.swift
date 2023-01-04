//
//  ViewController.swift
//  TCAlertController
//
//  Created by tancheng on 12/23/2022.
//  Copyright (c) 2022 tancheng. All rights reserved.
//

import UIKit
import TCAlertController

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        debugPrint("登录")
        
    }

    @objc func showAlert() {
        let alert = TCAlertController(
            contents: [
                TCAlertSpaceContent(height: 20),
                TCAlertTextContent(text: "Message1"),
                TCAlertSpaceContent(height: 12),
                TCAlertTextContent(text: "Message2"),
                TCAlertSpaceContent(height: 20),
            ],
            actions: [
                TCAlertCancelAction(title: "Cancel"),
                TCAlertConfirmAction(title: "OK")
            ])
        present(alert, animated: true)
    }
    @IBAction func tapAction(_ sender: UIButton) {
        showAlert() 
    }
    
}


//
//  ErrorAlertViewController.swift
//  Diff App
//
//  Created by Jacob Goldfarb on 2018-10-29.
//  Copyright © 2018 Jacob Goldfarb. All rights reserved.
//

import UIKit

class ErrorAlertViewController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let dismissAction = UIAlertAction(title: "Okay", style: .default) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        self.addAction(dismissAction)
    }
}

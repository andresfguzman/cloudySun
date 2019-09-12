//
//  CSBaseViewController.swift
//  CloudySun
//
//  Created by Andrés Guzmán on 9/11/19.
//  Copyright © 2019 Andres Felipe Guzman Lopez. All rights reserved.
//

import UIKit
import SVProgressHUD

class CSBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func showLoadingView() {
        SVProgressHUD.show(withStatus: "Loading...")
    }
    
    func hideLoadingView() {
        SVProgressHUD.dismiss()
    }
}

//
//  CreateAccountVC.swift
//  smack
//
//  Created by Azim Jiwani on 2020-04-02.
//  Copyright © 2020 Azim Jiwani. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func closePressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }
    

}

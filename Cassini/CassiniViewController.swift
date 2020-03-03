//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Emma Walker - TVandMobile Platforms - Core Engineering on 03/03/2020.
//  Copyright © 2020 Emma Walker - TVandMobile Platforms - Core Engineering. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if let url = DemoURLs.NASA[identifier]{
                var destination = segue.destination
                // this unwraps the nav controller and gets its visible vc
                // it will still work if there wasn't a nav con
                if let navcon = destination as? UINavigationController{
                    destination = navcon.visibleViewController ?? navcon
                }
                if let imageVC = destination as? ImageViewController {
                    imageVC.imageURL = url
                    imageVC.title = (sender as? UIButton)?.currentTitle
                }
            }
        }
    }

}

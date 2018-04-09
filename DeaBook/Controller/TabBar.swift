//
//  TabBar.swift
//  DeaBook
//
//  Created by Dea-loC on 09/04/2018.
//  Copyright © 2018 Dea-loC. All rights reserved.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .black
        tabBar.isTranslucent = true
        tabBar.barTintColor = BLEU_DEABOOK

    }


}

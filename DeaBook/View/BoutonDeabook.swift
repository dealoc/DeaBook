//
//  BoutonDeabook.swift
//  DeaBook
//
//  Created by Dea-loC on 09/04/2018.
//  Copyright © 2018 Dea-loC. All rights reserved.
//

import UIKit

class BoutonDeabook: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        miseEnPlace()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        miseEnPlace()
    }

    func miseEnPlace() {
        backgroundColor = UIColor.white
        tintColor = BLEU_DEABOOK
        layer.mep(10)
        
    }
    
    
}

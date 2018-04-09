//
//  ProfilController.swift
//  DeaBook
//
//  Created by Dea-loC on 09/04/2018.
//  Copyright © 2018 Dea-loC. All rights reserved.
//

import UIKit

class ProfilController: UIViewController {

    @IBOutlet weak var photoDeProfil: UIImageView!
    @IBOutlet weak var prenomLabel: UILabel!
    @IBOutlet weak var nomLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func modifierProfilAction(_ sender: Any) {
    }
    
    @IBAction func decoAction(_ sender: Any) {
        Alerte.montrer.deco(controller: self)
    }
    
    
    

}

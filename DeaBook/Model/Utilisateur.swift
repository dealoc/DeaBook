//
//  Utilisateur.swift
//  DeaBook
//
//  Created by Dea-loC on 09/04/2018.
//  Copyright © 2018 Dea-loC. All rights reserved.
//

import UIKit

class Utilisateur {
    
    private var _prenom: String
    private var _nom: String
    private var _imageUrl: String?
    
    var prenom: String {
        return _prenom
    }
    var nom: String {
        return _nom
    }
    var imageUrl: String? {
        return _imageUrl
    }
    
    init(prenom: String, nom: String, imageUrl: String?) {
        self._prenom = prenom
        self._nom = nom
        self._imageUrl = imageUrl
    }
    
}

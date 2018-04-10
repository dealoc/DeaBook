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
    private var _mail: String?
    private var _pays: String?
    private var _ville: String?
    private var _imageUrl: String?
    private var _id: String
    
    var id: String {
        return _id
    }
    
    var prenom: String {
        return _prenom
    }
    var nom: String {
        return _nom
    }
    var mail: String? {
        return _mail
    }
    var pays: String? {
        return _pays
    }
    var ville: String? {
        return _ville
    }
    var imageUrl: String? {
        return _imageUrl
    }
    
    init(id: String, prenom: String, nom: String, mail: String?, pays: String?, ville: String?, imageUrl: String?) {
        self._id = id
        self._prenom = prenom
        self._nom = nom
        self._mail = mail
        self._pays = pays
        self._ville = ville
        self._imageUrl = imageUrl
        }
    
    
    
}


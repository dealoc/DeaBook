//
//  Refs.swift
//  DeaBook
//
//  Created by Dea-loC on 09/04/2018.
//  Copyright © 2018 Dea-loC. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseStorage

class Refs {
    
    static let obtenir = Refs()
    
    let baseBDD = Database.database().reference()
    let baseStockage = Storage.storage().reference()
    
    var baseUtilisateur: DatabaseReference {
        return baseBDD.child(UTILISATEUR)
    }
    
    var basePhotoDeProfil: StorageReference {
        return baseStockage.child(UTILISATEUR)
    }
 
    var basePost: DatabaseReference {
        return baseBDD.child(POST)
    }
 
    var basePhotoDuPost: StorageReference {
        return baseStockage.child(POST)
    }
    
}

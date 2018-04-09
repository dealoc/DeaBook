//
//  ConnectionController.swift
//  DeaBook
//
//  Created by Dea-loC on 09/04/2018.
//  Copyright © 2018 Dea-loC. All rights reserved.
//

import UIKit
import FirebaseAuth

class ConnectionController: UIViewController {

    @IBOutlet weak var titreLabel: UILabel!
    @IBOutlet weak var mailTF: UITextField!
    @IBOutlet weak var mdpTF: UITextField!
    @IBOutlet weak var connexionBouton: BoutonDeabook!
    @IBOutlet weak var pasDeCompteLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(cacherClavier)))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cacher(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let id = Auth.auth().currentUser?.uid {
            //Vérfifier si utilisateur dans BDD
            //Passer à l'app
            
        } else {
            cacher(false)
        }
    }
    
    func completion(_ user: User?,_ error: Error?) {
        if let erreur = error {
            let nsErreur = erreur as NSError
            if nsErreur.code == 17011 {
                //Creer utilisateur
                Auth.auth().createUser(withEmail: mailTF.text!, password: mdpTF.text!, completion: completion(_:_:))
            } else {
                Alerte.montrer.erreur(message: nsErreur.convertirErreurFirebaseEnString(), controller: self)
            }
    }
        if let utilisateur = user {
            // Vérifier si l'utilisateur est dans la BDD
            Alerte.montrer.erreur(message: "Utilisateur créé dans auth", controller: self)
        }
    }
        
    func cacher(_ bool: Bool) {
        titreLabel.isHidden = bool
        mailTF.isHidden = bool
        mdpTF.isHidden = bool
        connexionBouton.isHidden = bool
        pasDeCompteLabel.isHidden = bool
    }
    
    @objc func cacherClavier() {
        view.endEditing(true)
    }

    @IBAction func seConnecterAction(_ sender: Any) {
        self.view.endEditing(true)
        if let adresse = mailTF.text, adresse != "" {
            if let mdp = mdpTF.text, mdp != "" {
                Auth.auth().signIn(withEmail: adresse, password: mdp, completion: completion(_:_:))
                
            } else {
                Alerte.montrer.erreur(message: MDP_VIDE, controller: self)
            }
        } else {
            Alerte.montrer.erreur(message: ADRESSE_VIDE, controller: self)
        }
    }
}



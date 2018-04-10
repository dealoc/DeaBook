//
//  ProfilController.swift
//  DeaBook
//
//  Created by Dea-loC on 09/04/2018.
//  Copyright © 2018 Dea-loC. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ProfilController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoDeProfil: ImageRonde!
    @IBOutlet weak var prenomLabel: UILabel!
    @IBOutlet weak var nomLabel: UILabel!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var paysLabel: UILabel!
    @IBOutlet weak var villeLabel: UILabel!
    
    var profil: Utilisateur?
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        obtenirProfil()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        photoDeProfil.isUserInteractionEnabled = true
        photoDeProfil.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(prendrePhoto)))
    }
    
    @objc func prendrePhoto() {
        Alerte.montrer.photo(imagePicker: imagePicker, controller: self)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var image: UIImage?
        if let editee = info[UIImagePickerControllerEditedImage] as? UIImage {
            image = editee
        } else if let originale = info[UIImagePickerControllerEditedImage] as? UIImage {
            image = originale
        }
        picker.dismiss(animated: true, completion: nil)
        guard image != nil, let data = UIImageJPEGRepresentation(image!, 0.2) else { return }
        guard let id = Auth.auth().currentUser?.uid else { return }
        let ref = Refs.obtenir.basePhotoDeProfil.child(id)
        ref.putData(data, metadata: nil) { (metadata, error) in
            if let urlString = metadata?.downloadURL()?.absoluteString {
                let userRef = Refs.obtenir.baseUtilisateur.child(id)
                userRef.updateChildValues([IMAGE_URL: urlString])
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func obtenirProfil() {
        guard let id = Auth.auth().currentUser?.uid else { return }
        let ref = Refs.obtenir.baseUtilisateur.child(id)
        ref.observe(.value) { (snapshot) in
            if let dict = snapshot.value as? [String: String], let prenom = dict[PRENOM], let nom = dict[NOM], let mail = dict[MAIL], let pays = dict[PAYS], let ville = dict[VILLE] {
                let nouvelUtilisateur = Utilisateur(id: snapshot.key, prenom: prenom, nom: nom, mail: mail, pays: pays, ville: ville, imageUrl: dict[IMAGE_URL])
                self.profil = nouvelUtilisateur
                self.miseAJourDonnees()
                
            } else if let dict = snapshot.value as? [String: String], let prenom = dict[PRENOM], let nom = dict[NOM], let mail = dict[MAIL], let pays = dict[PAYS] {
                let nouvelUtilisateur = Utilisateur(id: snapshot.key,prenom: prenom, nom: nom, mail: mail, pays: pays, ville: nil, imageUrl: dict[IMAGE_URL])
                self.profil = nouvelUtilisateur
                self.miseAJourDonnees()
            } else if let dict = snapshot.value as? [String: String], let prenom = dict[PRENOM], let nom = dict[NOM], let mail = dict[MAIL], let ville = dict[VILLE] {
                let nouvelUtilisateur = Utilisateur(id: snapshot.key,prenom: prenom, nom: nom, mail: mail, pays: nil, ville: ville, imageUrl: dict[IMAGE_URL])
                self.profil = nouvelUtilisateur
                self.miseAJourDonnees()
            } else if let dict = snapshot.value as? [String: String], let prenom = dict[PRENOM], let nom = dict[NOM], let ville = dict[VILLE], let pays = dict[PAYS] {
                let nouvelUtilisateur = Utilisateur(id: snapshot.key,prenom: prenom, nom: nom, mail: nil, pays: pays, ville: ville, imageUrl: dict[IMAGE_URL])
                self.profil = nouvelUtilisateur
                self.miseAJourDonnees()
            } else if let dict = snapshot.value as? [String: String], let prenom = dict[PRENOM], let nom = dict[NOM], let mail = dict[MAIL] {
                let nouvelUtilisateur = Utilisateur(id: snapshot.key,prenom: prenom, nom: nom, mail: mail, pays: nil, ville: nil, imageUrl: dict[IMAGE_URL])
                self.profil = nouvelUtilisateur
                self.miseAJourDonnees()
            } else if let dict = snapshot.value as? [String: String], let prenom = dict[PRENOM], let nom = dict[NOM], let pays = dict[PAYS] {
                let nouvelUtilisateur = Utilisateur(id: snapshot.key,prenom: prenom, nom: nom, mail: nil, pays: pays, ville: nil, imageUrl: dict[IMAGE_URL])
                self.profil = nouvelUtilisateur
                self.miseAJourDonnees()
            } else if let dict = snapshot.value as? [String: String], let prenom = dict[PRENOM], let nom = dict[NOM], let ville = dict[VILLE] {
                let nouvelUtilisateur = Utilisateur(id: snapshot.key,prenom: prenom, nom: nom, mail: nil, pays: nil, ville: ville, imageUrl: dict[IMAGE_URL])
                self.profil = nouvelUtilisateur
                self.miseAJourDonnees()
            } else if let dict = snapshot.value as? [String: String], let prenom = dict[PRENOM], let nom = dict[NOM] {
                let nouvelUtilisateur = Utilisateur(id: snapshot.key,prenom: prenom, nom: nom, mail: nil, pays: nil, ville: nil, imageUrl: dict[IMAGE_URL])
                self.profil = nouvelUtilisateur
                self.miseAJourDonnees()
            }
        }
        
    }
    
    func miseAJourDonnees() {
        if self.profil!.mail == nil, self.profil?.pays == nil, self.profil?.ville == nil {
            prenomLabel.text = "Prénom:  " + self.profil!.prenom
            nomLabel.text = "Nom:  " + self.profil!.nom
            photoDeProfil.telecharger(self.profil!.imageUrl)
        } else if self.profil?.pays == nil, self.profil?.ville == nil {
            prenomLabel.text = "Prénom:  " + self.profil!.prenom
            nomLabel.text = "Nom:  " + self.profil!.nom
            mailLabel?.text = "Mail:  " + self.profil!.mail!
            photoDeProfil.telecharger(self.profil!.imageUrl)
        } else if self.profil?.pays == nil, self.profil?.mail == nil {
            prenomLabel.text = "Prénom:  " + self.profil!.prenom
            nomLabel.text = "Nom:  " + self.profil!.nom
            villeLabel?.text = "Ville:  " + self.profil!.ville!
            photoDeProfil.telecharger(self.profil!.imageUrl)
        } else if self.profil?.ville == nil, self.profil?.mail == nil {
            prenomLabel.text = "Prénom:  " + self.profil!.prenom
            nomLabel.text = "Nom:  " + self.profil!.nom
            paysLabel?.text = "Pays:  " + self.profil!.pays!
            photoDeProfil.telecharger(self.profil!.imageUrl)
        } else if self.profil?.ville == nil {
            prenomLabel.text = "Prénom:  " + self.profil!.prenom
            nomLabel.text = "Nom:  " + self.profil!.nom
            mailLabel?.text = "Mail:  " + self.profil!.mail!
            paysLabel.text = "Pays:  " + self.profil!.pays!
            photoDeProfil.telecharger(self.profil!.imageUrl)
        } else if self.profil?.pays == nil {
            prenomLabel.text = "Prénom:  " + self.profil!.prenom
            nomLabel.text = "Nom:  " + self.profil!.nom
            mailLabel?.text = "Mail:  " + self.profil!.mail!
            villeLabel.text = "Ville:  " + self.profil!.ville!
            photoDeProfil.telecharger(self.profil!.imageUrl)
        } else if self.profil?.mail == nil {
            prenomLabel.text = "Prénom:  " + self.profil!.prenom
            nomLabel.text = "Nom:  " + self.profil!.nom
            villeLabel?.text = "Ville:  " + self.profil!.ville!
            paysLabel.text = "Pays:  " + self.profil!.pays!
            photoDeProfil.telecharger(self.profil!.imageUrl)
        } else {
            prenomLabel.text = "Prénom:  " + self.profil!.prenom
            nomLabel.text = "Nom:  " + self.profil!.nom
            mailLabel?.text = "Mail:  " + self.profil!.mail!
            paysLabel.text = "Pays:  " + self.profil!.pays!
            villeLabel.text = "Ville:  " + self.profil!.ville!
            photoDeProfil.telecharger(self.profil!.imageUrl)
        }
    }
    
    @IBAction func modifierProfilAction(_ sender: Any) {
        if let bouton = sender as? UIButton {
            var array = [String]()
            switch bouton.tag {
            case 0: array.append(PRENOM)
            case 1: array.append(NOM)
            case 2: array.append(MAIL)
            case 3: array.append(PAYS)
            case 4: array.append(VILLE)
            default: break
            }
            guard array.count == 1 else { return }
            Alerte.montrer.alerteTF(titre: MODIFIER, message: array[0], array: array, controller: self, completion: nil)
        }
    }
    
    @IBAction func decoAction(_ sender: Any) {
        Alerte.montrer.deco(controller: self)
    }
    
    
    

}

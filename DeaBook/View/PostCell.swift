//
//  PostCell.swift
//  DeaBook
//
//  Created by Dea-loC on 10/04/2018.
//  Copyright © 2018 Dea-loC. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {


    @IBOutlet weak var photoDeProfil: ImageRonde!
    @IBOutlet weak var nomEtPrenom: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var imageDuPost: UIImageView!
    @IBOutlet weak var texteDuPost: UILabel!
    @IBOutlet weak var boutonLike: UIButton!
    @IBOutlet weak var nombreDeLike: UILabel!
    
    var post: Post!
    
    func miseEnPlace(post: Post) {
        self.post = post
        photoDeProfil.telecharger(self.post.utilisateur.imageUrl)
        nomEtPrenom.text = self.post.utilisateur.prenom + "  " + self.post.utilisateur.nom
        imageDuPost.telecharger(self.post.imageUrl)
        texteDuPost.text = self.post.texte
        if self.post.imageUrl == nil {
            imageDuPost.isHidden = true
        } else {
            imageDuPost.isHidden = false
        }
    }
    
    @IBAction func likeAppuyer(_ sender: Any) {
    }
}

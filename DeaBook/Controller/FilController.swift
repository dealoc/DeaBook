//
//  FilController.swift
//  DeaBook
//
//  Created by Dea-loC on 09/04/2018.
//  Copyright © 2018 Dea-loC. All rights reserved.
//

import UIKit

class FilController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        oberserPosts()
    }
    
    func oberserPosts() {
        let ref = Refs.obtenir.basePost
        ref.observe(.childAdded) { (snapshot) in
            if let postDict = snapshot.value as? [String: AnyObject] {
                if let userId = postDict[USER_ID] as? String {
                    Refs.obtenir.baseUtilisateur.child(userId).observe(.value, with: { (userSnap) in
                        if let userDict = userSnap.value as? [String: String], let prenom = userDict[PRENOM], let nom = userDict[NOM] {
                            let utilisateur = Utilisateur(id: userSnap.key, prenom: prenom, nom: nom, mail: nil, pays: nil, ville: nil, imageUrl: userDict[IMAGE_URL])
                            if let date = postDict[DATE_POST] as? Double, let texte = postDict[TEXTE] as? String{
                                let nouveauPost = Post(id: snapshot.key, date: date, texte: texte, imageUrl: postDict[IMAGE_URL] as? String, utilisateur: utilisateur)
                                self.posts.append(nouveauPost)
                                self.tableView.reloadData()
                            }
                        }
                    })
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID) as? PostCell {
            let post = posts[indexPath.row]
            var hauteur: CGFloat = 150
            if post.imageUrl != nil {
                hauteur += cell.imageDuPost.frame.width
            }
            let taille = CGSize(width: cell.texteDuPost.frame.width, height: .greatestFiniteMagnitude)
            let option =  NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let nsString = NSString(string: post.texte)
            let hauteurDuTexte = nsString.boundingRect(with: taille, options: option, attributes: [.font: UIFont.systemFont(ofSize: 17)], context: nil).height
            hauteur += hauteurDuTexte
            return hauteur
        }
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID) as? PostCell {
            cell.miseEnPlace(post: posts[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    

}

//
//  HeroViewController.swift
//  RickAndMorty
//
//  Created by viktor on 20.04.2022.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

class HeroViewController: UIViewController {
    @IBOutlet weak var ImageVIew: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var AttributeLabel: UILabel!
    @IBOutlet weak var AttackLabel: UILabel!
    @IBOutlet weak var LegsLabel: UILabel!
    
    var hero: HeroStats?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NameLabel.text = hero?.localized_name
        AttributeLabel.text = hero?.primary_attr
        AttackLabel.text = hero?.attack_type
        LegsLabel.text = "(\(hero?.legs)!)"

        let urlString = "https://api.opendota.com" + (hero?.img)!
        let url = URL(string: urlString)
        
        ImageVIew.downloaded(from: url!)
    }
    
}

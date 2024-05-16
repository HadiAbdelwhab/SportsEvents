//
//  SportsCollectionViewCell.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    func setupCell() {
        backgroundColor = UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0)
            layer.cornerRadius = 10
            layer.borderWidth = 1.0
            layer.borderColor = UIColor.black.cgColor
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 0.4
            layer.masksToBounds = false
        }
    
    func bind(sport: Sport) {
        ivImage.image = UIImage(named: sport.thumb)
        ivImage.layer.cornerRadius = ivImage.bounds.width/10
        ivImage.layer.borderWidth = 1.0
        ivImage.layer.borderColor = UIColor.black.cgColor
        lName.text = sport.title
    }
}

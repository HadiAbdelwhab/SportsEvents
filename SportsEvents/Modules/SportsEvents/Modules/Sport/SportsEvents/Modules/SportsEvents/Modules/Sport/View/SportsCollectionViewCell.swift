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
    }
    
    func bind(sport: Sport) {
        ivImage.image = UIImage(named: sport.thumb)
        ivImage.layer.cornerRadius = ivImage.bounds.width/2
        lName.text = sport.title
    }
}

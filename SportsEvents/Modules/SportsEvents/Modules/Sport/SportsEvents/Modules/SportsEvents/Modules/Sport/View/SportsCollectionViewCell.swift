//
//  SportsCollectionViewCell.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var tvName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func bindSport(sport: Sport) {
        ivImage.image = UIImage(named: sport.thumb)
        tvName.text = sport.title
    }
}

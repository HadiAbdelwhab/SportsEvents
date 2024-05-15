//
//  LeagueTableViewCell.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import UIKit
import Kingfisher
class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var ivImage: UIImageView!
    @IBOutlet weak var lName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindLeague(league: League) {
        if let logoURL = league.leagueLogo, !logoURL.isEmpty, let url = URL(string: logoURL) {
            ivImage.kf.setImage(with: url)
        } else {
            ivImage.image = UIImage(named: "league")
        }
        ivImage.layer.cornerRadius = ivImage.bounds.width/2
        lName.text = league.leagueName
    }
}

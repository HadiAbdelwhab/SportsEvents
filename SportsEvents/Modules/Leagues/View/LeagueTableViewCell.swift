//
//  LeagueTableViewCell.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import UIKit

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
        //use league.leagueLogo to display League Icon in ivImage.image
        ivImage.image = UIImage(named: "tennis")
        lName.text = league.leagueName
    }
}

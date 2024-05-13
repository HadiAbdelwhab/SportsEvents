//
//  ViewController.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini13 on 13/05/2024.
//

import UIKit

class SportsViewController: UIViewController {

    var viewModel = SportsViewModel()
    
    @IBOutlet weak var cvSports: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onSportClicked = { [weak self] sport in
            self?.handleSportClicked(for: sport)
        }
                
        viewModel.onSportsFetched = { [weak self] in
            self?.updateCollectionView()
        }
        
        let nib = UINib(nibName: "cSport", bundle: nil)
        cvSports.register(nib, forCellWithReuseIdentifier: "cSport")
    }
    
    func updateCollectionView() {
        cvSports.reloadData()
    }
    
    func handleSportClicked(for sport: Sport) {
        // Go To League Screen
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataSource.getSports().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cSport", for: indexPath) as! SportsCollectionViewCell

        cell.bindSport(sport: viewModel.dataSource.getSports()[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sport = viewModel.dataSource.getSports()[indexPath.row]
        viewModel.handleSportClicked(for: sport)
    }
}


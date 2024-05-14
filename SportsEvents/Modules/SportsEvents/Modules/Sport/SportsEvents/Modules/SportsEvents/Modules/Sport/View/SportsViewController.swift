//
//  ViewController.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini13 on 13/05/2024.
//

import UIKit
import Reachability

class SportsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var viewModel = SportsViewModel()
    var reachability: Reachability!
    
    @IBOutlet weak var cvSports: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupReachability()
        
        viewModel.fetchSports()
        
        viewModel.onSportClicked = { [weak self] sport in
            self?.handleSportClicked(for: sport)
        }
        
        viewModel.onSportsFetched = { [weak self] in
            self?.updateCollectionView()
        }
        let nib = UINib(nibName: "SportsCollectionViewCell", bundle: nil)
        cvSports.register(nib, forCellWithReuseIdentifier: "cSport")
    }
    
    func setupReachability() {
        do {
            reachability = try Reachability()
            try reachability.startNotifier()
        } catch {
            print("Unable to start reachability notifier")
        }
    }
    
    func updateCollectionView() {
        cvSports.reloadData()
    }
    
    func handleSportClicked(for sport: Sport) {
        
        if let leaguesVC = storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController") as? LeaguesViewController {
            leaguesVC.selectedSportTitle = sport.title
            leaguesVC.isFavourite = false
            navigationController?.pushViewController(leaguesVC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.dataSource.getSports().count)
        return viewModel.dataSource.getSports().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cSport", for: indexPath) as! SportsCollectionViewCell

        cell.bind(sport: viewModel.dataSource.getSports()[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard reachability.connection != .unavailable else {
            showAlert(title: "No Internet Connection", message: "Please check your internet connection and try again.")
            return
        }
        let sport = viewModel.dataSource.getSports()[indexPath.row]
        viewModel.handleSportClicked(for: sport)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


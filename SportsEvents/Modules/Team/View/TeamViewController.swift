//
//  TeamViewController.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import UIKit
import Reachability

class TeamViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var selectedTeamId: String?
    var selectedSportTitle: String?
    
    var teamsViewModel: TeamViewModel!
    var activityIndicator: UIActivityIndicatorView!
    var reachability: Reachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModel()
        setupActivityIndicator()
        setupReachability()
        
        getTeamDetails()
    }
    
    
    func setUpCollectionView(){
        
    }
    
    func setupViewModel() {
        teamsViewModel = SportsDependencyProvider.provideTeamViewModel()
    }
    
    func setupReachability() {
        do {
            reachability = try Reachability()
            try reachability.startNotifier()
        } catch {
            print("Unable to start reachability notifier")
        }
    }
    
    private func getTeamDetails() {
        guard reachability.connection != .unavailable else {
            showAlert(title: "No Internet Connection", message: "Please check your internet connection and try again.")
            return
        }
        
        startLoading()
        if let teamId = selectedTeamId {
            if let selectedSportTitle = selectedSportTitle {
                teamsViewModel.fetchTeamDetails(sportTitle: selectedSportTitle, teamId: teamId) {
                    DispatchQueue.main.async {
                        self.stopLoading()
                    }
                }
            }
        }
    }

    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}


func drawTeamInfoSection() -> NSCollectionLayoutSection{
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    
    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
    let section = NSCollectionLayoutSection(group: group)
    section.orthogonalScrollingBehavior = .continuous
    section.contentInsets = NSDirectionalEdgeInsets(top: 100, leading: 16, bottom: 16, trailing: 0)
    
    section.visibleItemsInvalidationHandler = { (items, offset, environment) in
        items.forEach { item in
            
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
    }
    
    return section
}


/*extension TeamViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
    
    
}*/

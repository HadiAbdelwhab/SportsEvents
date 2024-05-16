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
    var selectedTeamId: Int?
    var selectedSportTitle: String?
    
    var teamsViewModel: TeamViewModel!
    var activityIndicator: UIActivityIndicatorView!
    var reachability: Reachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // collectionView.register(PlayerCollectionViewCell.self, forCellWithReuseIdentifier: "playerscell")
        //collectionView.register(TeamCollectionViewCell.self, forCellWithReuseIdentifier: "teamcell")
        setupViewModel()
        setupActivityIndicator()
        setupReachability()
        
        getTeamDetails()
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
                teamsViewModel.fetchTeamDetails(sportTitle: selectedSportTitle, teamId: selectedTeamId!) {
                    DispatchQueue.main.async {
                        print("Team Details \(self.teamsViewModel.getTeams()?.count)")
                        self.stopLoading()
                        self.setUpCollectionView()
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
 
    
    
    func drawPlayersSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 16, bottom: 16, trailing: 16)
        
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
    
    func setUpCollectionView() {
        let layout = UICollectionViewCompositionalLayout { index, environment in
            if index == 0 {
                return self.drawTeamInfoSection()
          }else{
                return self.drawPlayersSection()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    

}


extension TeamViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
       
            return teamsViewModel.getTeams()?.count ?? 0
        } else {
            print(teamsViewModel.getTeams()?[0].players.count ?? 0)
            return teamsViewModel.getTeams()?[0].players.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamcell", for: indexPath) as! TeamCollectionViewCell
            
            let item = teamsViewModel.getTeams()![0]
            print("Team name \(item.team_name)")
            cell.config(teamLogo: item.team_logo, teamName: item.team_name, teamCoach: "Coach", teamCaptain: "Captain")
           
            return cell
        }else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playercell", for: indexPath) as! PlayerCollectionViewCell
            
            let item = teamsViewModel.getTeams()?[0].players[indexPath.row]
                
            print("logo \(item?.player_image)")
            
            
           cell.configure(playerImage: (item?.player_image) ?? "", playerName: (item?.player_name) ?? "", playerNumber: (item?.player_number) ?? "", playerRate: "rate", playerAge: (item?.player_age) ?? "")
            
            return cell
            
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
}

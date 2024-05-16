//
//  LeagueDetailsViewController.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini13 on 13/05/2024.
//

import UIKit
import Reachability

class LeagueDetailsViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    var activityIndicator: UIActivityIndicatorView!
    var leagueId:Int?
    var selectedSportTitle:String?
    var currentLeague:League?
    var leagueDetailsViewModel : LeagueDetailsViewModel!
    var reachability: Reachability!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModel()
        setupActivityIndicator()
        getLeagueDetails(leagueId: leagueId ?? 0,selectedSportTitle: selectedSportTitle ?? "")
        setupReachability()
    }
    
    
    func setupReachability() {
        do {
            reachability = try Reachability()
            try reachability.startNotifier()
        } catch {
            print("Unable to start reachability notifier")
        }
    }
    
    func getLeagueDetails(leagueId: Int, selectedSportTitle: String) {
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        leagueDetailsViewModel.fetchUpcomingEvents(for: selectedSportTitle, leagueId: leagueId) {
            self.startLoading()
            DispatchQueue.main.async { [self] in
                
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        leagueDetailsViewModel.fetchLatestResults(for: selectedSportTitle, leagueId: leagueId) {
            DispatchQueue.main.async {
                
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.enter()
        leagueDetailsViewModel.fetchAllTeams(for: leagueId) {
            DispatchQueue.main.async {
                
                print("Teams \(self.leagueDetailsViewModel.getAllTeams()?.result.count)")
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.stopLoading()
            self.setUpCollectionView()
        }
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func addToFavourite(_ sender: Any) {
        leagueDetailsViewModel.addLeagueToFavourite(leguea: currentLeague!)
        
    }
    func drawUpcomingEventsSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 16, bottom: 16, trailing: 0)
        
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
    
    
    func drawLatestResultsSection() -> NSCollectionLayoutSection {
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

    func drawTeamsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 32)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 16, bottom: 16, trailing: 0)
        
       
        
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
                return self.drawUpcomingEventsSection()
            } else if index == 1 {
                return self.drawLatestResultsSection()
            }else{
                return self.drawTeamsSection()
            }
        }
        collectionView.setCollectionViewLayout(layout, animated: true)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupViewModel() {
        
        leagueDetailsViewModel = SportsDependencyProvider.provideLeagueDetailsViewModel()
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


    

extension LeagueDetailsViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return leagueDetailsViewModel.getUpcomingEvents()?.result.count ?? 0
        } else if section == 1{
            return leagueDetailsViewModel.getLatestResults()?.result.count ?? 0
        }else{
            return leagueDetailsViewModel.getAllTeams()?.result.count ?? 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if reachability.connection != .unavailable {
            if indexPath.section != 0 && indexPath.section != 1{
                
                let teamViewController = storyboard?.instantiateViewController(withIdentifier: "team") as? TeamViewController
                teamViewController!.selectedSportTitle = self.selectedSportTitle!
                
                teamViewController?.selectedTeamId = leagueDetailsViewModel.getAllTeams()?.result[indexPath.row].team_key
                
                present(teamViewController!,animated: true)
            }
            
            }else {
            showAlert(title: "No Internet Connection", message: "Please check your internet connection and try again.")
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! UpComingEventsCollectionViewCell
            
            let item = leagueDetailsViewModel.getUpcomingEvents()?.result[indexPath.row]
            cell.configure(homeTeam: item?.event_home_team ?? "home", awayTeam: item!.event_away_team ?? "away", homeLogo: item!.home_team_logo ?? "", awayLogo: item!.away_team_logo ?? "", eventDate: item?.event_date ?? "date")
            
            return cell
        } else if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! LatestResultsCollectionViewCell
            
            let item = leagueDetailsViewModel.getLatestResults()?.result[indexPath.row]
  
            cell.configure(homeTeam: item?.event_home_team ?? "home", awayTeam: item!.event_away_team ?? "away", homeLogo: item!.home_team_logo ?? "", awayLogo: item!.away_team_logo ?? "", eventResult: item?.event_final_result ?? "0 - 0", eventDate: item?.event_date ?? "")
            
            return cell
        }else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell3", for: indexPath) as! TeamsCollectionViewCell
            
            let item = leagueDetailsViewModel.getAllTeams()?.result[indexPath.row]
  
            cell.config(teamTitle: item?.team_name ?? "", teamImage: item?.team_logo ?? "")
            
            return cell
            
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    
    
}

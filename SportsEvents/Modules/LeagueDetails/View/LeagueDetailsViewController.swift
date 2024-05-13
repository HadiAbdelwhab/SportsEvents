//
//  LeagueDetailsViewController.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini13 on 13/05/2024.
//

import UIKit

class LeagueDetailsViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    var activityIndicator: UIActivityIndicatorView!

    
    var leagueDetailsViewModel : LeagueDetailsViewModel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModel()
        setupActivityIndicator()
        getLeagueDetails()
       
    }
    
    
    func getLeagueDetails(){
       
        
        leagueDetailsViewModel.fetchUpcomingEvents(for: "football", leagueId: 205){
            
            DispatchQueue.main.async{ [self] in
                
                setUpCollectionView()

                print("response  details \(leagueDetailsViewModel.getUpcomingEvents()?.success)")
            }
            
        }
        
        leagueDetailsViewModel.fetchLatestResults(for: 205){
        
            DispatchQueue.main.async {
                
                print("lateast result \(self.leagueDetailsViewModel.getUpcomingEvents()?.success)")
            }
        }
        
        leagueDetailsViewModel.fetchAllTeams(for: 205){_,_ in 
            
            DispatchQueue.main.async {
                print("lateast result \(self.leagueDetailsViewModel.getAllTeams()?.success)")
            }
        }
        
    }
    
    func setUpCollectionView(){
        
        /*let layout  = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 60)
        collectionView.collectionViewLayout = layout*/
        
        collectionView.register(UpComingEventsCollectionViewCell.nib(), forCellWithReuseIdentifier: "UpComingEventsCollectionViewCell")
        
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
        
    
}


    

extension LeagueDetailsViewController : UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Item selected")
    }
    
    
    
}


extension LeagueDetailsViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       print("Count \(leagueDetailsViewModel.getUpcomingEvents()?.result.count)")
        return leagueDetailsViewModel.getUpcomingEvents()?.result.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpComingEventsCollectionViewCell", for: indexPath) as! UpComingEventsCollectionViewCell
        
        
        let item = leagueDetailsViewModel.getUpcomingEvents()?.result[indexPath.row]
        
        cell.configure(homeTeam: item?.event_home_team ?? "home", awayTeam: item!.event_away_team ?? "away", homeLogo: item!.home_team_logo ?? "", awayLogo: item!.away_team_logo ?? "", eventDate: item!.event_date ?? "")
        
        
        
        return cell
    }
    
}
/*extension LeagueDetailsViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 60)
    }
}*/

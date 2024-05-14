//
//  LeaguesViewController.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import UIKit
import Reachability

class LeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var selectedSportTitle: String?
    var isFavourite: Bool = true
    
    var leagueViewModel : LeaguesViewModel!
    var activityIndicator: UIActivityIndicatorView!
    var reachability: Reachability!

    @IBOutlet weak var tvLeagues: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupActivityIndicator()
        
        setupReachability()
        getLeagues()
        let nib = UINib(nibName: "LeagueTableViewCell", bundle: nil)
        tvLeagues.register(nib, forCellReuseIdentifier: "cLeague")
    }
    
    func setupViewModel() {
        leagueViewModel = SportsDependencyProvider.provideLeaguesViewModel()
    }
    
    func setupReachability() {
        do {
            reachability = try Reachability()
            try reachability.startNotifier()
        } catch {
            print("Unable to start reachability notifier")
        }
    }
    
    private func getLeagues() {
        startLoading()
        if(isFavourite) {
            leagueViewModel.fetchFavoriteLeagues {
                DispatchQueue.main.async {
                    print("get Favourite Successfully to ViewController And Here It is:\(String(describing: self.leagueViewModel.getLeagues()))")
                    self.stopLoading()
                    self.tvLeagues.reloadData()
                }
            }
        } else {
            if reachability.connection != .unavailable {
                if let sportTitle = selectedSportTitle {
                    leagueViewModel.fetchLeagues(for: sportTitle) {
                        DispatchQueue.main.async {
                            self.stopLoading()
                            self.tvLeagues.reloadData()
                        }
                    }
                }
            } else {
                showAlert(title: "No Internet Connection", message: "Please check your internet connection and try again.")
                stopLoading()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagueViewModel.getLeagues()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cLeague", for: indexPath) as! LeagueTableViewCell
        if let league = leagueViewModel.getLeagues()?[indexPath.row] {
            cell.bindLeague(league: league)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
       
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if reachability.connection != .unavailable {
            if let leaguesVC = storyboard?.instantiateViewController(withIdentifier: "details") as? LeagueDetailsViewController {
                navigationController?.pushViewController(leaguesVC, animated: true)
            }
        } else {
            showAlert(title: "No Internet Connection", message: "Please check your internet connection and try again.")
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

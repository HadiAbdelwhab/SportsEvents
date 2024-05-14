//
//  TeamViewController.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import UIKit
import Reachability

class TeamViewController: UIViewController {

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

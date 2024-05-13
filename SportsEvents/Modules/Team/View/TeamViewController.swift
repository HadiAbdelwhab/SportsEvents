//
//  TeamViewController.swift
//  SportsEvents
//
//  Created by JETSMobileLabMini14 on 13/05/2024.
//

import UIKit

class TeamViewController: UIViewController {

    var selectedTeamId: String?
    var selectedSportTitle: String?
    
    var teamsViewModel: TeamViewModel!
    var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewModel()
        setupActivityIndicator()
        getTeamDetails()
    }
    
    func setupViewModel() {
        teamsViewModel = SportsDependencyProvider.provideTeamViewModel()
    }
    
    private func getTeamDetails() {
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
}

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
        
        if isFavourite {
            leagueViewModel.fetchFavoriteLeagues { [weak self] in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    
                    self.stopLoading()
                    if let leagues = self.leagueViewModel.getLeagues(), !leagues.isEmpty {
                        self.tvLeagues.reloadData()
                    } else {
                        self.showNoLeaguesMessage()
                    }
                }
            }
        } else {
            if reachability.connection != .unavailable {
                if let sportTitle = selectedSportTitle {
                    leagueViewModel.fetchLeagues(for: sportTitle) { [weak self] in
                        DispatchQueue.main.async {
                            guard let self = self else { return }
                            
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

    private func showNoLeaguesMessage() {
        tvLeagues.isHidden = true
        
        let imgErrorPhoto = UIImageView(frame: CGRect(x: 50, y: 100, width: view.frame.width - 100, height: 200))
        imgErrorPhoto.image = UIImage(systemName: "icloud.slash")
        imgErrorPhoto.tintColor = .darkGray
        view.addSubview(imgErrorPhoto)
        
        let lblMsg = UILabel(frame: CGRect(x: imgErrorPhoto.frame.minX, y: imgErrorPhoto.frame.maxY + 15, width: imgErrorPhoto.frame.width, height: 30))
        lblMsg.text = "No Favourite Leagues To Display"
        lblMsg.textAlignment = .center
        view.addSubview(lblMsg)
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
            let leagues = leagueViewModel.getLeagues()
            if let leaguesVC = storyboard?.instantiateViewController(withIdentifier: "details") as? LeagueDetailsViewController {
                let selectedLeague = leagues?[indexPath.row]
                leaguesVC.selectedSportTitle = selectedSportTitle
                leaguesVC.leagueId = selectedLeague?.leagueKey
                leaguesVC.modalPresentationStyle = .fullScreen
                present(leaguesVC, animated: true)
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
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return isFavourite
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if isFavourite {
            if editingStyle == .delete {
                let alertController = UIAlertController(title: "Remove League", message: "Are you sure you want to remove this league?", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                
                let removeAction = UIAlertAction(title: "Remove", style: .destructive) { _ in
                    if let league = self.leagueViewModel.getLeagues()?[indexPath.row] {
                        self.leagueViewModel.removeLeague(league.leagueKey)
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                    }
                }
                
                alertController.addAction(cancelAction)
                alertController.addAction(removeAction)
                
                present(alertController, animated: true, completion: nil)
            }
        }
    }
}

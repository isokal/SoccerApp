//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Iwo Sokal on 07/07/2021.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var soccerPlayers: [SoccerPlayer] = []
    @IBOutlet weak var myBackgroundImageView: UIImageView!
    @IBOutlet weak var soccerTableView: UITableView!
    var cellClicked: Int = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.soccerPlayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SoccerTableViewCell {
            cell.playerNameLabel.text = soccerPlayers[indexPath.row].fullName
            cell.playerImageView.image = soccerPlayers[indexPath.row].image
            if let imageName = soccerPlayers[indexPath.row].imageName {
                cell.playerImageView.image = UIImage(named: imageName)
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellClicked = indexPath.row
        self.performSegue(withIdentifier: "CellSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        soccerTableView.dataSource = self
        soccerTableView.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(onDidAddPlayer(_:)), name: Notification.Name("didAddPlayer"), object: nil)
    }
    
    @IBAction func addPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "AddButtonSegue", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is SecondViewController,
           segue.identifier == "CellSegue" {
            let vc = segue.destination as? SecondViewController
            vc?.player = soccerPlayers[cellClicked]
        }
    }
    
    @objc func onDidAddPlayer(_ notification: Notification) {
        if (soccerPlayers.count >= 3) {
            let alert = UIAlertController(title: "Limit reached", message: "Can't add 12th player", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true)
        }
        else if let player = notification.userInfo?["player"] as? SoccerPlayer {
            soccerPlayers.append(player)
            soccerTableView.reloadData()
        }
    }
}


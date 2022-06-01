//
//  SettingsTableViewController.swift
//  testFireApp
//
//  Created by Глеб Писарев on 29.04.2022.
//

import UIKit
import FirebaseAuth


class SettingsTableViewController: UITableViewController {
    
    
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        title = (tabBarController as! BarViewController).user?.username
//        emailLabel.text = (tabBarController as! BarViewController).user?.email
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let identifire = tableView.cellForRow(at: indexPath)?.reuseIdentifier else { return }
        switch identifire {
        case "ExitCell":
            print("\(indexPath.row)\t\(indexPath.section)\t\(identifire)")
            let fireAuth = Auth.auth()
            do {
                try fireAuth.signOut()
            }
            catch let error as NSError {
                print("Ошибка - ", error)
            }
            self.dismiss(animated: true, completion: nil)
        default:
            return
        }
    }
    
    
}

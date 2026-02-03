//
//  TodayScreenViewController.swift
//  Project_Login_Screen
//
//  Created by GEU on 02/02/26.
//

import UIKit

class TodayScreenViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    var firstName: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.text = "Welcome \(firstName)"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

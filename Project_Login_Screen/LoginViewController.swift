//
//  ViewController.swift
//  Project_Login_Screen
//
//  Created by GEU on 28/01/26.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var eyeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Attach to text field
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always
   
        passwordTextField.isSecureTextEntry = true
        eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
    }

    @IBAction func togglePassword(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()

        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
    }
}


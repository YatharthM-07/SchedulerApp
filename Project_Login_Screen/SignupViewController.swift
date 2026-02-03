//
//  SignupViewController.swift
//  Project_Login_Screen
//
//  Created by GEU on 28/01/26.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var passwordEyeBtn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordEyeBtn: UIButton!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var termsNconditions: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTermsNConditions()
        passwordTextField.isSecureTextEntry = true
            confirmPasswordTextField.isSecureTextEntry = true

            passwordEyeBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            confirmPasswordEyeBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
    }
    
    //setting up hyperlink for Terms & Conditions
    func setupTermsNConditions() {
        let text = "I agree to the Terms & Conditions"
        let attributedString = NSMutableAttributedString(string: text)

        let linkRange = (text as NSString).range(of: "Terms & Conditions")
        attributedString.addAttribute(.link,
                                      value: "https://www.youtube.com",
                                      range: linkRange)

        termsNconditions.attributedText = attributedString
        termsNconditions.textAlignment = .center
        termsNconditions.isEditable = false
        termsNconditions.isScrollEnabled = false
        termsNconditions.backgroundColor = .clear
    }
    
    
    @IBAction func backBtnTapped(_sender: UIButton){
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func togglePassword1(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
    }
   
    @IBAction func togglePassword2(_ sender: UIButton) {
        confirmPasswordTextField.isSecureTextEntry.toggle()
        
        let imageName = confirmPasswordTextField.isSecureTextEntry ? "eye.slash" : "eye"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
        
    }
}

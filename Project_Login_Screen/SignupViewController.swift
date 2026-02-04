//
//  SignupViewController.swift
//  Project_Login_Screen
//
//  Created by GEU on 28/01/26.
//

import UIKit

class SignupViewController: UIViewController {
    
    var extractedFirstName: String = ""

    @IBOutlet weak var passwordEyeBtn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordEyeBtn: UIButton!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var termsNconditions: UITextView!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var createAccountButton: UIButton!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            setupTermsNConditions()
            setupPasswordFields()
        navigationController?.setNavigationBarHidden(false, animated: false)
        }
    
    //setting up hyperlink for Terms & Conditions
    private func setupPasswordFields() {
            passwordTextField.isSecureTextEntry = true
            confirmPasswordTextField.isSecureTextEntry = true

            passwordEyeBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            confirmPasswordEyeBtn.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }

        // MARK: - Terms & Conditions

        private func setupTermsNConditions() {
            let text = "I agree to the Terms & Conditions"
            let attributedString = NSMutableAttributedString(string: text)

            let linkRange = (text as NSString).range(of: "Terms & Conditions")
            attributedString.addAttribute(
                .link,
                value: "https://www.youtube.com",
                range: linkRange
            )

            termsNconditions.attributedText = attributedString
            termsNconditions.textAlignment = .center
            termsNconditions.isEditable = false
            termsNconditions.isScrollEnabled = false
            termsNconditions.backgroundColor = .clear
        }
    
    
    @IBAction func backBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func togglePassword1(_ sender: UIButton) {
        
        toggleSecureEntry(
                   textField: passwordTextField,
                   button: sender
               )
    }
   
    @IBAction func togglePassword2(_ sender: UIButton) {
        toggleSecureEntry(
                textField: confirmPasswordTextField,
                button: sender
            )
    }
    private func toggleSecureEntry(textField: UITextField, button: UIButton) {
           let wasSecure = textField.isSecureTextEntry

           // UIKit-safe toggle
           textField.resignFirstResponder()
           textField.isSecureTextEntry = !wasSecure
           textField.becomeFirstResponder()

           let imageName = textField.isSecureTextEntry ? "eye.slash" : "eye"
           button.setImage(UIImage(systemName: imageName), for: .normal)
       }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "signupToWelcome",
//               let vc = segue.destination as? TodayScreenViewController {
//                vc.firstName = extractedFirstName
//        }
//    }
    
    @IBAction func textFieldsDidChange(_ sender: UITextField) {
        let isFormValid =
            !(fullNameTextField.text?.isEmpty ?? true) &&
            !(emailTextField.text?.isEmpty ?? true) &&
            !(passwordTextField.text?.isEmpty ?? true) &&
            !(confirmPasswordTextField.text?.isEmpty ?? true) &&
            passwordTextField.text == confirmPasswordTextField.text

        createAccountButton.isEnabled = isFormValid
    }

    
    @IBAction func createAccountTapped(_ sender: Any) {

            guard
                let fullName = fullNameTextField.text, !fullName.isEmpty,
                let email = emailTextField.text, !email.isEmpty,
                let password = passwordTextField.text, !password.isEmpty,
                let confirmPassword = confirmPasswordTextField.text, !confirmPassword.isEmpty
            else {
                print(" Error: All fields are required")
                return
            }

            guard password == confirmPassword else {
                print(" Error: Passwords do not match")
                return
            }

        let user = User(
            fullName: fullName,
            email: email,
            password: password
        )

        let success = UserData.shared.saveUser(user)

        if success {
            print("Signup successful. User saved.")
        }
        
        }


}

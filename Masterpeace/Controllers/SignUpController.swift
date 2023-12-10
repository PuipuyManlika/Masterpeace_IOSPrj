//
//  SignUpController.swift
//  Masterpeace
//
//  Created by Manlika Throngsiriwat on 2023-03-29.
//

import UIKit
import Firebase
import FirebaseDatabase

class SignUpController: UIViewController, MySignUpFrameDelegate {

    let mySignUpFrame = MySignUpFrame()
    
    var ref: DatabaseReference!
    
    private let lblWelcome = Helper.newLabel(defaultText: "WELCOME TO...", textColor: UIColor(red: 160/255, green: 0/255, blue: 55/255, alpha: 1), fontSize: 36, fontAttribute: .bold, textAlignment: .center)
    
    private let lblTitle = Helper.newLabel(defaultText: "Masterpeace :D", textColor: UIColor(red: 240/255, green: 94/255, blue: 129/255, alpha: 1), fontSize: 36, fontAttribute: .bold, textAlignment: .center)
    
    private let lblNewUser = Helper.newLabel(defaultText: "--NEW USER--", textColor: UIColor(red: 224/255, green: 114/255, blue: 77/255, alpha: 1), fontSize: 36, fontAttribute: .bold, textAlignment: .center)
    
    private let lblAskforSignIn = Helper.newLabel(defaultText: "I've already had an account.", textColor: .black, fontSize: 18, fontAttribute: .regular, textAlignment: .left)
    
    private let btnSignIn = Helper.newButton(title: "Sign In", backgroundColor: UIColor.gray.withAlphaComponent(0), titlecolor: UIColor.systemBlue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hind the Back Button
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        //Firebase
        ref = Database.database().reference()
        
        initialize()
        applyConstraint()
        addTargets()
        
        //Protocol Delegate
        mySignUpFrame.delegate = self

    }

    func initialize(){
        
        mySignUpFrame.layer.cornerRadius = 20
        
        self.view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 208/255, alpha: 1)
        self.view.addSubviews(lblWelcome,lblTitle, lblNewUser, mySignUpFrame, lblAskforSignIn, btnSignIn)
        
    }
    
    func applyConstraint() {
        
        NSLayoutConstraint.activate([
            
            lblWelcome.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10),
            lblWelcome.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -50),
            lblWelcome.heightAnchor.constraint(equalToConstant: 100),
            
            lblTitle.topAnchor.constraint(equalTo: lblWelcome.bottomAnchor, constant: -20),
            lblTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 30),
            lblTitle.heightAnchor.constraint(equalToConstant: 80),
            
            lblNewUser.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: -10),
            lblNewUser.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            lblNewUser.heightAnchor.constraint(equalToConstant: 90),
            
            mySignUpFrame.topAnchor.constraint(equalTo: lblNewUser.bottomAnchor, constant: 15),
            mySignUpFrame.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            mySignUpFrame.widthAnchor.constraint(equalToConstant: 400),
            
            lblAskforSignIn.topAnchor.constraint(equalTo: mySignUpFrame.bottomAnchor, constant: 30),
            lblAskforSignIn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -35),
            lblAskforSignIn.heightAnchor.constraint(equalToConstant: 20),
            
            btnSignIn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 112),
            btnSignIn.heightAnchor.constraint(equalTo: lblAskforSignIn.heightAnchor),
            btnSignIn.topAnchor.constraint(equalTo: mySignUpFrame.bottomAnchor, constant: 30),
            
            //imgSnoopy.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            //imgSnoopy.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 70),
            //imgSnoopy.heightAnchor.constraint(equalToConstant: 300),
            //imgSnoopy.widthAnchor.constraint(equalToConstant: 150),
            
        ])
        
    }
    
    func addTargets() {
        
        btnSignIn.addTarget(self, action: #selector(btnSignInTouchUpInside), for: .touchUpInside)
        
    }
    
    @objc func btnSignInTouchUpInside() {
        navigationController?.popViewController(animated: true)
    }
    
    func userSignUp(_ sender: MySignUpFrame) {
        
        if mySignUpFrame.email == "" || mySignUpFrame.password == "" || mySignUpFrame.confirmPassword == "" {
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
        }
        
        if mySignUpFrame.password != mySignUpFrame.confirmPassword {
            
            let alertController = UIAlertController(title: "Error", message: "Password and Confirm Password do not match.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().createUser(withEmail: mySignUpFrame.email!, password: mySignUpFrame.password!) { [self] authResult, error in
                    if let error = error {
                        
                        let messageError = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        messageError.addAction(defaultAction)
                        self.present(messageError, animated: true, completion: nil)
                        return //we should return, not make sense to continue.
                        
                    } else {
                        
                        // Create a new user object
                        let user = User(email: mySignUpFrame.email!, password: mySignUpFrame.password!)
                        // Save the user object to the Firebase Realtime Database
                        self.ref.child("users").child(authResult!.user.uid).setValue(["email": user.email, "password": user.password])
                        navigationController?.popViewController(animated: true)
                    }
                }
        }
    }
}

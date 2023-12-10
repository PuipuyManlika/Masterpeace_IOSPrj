//
//  ViewController.swift
//  Masterpeace
//
//  Created by Manlika Throngsiriwat and Aldo Medrano on 2023-03-29.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, MySignInFrameDelegate{
    
    let mySignInFrame = MySignInFrame()
    
    var ref: DatabaseReference!
    
    private let lblWelcome = Helper.newLabel(defaultText: "WELCOME TO...", textColor: UIColor(red: 160/255, green: 0/255, blue: 55/255, alpha: 1), fontSize: 36, fontAttribute: .bold, textAlignment: .center)
    
    private let lblTitle = Helper.newLabel(defaultText: "Masterpeace :D", textColor: UIColor(red: 240/255, green: 94/255, blue: 129/255, alpha: 1), fontSize: 36, fontAttribute: .bold, textAlignment: .center)
    
    private let lblAskforSignUp = Helper.newLabel(defaultText: "Do not have an account yet?", textColor: .black, fontSize: 18, fontAttribute: .regular, textAlignment: .left)
    
    private let btnSignUp = Helper.newButton(title: "Sign Up", backgroundColor: UIColor.gray.withAlphaComponent(0), titlecolor: UIColor.systemBlue)
    
    private let imgSnoopy = Helper.newImage(imgName: "signIn", tintColor: UIColor.black ,contentMode: UIView.ContentMode .scaleAspectFit)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Firebase
        ref = Database.database().reference()
        
        initialize()
        applyConstraint()
        addTargets()
        
        //Protocol Delegate
        mySignInFrame.delegate = self

    }
    
    func initialize(){
        
        mySignInFrame.layer.cornerRadius = 20
        
        self.view.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 208/255, alpha: 1)
        
        self.view.addSubviews(lblWelcome,lblTitle, mySignInFrame,lblAskforSignUp, btnSignUp, imgSnoopy)
        
    }
    
    func applyConstraint() {
        
        NSLayoutConstraint.activate([
            
            lblWelcome.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            lblWelcome.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -50),
            lblWelcome.heightAnchor.constraint(equalToConstant: 100),
            
            lblTitle.topAnchor.constraint(equalTo: lblWelcome.bottomAnchor, constant: -10),
            lblTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 30),
            lblTitle.heightAnchor.constraint(equalToConstant: 80),
            
            mySignInFrame.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 20),
            mySignInFrame.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            mySignInFrame.widthAnchor.constraint(equalToConstant: 400),
            
            lblAskforSignUp.topAnchor.constraint(equalTo: mySignInFrame.bottomAnchor, constant: 20),
            lblAskforSignUp.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -40),
            lblAskforSignUp.heightAnchor.constraint(equalToConstant: 20),
            
            btnSignUp.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 113),
            btnSignUp.heightAnchor.constraint(equalTo: lblAskforSignUp.heightAnchor),
            btnSignUp.topAnchor.constraint(equalTo: mySignInFrame.bottomAnchor, constant: 20),
            
            imgSnoopy.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            imgSnoopy.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 70),
            imgSnoopy.heightAnchor.constraint(equalToConstant: 300),
            imgSnoopy.widthAnchor.constraint(equalToConstant: 150),
            
        ])
        
    }
    
    func addTargets() {
        
        btnSignUp.addTarget(self, action: #selector(btnSignUpTouchUpInside), for: .touchUpInside)
    }
    
    @objc func btnSignUpTouchUpInside(){
        
        performSegue(withIdentifier: "toSignUpController", sender: nil)
    }
    
    
    @objc func btnFreeAccessTouchUpInside(){
        
        performSegue(withIdentifier: "toFeedPageController", sender: nil)
    }
    
    func userSignIn(_ sender: MySignInFrame) {
        
        if mySignInFrame.email == "" || mySignInFrame.password == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        
        Auth.auth().signIn(withEmail: mySignInFrame.email!, password: mySignInFrame.password!) { result, error in
            
            if error != nil {
                //we have somth wrong
                let messageError = UIAlertController(title: "Error", message: "\(error!.localizedDescription)", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                messageError.addAction(defaultAction)
                self.present(messageError, animated: true, completion: nil)
                return //we should return, not make sense to continue.
            }
            
            self.performSegue(withIdentifier: "toFeedPageController", sender: nil)
            
        }
    }

}


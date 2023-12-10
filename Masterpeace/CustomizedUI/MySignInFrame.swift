//
//  MySignInFrame.swift
//  Masterpeace
//
//  Created by Manlika Throngsiriwat on 2023-03-29.
//

import UIKit

protocol MySignInFrameDelegate {
    func userSignIn ( _ sender : MySignInFrame)
}

class MySignInFrame : UIView {
    
    public var delegate : MySignInFrameDelegate?
    
    public var email : String? {
        didSet{
            txtEmail.text = email
        }
    }
    
    public var password : String? {
        didSet{
            txtPassword.text = password
        }
    }
    
    private let txtEmail = Helper.newTextField(placeHolder: "  Email", isPassword: false)
    
    private let txtPassword = Helper.newTextField(placeHolder: "  Password", isPassword: true)
    
    private let btnSignIn = Helper.newButton(title: "Sign In", backgroundColor: UIColor(red: 0/255, green: 122/255, blue: 97/255, alpha: 1), titlecolor: UIColor.white, radius: 10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
        applyConstraint()
        addTargets()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initialize(){
        
        self.backgroundColor = UIColor(red: 182/255, green: 194/255, blue: 119/255, alpha: 1)
        self.addSubviews(txtEmail, txtPassword, btnSignIn)
        
    }
    
    func applyConstraint() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            self.heightAnchor.constraint(equalToConstant: 300),
            self.widthAnchor.constraint(equalToConstant: 400),
            
            txtEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            txtEmail.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 60),
            txtEmail.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            txtEmail.heightAnchor.constraint(equalToConstant: 40),
            
            txtPassword.topAnchor.constraint(equalTo: txtEmail.bottomAnchor, constant: 30),
            txtPassword.leadingAnchor.constraint(equalTo: txtEmail.leadingAnchor),
            txtPassword.trailingAnchor.constraint(equalTo: txtEmail.trailingAnchor),
            txtPassword.heightAnchor.constraint(equalTo: txtEmail.heightAnchor),
            
            btnSignIn.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 40),
            btnSignIn.trailingAnchor.constraint(equalTo: txtPassword.trailingAnchor),
            btnSignIn.widthAnchor.constraint(equalToConstant: 100),
            btnSignIn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func addTargets(){
        btnSignIn.addTarget(self, action: #selector(btnSignInTouchUpInside), for: .touchUpInside)
    }
    
    @objc func btnSignInTouchUpInside() {
        
        if self.delegate != nil{
            email = txtEmail.text
            password = txtPassword.text
            self.delegate!.userSignIn(self)
        }
    }
    
}

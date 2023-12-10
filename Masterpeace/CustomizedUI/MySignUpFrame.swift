//
//  MainPage.swift
//  Masterpeace
//
//  Created by Manlika Throngsiriwat on 2023-03-29.
//

import UIKit

protocol MySignUpFrameDelegate {
    
    func userSignUp ( _ sender : MySignUpFrame)
}

class  MySignUpFrame : UIView {
    
    public var delegate : MySignUpFrameDelegate?
    
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
    
    public var confirmPassword : String? {
        didSet{
            txtConfirmPassword.text = confirmPassword
        }
    }
    
    
    private let txtEmail = Helper.newTextField(placeHolder: "  Email", isPassword: false)
    
    private let txtPassword = Helper.newTextField(placeHolder: "  Password", isPassword: true)
    
    private let txtConfirmPassword = Helper.newTextField(placeHolder: "  Confirm Password", isPassword: true)
    
    private let btnSignUp = Helper.newButton(title: "Sign Up", backgroundColor: UIColor(red: 0/255, green: 122/255, blue: 97/255, alpha: 1), titlecolor: UIColor.white, radius: 10)
    
    private let imageFlower = Helper.newImage(imgName: "flower", tintColor: UIColor.black ,transform: Double.pi / 4, contentMode: UIView.ContentMode.scaleAspectFit)
    
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
        self.addSubviews(txtEmail, txtPassword, txtConfirmPassword, btnSignUp, imageFlower)
        
    }
    
    func applyConstraint() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            self.heightAnchor.constraint(equalToConstant: 350),
            self.widthAnchor.constraint(equalToConstant: 400),
            
            txtEmail.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            txtEmail.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            txtEmail.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            txtEmail.heightAnchor.constraint(equalToConstant: 40),
            
            txtPassword.topAnchor.constraint(equalTo: txtEmail.bottomAnchor, constant: 30),
            txtPassword.leadingAnchor.constraint(equalTo: txtEmail.leadingAnchor),
            txtPassword.trailingAnchor.constraint(equalTo: txtEmail.trailingAnchor),
            txtPassword.heightAnchor.constraint(equalTo: txtEmail.heightAnchor),
            
            txtConfirmPassword.topAnchor.constraint(equalTo: txtPassword.bottomAnchor, constant: 30),
            txtConfirmPassword.leadingAnchor.constraint(equalTo: txtPassword.leadingAnchor),
            txtConfirmPassword.trailingAnchor.constraint(equalTo: txtPassword.trailingAnchor),
            txtConfirmPassword.heightAnchor.constraint(equalTo: txtPassword.heightAnchor),
            
            btnSignUp.topAnchor.constraint(equalTo: txtConfirmPassword.bottomAnchor, constant: 40),
            btnSignUp.trailingAnchor.constraint(equalTo: txtConfirmPassword.trailingAnchor),
            btnSignUp.widthAnchor.constraint(equalToConstant: 100),
            btnSignUp.heightAnchor.constraint(equalToConstant: 50),
            
            imageFlower.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: -5),
            imageFlower.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 73),
            imageFlower.heightAnchor.constraint(equalToConstant: 220),
            imageFlower.widthAnchor.constraint(equalToConstant: 110)
        ])
    }
    
    func addTargets(){
        btnSignUp.addTarget(self, action: #selector(btnSignUpTouchUpInside), for: .touchUpInside)
    }
    
    @objc func btnSignUpTouchUpInside() {
        
        if self.delegate != nil{
            email = txtEmail.text
            password = txtPassword.text
            confirmPassword = txtConfirmPassword.text
            self.delegate!.userSignUp(self)
        }
    }
}

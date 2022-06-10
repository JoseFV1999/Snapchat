//
//  ViewController.swift
//  Snapchat
//
//  Created by Jose Falconi on 5/26/22.
//  Copyright © 2022 empresa. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
import FirebaseDatabase

class iniciarSesionViewController: UIViewController  {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginGOOGLE(_ sender: Any) {
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    private func Googleconfig(){
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.delegate = self
    }
    
    @IBAction func crearUsuarioTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "crearUsuarioSegue", sender: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Googleconfig()
        // Do any additional setup after loading the view.
    }

    @IBAction func IniciarSesionTapped(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
            (user, error) in
            print("Intentando Iniciar Sesion")
            if error != nil {
                print("Se presento el siguiente error: \(error)")
                let alerta = UIAlertController(title: "Error al iniciar sesion", message: "Usuario \(self.emailTextField.text!) no registrado. Registre para poder logearse", preferredStyle: .alert)
                let btnCrear = UIAlertAction(title: "Crear", style: .default, handler: {
                    (UIAlertAction) in
                     self.performSegue(withIdentifier: "crearUsuarioSegue", sender: nil)
                })
                let btnCancelar = UIAlertAction(title: "Cancelar", style: .default, handler: {
                    (UIAlertAction) in
                })
                alerta.addAction(btnCrear)
                alerta.addAction(btnCancelar)
                self.present(alerta, animated: true, completion: nil)
            }
            else{
                print("Inicio de sesion exitoso")
                self.performSegue(withIdentifier: "iniciarsesionsegue", sender: nil)
            }
        }
    }
    
    
    
}

extension iniciarSesionViewController: GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error{
            print("Error because (error.localizedDescription)")
            return
        }

        guard let auth = user.authentication else {return}
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)

        Auth.auth().signIn(with: credentials){ (authResult, error) in
            if let error = error{
                print("Error because (error.localizedDescription)")
                return
            }
        }
    }

}

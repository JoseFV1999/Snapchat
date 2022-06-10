//
//  CrearUsuarioViewController.swift
//  Snapchat
//
//  Created by Jose Falconi on 6/10/22.
//  Copyright © 2022 empresa. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CrearUsuarioViewController: UIViewController {

    @IBOutlet weak var usuarioTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func volverTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func registrarseButtonTapped(_ sender: Any) {
        Auth.auth().createUser(withEmail: self.usuarioTextField.text!, password: self.passwordTextField.text!, completion: {
            (user, error) in
            print("Intentando crear un usuario")
            if error != nil {
                print("Se presento el siguiente error al crear el usuario: \(error)")
                let alerta = UIAlertController(title: "Error al crear usuario", message: "Error: \(error)", preferredStyle: .alert)
                let btnOK = UIAlertAction(title: "Aceptar", style: .default, handler: {
                    (UIAlertAction) in
                })
                alerta.addAction(btnOK)
                self.present(alerta, animated: true, completion: nil)
            }
            else {
                print("El usuario fue creado exitosamente")
                Database.database().reference().child("usuarios").child(user!.user.uid).child("email").setValue(user!.user.email)
                let alerta = UIAlertController(title: "Creacion de Usuario", message: "Usuario \(self.usuarioTextField.text!) se creo correctamente", preferredStyle: .alert)
                let btnAceptar = UIAlertAction(title: "Aceptar", style: .default, handler: {
                    (UIAlertAction) in
                    self.dismiss(animated: true, completion: nil)
                })
                alerta.addAction(btnAceptar)
                self.present(alerta, animated: true, completion: nil)
            }
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

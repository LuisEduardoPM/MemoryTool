//
//  AuthViewController.swift
//  MemoryTool
//
//  Created by Mac4 on 30/01/21.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {

    @IBOutlet weak var correoTextField: UITextField!
    
    @IBOutlet weak var contraTextField: UITextField!
    @IBOutlet weak var registrarUIButton: UIButton!
    
    @IBOutlet weak var accederUIButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func registrarButtonAction(_ sender: Any) {
        
        if let email = correoTextField.text, let password = contraTextField.text{
            //Crear el usuario xd
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                
                if let result = result, error == nil{
                    self.performSegue(withIdentifier: "verTareas", sender: TareasTableViewController.self)
                }else{
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error creando el usuario.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    @IBAction func accederButtonAction(_ sender: Any) {
        if let email = correoTextField.text, let password = contraTextField.text{
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                if let result = result, error == nil{
                    self.performSegue(withIdentifier: "verTareas", sender: TareasTableViewController.self)
                }else{
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error al acceder.", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                        self.present(alertController, animated: true, completion: nil)}
                
            }
        }
        
    }
    
}


//
//  EditarNotaViewController.swift
//  MemoryTool
//
//  Created by Mac4 on 01/02/21.
//

import UIKit
import CoreData
class EditarNotaViewController: UIViewController {
    
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var contenidoTextArea: UITextView!
    @IBOutlet weak var imagenImageView: UIImageView!
    @IBOutlet weak var fechaDatePicker: UIDatePicker!
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var notas = [Nota]()
    var id : Int?
    var opcion : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cargarInfo()
        if (opcion == 1){
            print("editar \(String(describing: id))")
            tituloTextField?.text = notas[id!].titulo
            contenidoTextArea?.text = notas[id!].contenido
        } else {
            
            let f = DateFormatter()
            f.dateStyle = .short
        }
    }
    
    func cargarInfo() {
          
        let fR : NSFetchRequest<Nota> = Nota.fetchRequest()
          
        do {
            notas = try contexto.fetch(fR)
            
        }catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func guardarNota() {
        do {
            try contexto.save()
            print("se guardo la tarea")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    
    @IBAction func guardarButton(_ sender: UIButton) {
        if (opcion == 0) {
                    self.guardarNuevaNota()
                } else if (opcion == 1) {
                    self.guardarCambiosNota()
                }
                navigationController?.popViewController(animated: true)
    }
    func guardarCambiosNota() {
        
        let cont = contenidoTextArea.text ?? ""
        let titulo = tituloTextField.text ?? ""
        
        //let fecha = FechaTextField.text ?? ""
        notas[id!].setValue(cont, forKey: "contenido")
        notas[id!].setValue(titulo, forKey: "titulo")
        
        
        guardarNota()
                
        
    }
    
    func guardarNuevaNota() {
        
        guard let titulo = tituloTextField?.text else {return}
        guard let cont = contenidoTextArea?.text  else {return}
        
        
        let nuevaNota = Nota(context: self.contexto)
        
        nuevaNota.titulo = titulo
        nuevaNota.contenido = cont
       
        
        
        self.notas.append(nuevaNota)
        
        self.guardarNota()
        
                
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    

}

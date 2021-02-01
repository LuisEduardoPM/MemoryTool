//
//  TablaNotasViewController.swift
//  MemoryTool
//
//  Created by Mac4 on 30/01/21.
//

import UIKit
import CoreData

class TablaNotasViewController: UIViewController {

    @IBOutlet weak var TablaNotas: UITableView!
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var notas = [Nota]()
    
    var id : Int?
    var opcion : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        cargarInfo()
        TablaNotas.reloadData()
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
              self.cargarInfo()
              
          }catch let error as NSError {
              print(error.localizedDescription)
          }
          
      }
    

    @IBAction func agrgarNota(_ sender: UIBarButtonItem) {
        self.opcion = 0
        performSegue(withIdentifier: "abrirNota", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "abrirNota" {
            let o = segue.destination as! EditarNotaViewController
               
            o.id = self.id
            o.opcion = self.opcion
            
    }
           
       }
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }

}
extension TablaNotasViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = TablaNotas.dequeueReusableCell(withIdentifier: "celln", for: indexPath)
        celda.textLabel?.text = notas[indexPath.row].titulo
        celda.detailTextLabel?.text = notas[indexPath.row].contenido
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
        self.id = indexPath.row
        self.opcion = 1
           
           performSegue(withIdentifier: "abrirNota", sender: nil)
           
       }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                contexto.delete(notas[indexPath.row])
                notas.remove(at: indexPath.row)
                guardarNota()
                
            }
            TablaNotas.reloadData()
            
        }
    
        
    }

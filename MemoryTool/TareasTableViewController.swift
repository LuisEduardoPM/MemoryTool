//
//  TareasTableViewController.swift
//  MemoryTool
//
//  Created by Mac4 on 30/01/21.
//

import UIKit
import CoreData

class TareasTableViewController: UITableViewController {
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tareas = [Tarea]()
    
    var id : Int?
    var opcion : Int?
    
    @IBOutlet var TablaTareas: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.cargarInfo()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        cargarInfo()
        TablaTareas.reloadData()
    }
    
    

    @IBAction func agregarTarea(_ sender: UIBarButtonItem) {
        
    }
    
    func cargarInfo() {
          
          let fR : NSFetchRequest<Tarea> = Tarea.fetchRequest()
          
          do {
              tareas = try contexto.fetch(fR)
            
          }catch let error as NSError {
              print(error.localizedDescription)
          }
      }
    
    func guardarContacto() {
          do {
              try contexto.save()
              self.cargarInfo()
              
          }catch let error as NSError {
              print(error.localizedDescription)
          }
          
      }
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tareas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = TablaTareas.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        celda.textLabel?.text = tareas[indexPath.row].titulo
        celda.detailTextLabel?.text = tareas[indexPath.row].lugar
        
        if tareas[indexPath.row].estado {
            celda.accessoryType = UITableViewCell.AccessoryType.checkmark
        }else {
            celda.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
            
        }
        
        

        return celda
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
        self.id = indexPath.row
        self.opcion = 1
           
           performSegue(withIdentifier: "editarTarea", sender: nil)
           
       }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                contexto.delete(tareas[indexPath.row])
                tareas.remove(at: indexPath.row)
                guardarContacto()
                
            }
            TablaTareas.reloadData()
            
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "editarTarea" {
            let o = segue.destination as! EditarTareaViewController
               
            o.id = self.id
            o.opcion = self.opcion
               
           }
           
       }
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
    
    @IBAction func nuevaTarea(_ sender: UIBarButtonItem) {
        self.opcion = 0
        performSegue(withIdentifier: "editarTarea", sender: nil)    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

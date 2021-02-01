//
//  TablaNotasViewController.swift
//  MemoryTool
//
//  Created by Mac4 on 30/01/21.
//

import UIKit

class TablaNotasViewController: UIViewController {

    @IBOutlet weak var TablaNotas: UITableView!
    //let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //let tareas[Tarea]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    

    

}
extension TablaNotasViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = TablaNotas.dequeueReusableCell(withIdentifier: "celln", for: indexPath)
        celda.textLabel?.text = "Nota x"
        celda.detailTextLabel?.text = "descripcion"
        return celda
    }
    
        
    }

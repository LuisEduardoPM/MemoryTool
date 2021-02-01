//
//  EditarTareaViewController.swift
//  MemoryTool
//
//  Created by Mac4 on 30/01/21.
//

import UIKit
import CoreData
import CoreLocation

class EditarTareaViewController: UIViewController,CLLocationManagerDelegate{

    @IBOutlet weak var TituloTextField: UITextField!
    @IBOutlet weak var DescripcionTextView: UITextView!
    @IBOutlet weak var FechaTextField: UITextField!
    @IBOutlet weak var UbicacionTextField: UITextField!
    @IBOutlet weak var EstadoUISwitch: UISwitch!
    @IBOutlet weak var EstadoLabel: UILabel!
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tareas = [Tarea]()
    var id : Int?
    var opcion : Int?
    
    var longitud : Double?
    var latitud : Double?
    
    
    var locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization() //Solicita el permiso
        locationManager.requestLocation()        //self.cargarInfo()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        cargarInfo()
        if (opcion == 1){
            print("editar \(String(describing: id))")
            TituloTextField?.text = tareas[id!].titulo
            DescripcionTextView?.text = tareas[id!].descripcion
            UbicacionTextField?.text = tareas[id!].lugar
            EstadoUISwitch.isOn = tareas [id!].estado
            if (tareas[id!].estado) {
                EstadoLabel.text = "Completada"
            }else {
                EstadoLabel.text = "No completada"
            }
            let f = DateFormatter()
            f.dateStyle = .short
            FechaTextField?.text = f.string(from: tareas[id!].fecha ?? Date())
            
        } else {
            print ("nuevo")
            let f = DateFormatter()
            f.dateStyle = .short
            FechaTextField?.text = f.string(from: Date())
        }
    }
    func guardarCambiosEditar() {
        
        let des = DescripcionTextView.text ?? ""
        let titulo = TituloTextField.text ?? ""
        let lugar = UbicacionTextField.text ?? ""
        //let fecha = FechaTextField.text ?? ""
        tareas[id!].setValue(des, forKey: "descripcion")
        tareas[id!].setValue(titulo, forKey: "titulo")
        tareas[id!].setValue(lugar, forKey: "lugar")
        tareas[id!].setValue(EstadoUISwitch.isOn, forKey: "estado")
        guardarTarea()
                
        
    }
    
    func guardarNuevaTarea() {
        
        guard let titulo = TituloTextField?.text else {return}
        guard let description = DescripcionTextView?.text  else {return}
        let estado = false
        guard let lugar = UbicacionTextField?.text  else {return}
        
        let nuevaTarea = Tarea(context: self.contexto)
        
        nuevaTarea.titulo = titulo
        nuevaTarea.descripcion = description
        nuevaTarea.estado = estado
        nuevaTarea.lugar = lugar
        
        print(titulo)
        
        self.tareas.append(nuevaTarea)
        
        self.guardarTarea()
        
                
        
        
    }
    @IBAction func guardarCambios(_ sender: UIButton) {
        if (opcion == 0) {
            self.guardarNuevaTarea()
        } else if (opcion == 1) {
            self.guardarCambiosEditar()
        }
        navigationController?.popViewController(animated: true)
    }
    func cargarInfo() {
          
        let fR : NSFetchRequest<Tarea> = Tarea.fetchRequest()
          
        do {
            tareas = try contexto.fetch(fR)
            
        }catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func guardarTarea() {
        do {
            try contexto.save()
            print("se guardo la tarea")
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    //
    
    @IBAction func obtenerUbicacion(_ sender: UIButton) {
        locationManager.requestLocation()
        UbicacionTextField.text = "lat: \(latitud!), lon: \(String(longitud!)) "
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            locationManager.stopUpdatingLocation()
            if let ubicaciones = locations.last{
                self.latitud = ubicaciones.coordinate.latitude
                self.longitud = ubicaciones.coordinate.longitude
            }
        
        }
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error.localizedDescription)
        }
    
    
    @IBAction func accionSwitch(_ sender: UISwitch) {
        if (EstadoUISwitch.isOn) {
            EstadoLabel.text = "Completada"
        } else {
            EstadoLabel.text = "No completada"
        }
    }
    
    
}

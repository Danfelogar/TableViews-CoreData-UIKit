//
//  ViewController.swift
//  TableViews
//
//  Created by Brais Moure.
//  Copyright © 2020 MoureDev. All rights reserved.
//

import UIKit
//1. - importart coreData
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //2. - Cambiar a variable de tipo pais sin datos iniciales
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //3. - Cambiar a variable de tipo pais sin datos iniciales
    private var myCountries:[Country]?
    //    ["España", "Mexico", "Perú", "Colombia", "Argentina", "EEUU", "Francia", "Italia"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //4. - Respuesta de datos
        getData()
    }
    
    @IBAction func add(_ sender: Any) {
        
        //Crear alerta
        let alert = UIAlertController(title: "Agregar Pais", message: "Añade un pais nuevo", preferredStyle: .alert)
        alert.addTextField()
        //Crear y configurar boton de alerta
        let botonAlert = UIAlertAction(title: "Añadir", style: .default){ (action) in
            
            //Recuperar textField de la alerta
            let textField = alert.textFields![0]
            
            //Crear objeto Pais
            let newCountry = Country(context:  self.context)
            print("-------------->>>>>>\(textField.text)")
            newCountry.name = textField.text
            
            //Guardar información (Añade block do-try-catch)
            do {
                try self.context.save()
            } catch {
                print("Failed to save context: \(error)")
            }
            try! self.context.save()
            
            //Referscar información en tableview
            self.getData()
        }
        //Añadir boton a la alerta y mostrar la alerta
        alert.addAction(botonAlert)
        self.present(alert,animated: true, completion: nil)
    }
    
    func getData() {
        do {
            //obtener datos
            self.myCountries = try context.fetch(Country.fetchRequest())
            //recargar tabla
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Error recuperado")
        }
    }
}


// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //5. - contar los nombres de los paises
        myCountries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //5. - contar numero de paises con la data print myCountries?.count ?? 0
        
        //7.- Añadir funcionalidad de editar
        
        //Cual pais se editara?
        let countryEdit = self.myCountries![indexPath.row]
        
        //Crear alerta
        let alert = UIAlertController(title: "Editar Pais", message: "Edita el pais", preferredStyle: .alert)
        alert.addTextField()
        
        //Recuperar nombre de pais actual de la alerta y agregarla al textField
        let textField = alert.textFields![0]
        
        textField.text = countryEdit.name
        
        //Crear y configurar btn de la alerta
        let btnAlert = UIAlertAction(title: "Editar", style: .default){ (action) in
            
            //Recuperar textField de la alerta
            let textField = alert.textFields![0]
            
            //Editar pais actual con lo que este en el textfield
            countryEdit.name = textField.text
            
            //Guardar informacion (Añadir block do-try-catch)
            try! self.context.save()
            
            //Refrescar informacion en la tableview
            self.getData()
        }
        //Añadir btn a la alerta y mostrar la alerta
        alert.addAction(btnAlert)
        self.present(alert,animated: true, completion: nil)
    }
    // Añadir funcionalidad de  swiper
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //Crear accion de eliminar
        let actionDelete = UIContextualAction(style: .destructive, title: "Eliminar") { (action, view, completionHandler) in
            //cual pai se eliminara?
            let countryDelete = self.myCountries![indexPath.row]
            
            //Eliminar pais
            self.context.delete(countryDelete)
            
            //Gauardar el cambio de informacion
            try! self.context.save()
            
            //Recarga datos
            self.getData()
        }
        return UISwipeActionsConfiguration(actions: [actionDelete])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "mycell")
        if cell == nil {
            
            cell = UITableViewCell(style: .default, reuseIdentifier: "mycell")
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 20)
            
        }
        // 5. - recuperar el nombre de la palabra clave  name de la entidad conutry
        cell!.textLabel?.text = myCountries![indexPath.row].name
        return cell!
        
        
        
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
//    private func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //5. - contar los nombres de los paises
//        print(myCountries![indexPath.row])
//    }
    
}


//
//  PostalCodeTableViewController.swift
//  WTesteApp
//
//  Created by mac on 13/03/19.
//  Copyright © 2019 Wesley S. Favarin. All rights reserved.
//

import UIKit
import CoreData

class PostalCodeTableViewController: UITableViewController {
    
    
    var fechedResultController: NSFetchedResultsController<PostalCode>!
    let searchController = UISearchController(searchResultsController: nil)
    var postalCode: PostalCode!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        fechDataAsync()
          
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.backgroundColor = .white
        navigationItem.searchController = searchController
        
        searchController.searchBar.delegate = self
        
        loadPostalCodes()
        
    }

    
    func fechDataAsync()
    {
        let group = DispatchGroup()
       
                let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
                dispatchQueue.async{
                    //Time consuming task here
                    self.fetchPostalCode()
                }
    
        group.notify(queue: DispatchQueue.main, execute: {
            print("task finished!")
        })
    }
    
    
    fileprivate func fetchPostalCode() {
        if self.postalCode == nil {
            self.postalCode = PostalCode(context: context)
        }
        
        Service.shared.fetchPostalCode { (items) in
            if let items = items {
                
                let fechRequest: NSFetchRequest<PostalCode> = PostalCode.fetchRequest()
                let sortDescriptor = NSSortDescriptor(key: "nome_localidade", ascending: true)
                fechRequest.sortDescriptors = [sortDescriptor]
                
                self.fechedResultController = NSFetchedResultsController(fetchRequest: fechRequest, managedObjectContext: self.context , sectionNameKeyPath: nil, cacheName: nil)
                self.fechedResultController.delegate = self
                
                do{
                    try self.fechedResultController.performFetch()
                }catch{
                    print(error.localizedDescription)
                }
                
              
                
                for item in items {
                    if item.0 != "cod_distrito" {
                        
//                        var contexto: NSManagedObjectContext {
//                            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//                            return appDelegate.persistentContainer.viewContext
//                        }
                        let count = self.fechedResultController.fetchedObjects?.count ?? 0
                        var codepostal = NSEntityDescription.insertNewObject(forEntityName: "PostalCode", into: self.context)  as NSManagedObject
                        
                        
//                        cod_distrito,cod_concelho,cod_localidade,nome_localidade,cod_arteria,tipo_arteria,prep1,titulo_arteria,prep2,nome_arteria,local_arteria,troco,porta,cliente,num_cod_postal,ext_cod_postal,desig_postal

                        codepostal.setValue(item.1, forKey: "cod_distrito")
                        codepostal.setValue(item.2, forKey: "cod_concelho")
                        codepostal.setValue(item.3, forKey: "cod_localidade")
                        codepostal.setValue(item.4, forKey: "nome_localidade")
                        codepostal.setValue(item.5, forKey: "cod_arteria")
                        codepostal.setValue(item.6, forKey: "tipo_arteria")
                        codepostal.setValue(item.7, forKey: "prep1")
                        codepostal.setValue(item.8, forKey: "titulo_arteria")
                        codepostal.setValue(item.9, forKey: "prep2")
                        codepostal.setValue(item.10, forKey: "nome_arteria")
                        codepostal.setValue(item.11, forKey: "troco")
                        codepostal.setValue(item.12, forKey: "porta")
                        codepostal.setValue(item.13, forKey: "cliente")
                        codepostal.setValue(item.14, forKey: "num_cod_postal")
                        codepostal.setValue(item.15, forKey: "ext_cod_postal")
                        //codepostal.setValue(item.16, forKey: "desig_postal")
                        
                       // if count <= 1000 {
                            do {
                                try self.context.insert(codepostal)
                                try self.context.save()
                                
                            } catch {
                                print(error.localizedDescription)
                            }
                        
                        
                    }else {
                        return
                        
                    }
                    
                }
                
                return
            }
        }
    }
    
    func loadPostalCodes(filtering: String = ""){
        
        
        let fechRequest: NSFetchRequest<PostalCode> = PostalCode.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "nome_localidade", ascending: true)
        fechRequest.sortDescriptors = [sortDescriptor]
        
        if !filtering.isEmpty{
            let p1 =  NSPredicate(format: "nome_localidade contains [c] %@", filtering)
            
            fechRequest.predicate = p1
        }
        
        
        self.fechedResultController = NSFetchedResultsController(fetchRequest: fechRequest, managedObjectContext: self.context , sectionNameKeyPath: nil, cacheName: nil)
        self.fechedResultController.delegate = self
        
        do{
            try self.fechedResultController.performFetch()
        }catch{
            print(error.localizedDescription)
        }
        
        //slet count = self.fechedResultController.fetchedObjects?.count ?? 0
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        let count = fechedResultController.fetchedObjects?.count ?? 0

        return count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PostalCodeTableViewCell

        guard let postalcode = fechedResultController.fetchedObjects?[indexPath.row] else {
            return cell
            
        }
        cell.prepare(with: postalcode)

        return cell
    }
    

   
}
extension PostalCodeTableViewController: NSFetchedResultsControllerDelegate{
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            break
        default:
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension PostalCodeTableViewController: UISearchResultsUpdating , UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        loadPostalCodes(filtering: searchBar.text!)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//
//  PostalCodeViewController.swift
//  WTesteApp
//
//  Created by mac on 10/03/19.
//  Copyright © 2019 Wesley S. Favarin. All rights reserved.
//

import UIKit
import CoreData
class PostalCodeViewController: UITabBarController {

    var fechedResultController: NSFetchedResultsController<PostalCode>!
    var postalCode: PostalCode!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//            fetchPostalCode()
    }
    
    
    fileprivate func fetchPostalCode() {
        if self.postalCode == nil {
            self.postalCode = PostalCode(context: context)
        }
        
        Service.shared.fetchPostalCode { (items) in
            if let items = items {
                
                        for item in items {
                            if item.0 != "cod_distrito" {
                                let fechRequest: NSFetchRequest<PostalCode> = PostalCode.fetchRequest()
                                let sortDescriptor = NSSortDescriptor(key: "nome_localidade", ascending: true)
                                fechRequest.sortDescriptors = [sortDescriptor]
                                
                                self.fechedResultController = NSFetchedResultsController(fetchRequest: fechRequest, managedObjectContext: self.context , sectionNameKeyPath: nil, cacheName: nil)
                               // fechedResultController.delegate = self
                                
                                do{
                                    try self.fechedResultController.performFetch()
                                }catch{
                                    print(error.localizedDescription)
                                }
                                
                               let count = self.fechedResultController.fetchedObjects?.count ?? 0
                                
                                
                                self.postalCode.cod_distrito = item.0
                                self.postalCode.cod_concelho = item.1
                                self.postalCode.cod_localidade = item.2
                                self.postalCode.nome_localidade = item.3
                                self.postalCode.cod_arteria = item.4
                                self.postalCode.tipo_arteria = item.5
                                self.postalCode.prep1 = item.6
                                self.postalCode.titulo_arteria = item.7
                                self.postalCode.prep2 = item.8
                                self.postalCode.nome_arteria = item.9
                                self.postalCode.local_arteria = item.10
                                self.postalCode.troco = item.12
                                self.postalCode.porta = item.12
                                self.postalCode.cliente = item.12
                                self.postalCode.num_cod_postal = item.14
                                self.postalCode.ext_cod_postal = item.15
                                self.postalCode.desig_postal = item.16
                            
                                
                                //if count == 0 {
                                    do {
                                       try self.context.save()
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                              // }
                             //else {
                               //     return

                               // }
                                
                         }else {
                                return
                                
                            }
                           
                
                        }
                
                return
            }
        }
    }
    

}


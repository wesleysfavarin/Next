//
//  Service.swift
//  WTesteApp
//
//  Created by mac on 10/03/19.
//  Copyright © 2019 Wesley S. Favarin. All rights reserved.
//

import Foundation
import UIKit
class Service: NSObject {
    static let shared = Service()
    var distrito: Distrito!
    var distritos:  [Distrito]!
    var itemsPair: [(String, String,String,String,String, String,String,String,String, String,String,String,String, String,String,String,String)] = []
    
    var items: [(String, String)] = []
    
    func fetchPostalCode(completion: @escaping ([(String, String,String,String,String, String,String,String,String, String,String,String,String, String,String,String,String)]?) -> ()) {
        let stringURL = "https://raw.githubusercontent.com/centraldedados/codigos_postais/master/data/codigos_postais.csv"
        var content = readPostalCodeStringFromURL(stringURL: stringURL)
         completion(itemsPair)
    }
    
    func fetchConcelhos(completion: @escaping ([Distrito]?, Error?) -> ()) {
        
        
        let stringURL = "https://raw.githubusercontent.com/centraldedados/codigos_postais/master/data/concelhos.csv"
        
        let content = readStringFromURL(stringURL: stringURL)
        
        
        
        saveFile(fileName: "Concelhos")
        
    }
    
    func fetchDistritos(completion: @escaping ([(String, String)]?) -> ()) {
        
        let stringURL = "https://raw.githubusercontent.com/centraldedados/codigos_postais/master/data/distritos.csv"
        let content = readStringFromURL(stringURL: stringURL)
        completion(items)
        
    }
    
    func saveFile(fileName: String){
        let fileName = fileName
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil,create: true)
        let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
        print("file path: \(fileURL.path)")
    }
    
    func readStringFromURL(stringURL:String)-> String!{
        if let url = URL(string: stringURL) {
            do {
                let dataString = try String(contentsOf: url,encoding: String.Encoding.utf8)
                processData(dataString: dataString)
                
                return dataString
            } catch {
                print("Cannot load contents")
                return nil
            }
        } else {
            print("String was not a URL")
            return nil
        }
    }
    
    func readPostalCodeStringFromURL(stringURL:String)-> String!{
        if let url = URL(string: stringURL) {
            do {
                let dataString = try String(contentsOf: url,encoding: String.Encoding.utf8)
                processDataPostalCode(dataString: dataString)
                
                return dataString
            } catch {
                print("Cannot load contents")
                return nil
            }
        } else {
            print("String was not a URL")
            return nil
        }
    }
    
    func processData(dataString: String)  {
        let lines: [String] = dataString.components(separatedBy: NSCharacterSet.newlines) as [String]
        for line in lines {
            var values: [String] = []
            if line != "" {
                if line.range(of: "\"") != nil {
                    var textToScan:String = line
                    var value:NSString?
                    var textScanner:Scanner = Scanner(string: textToScan)
                    while textScanner.string != "" {
                        if (textScanner.string as NSString).substring(to: 1) == "\"" {
                            textScanner.scanLocation += 1
                            textScanner.scanUpTo("\"", into: &value)
                            textScanner.scanLocation += 1
                        } else {
                            textScanner.scanUpTo(",", into: &value)
                        }
                        
                        values.append(value! as String)
                        
                        if textScanner.scanLocation < textScanner.string.count {
                            textToScan = (textScanner.string as NSString).substring(from: textScanner.scanLocation + 1)
                        } else {
                            textToScan = ""
                        }
                        textScanner = Scanner(string: textToScan)
                    }
                    
                    // For a line without double quotes, we can simply separate the string
                    // by using the delimiter (e.g. comma)
                } else  {
                    values = line.components(separatedBy: ",")
                }
                
                // Put the values into the tuple and add it to the items array
                // let key  = (values[0])
                //let pair = (values[1])
                let item = (values[0], values[1])
                items.append(item)
                //print(itemsPair)
            }
        }
    }
    
    func processDataPostalCode(dataString: String)  {
        let lines: [String] = dataString.components(separatedBy: NSCharacterSet.newlines) as [String]
        for line in lines {
            var values: [String] = []
            if line != "" {
                if line.range(of: "\"") != nil {
                    var textToScan:String = line
                    var value:NSString?
                    var textScanner:Scanner = Scanner(string: textToScan)
                    while textScanner.string != "" {
                        if (textScanner.string as NSString).substring(to: 1) == "\"" {
                            textScanner.scanLocation += 1
                            textScanner.scanUpTo("\"", into: &value)
                            textScanner.scanLocation += 1
                        } else {
                            textScanner.scanUpTo(",", into: &value)
                        }
                        
                        values.append(value! as String)
                        
                        if textScanner.scanLocation < textScanner.string.count {
                            textToScan = (textScanner.string as NSString).substring(from: textScanner.scanLocation + 1)
                        } else {
                            textToScan = ""
                        }
                        textScanner = Scanner(string: textToScan)
                    }
                    
                    // For a line without double quotes, we can simply separate the string
                    // by using the delimiter (e.g. comma)
                } else  {
                    values = line.components(separatedBy: ",")
                }
                
                // Put the values into the tuple and add it to the items array
                // let key  = (values[0])
                //let pair = (values[1])
                let item = (values[0], values[1], values[2],values[3],values[4], values[5], values[6],values[7],values[8], values[9], values[10],values[11],values[12], values[13], values[14],values[15],values[16])
                if item.0 != "cod_distrito"{
                itemsPair.append(item)
                }//print(itemsPair)
            }
        }
    }
    
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ";")
            result.append(columns)
        }
        return result
    }
    
    
}

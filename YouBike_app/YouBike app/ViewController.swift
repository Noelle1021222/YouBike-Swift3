//
//  ViewController.swift
//  YouBike app
//
//  Created by 許雅筑 on 2017/7/12.
//  Copyright © 2017年 hsu.ya.chu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    
    var cellSelectPath : IndexPath?
    var btnSelectPath : IndexPath?
    var countAmount :Int = 0
    
    @IBOutlet weak var myFooterView: UIView!
    //update
    var isLoad = false
    var stationNext:String = ""
    let PageSize = 20// scroll 一次拿的資料
    @IBOutlet weak var circle: UIActivityIndicatorView!
    
    struct stationObject {
        var idNumber:String = ""
        var stationName:String = ""
        var sareaName:String = ""
        var sbiName:String = ""
        var arName:String = ""
        var arenName:String = ""
        var latName:String = ""
        var lngName:String = ""
        
    }
    
    var stationsArray :[stationObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "YouBike"
        
        
        //判斷連線
                //update viewcontroller 已繼承tableview
        let nib = UINib(nibName: "stationsCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        
        var innerStationArray:[stationObject] = []
        var coreDataStation = stationObject()
        
        guard let path = Bundle.main.path(forResource: "stations", ofType: "json") else {
            print("Error finding file")
            return
        }
        do {
            let data: NSData? = NSData(contentsOfFile: path)
            if let jsonResult: NSDictionary = try JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                
                
                let itemArray = jsonResult["data"] as? [AnyObject]
                
                for thing in itemArray! {
                    coreDataStation.stationName = (thing["sna"] as? String) ?? "Unknown"
                    coreDataStation.sareaName = (thing["sarea"] as? String) ?? "Unknown"
                    coreDataStation.sbiName = (thing["sbi"] as? String) ?? "Unknown"
                    coreDataStation.arName = (thing["ar"] as? String ) ?? "Unknown"
                    coreDataStation.arenName = (thing["aren"] as? String) ?? "Unknown"
                    coreDataStation.latName = (thing["lat"] as? String) ?? "Unknown"
                    coreDataStation.lngName = (thing["lng"] as? String) ?? "Unknown"
                    innerStationArray.append(coreDataStation)
                    self.stationsArray.append(coreDataStation)
                }
            }
        } catch let error as NSError {
            print("Error:\n \(error)")
            return
        }
    }
/*
        do {
            let remoteURL = NSURL(string: "http://warsaw-meadow-9763.pancakeapps.com/")!
            let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: remoteURL as URL)
            let session = URLSession.shared
            let task = session.dataTask(with: urlRequest as URLRequest) {
                (data, response, error) -> Void in
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                if (statusCode == 200) {
                    print("Everyone is fine, file downloaded successfully.")
                    do{
                        guard let jsonObject = try JSONSerialization.jsonObject(with: data!, options:[]) as? [String: AnyObject] else {
                            return
                        }
                        if let dataArray = jsonObject["data"] as? [AnyObject] {
                            for thing in dataArray {
                                coreDataStation.stationName = (thing["sna"] as? String) ?? "Unknown"
                                coreDataStation.sareaName = (thing["sarea"] as? String) ?? "Unknown"
                                coreDataStation.sbiName = (thing["sbi"] as? String) ?? "Unknown"
                                coreDataStation.arName = (thing["ar"] as? String ) ?? "Unknown"
                                coreDataStation.arenName = (thing["aren"] as? String) ?? "Unknown"
                                coreDataStation.latName = (thing["lat"] as? String) ?? "Unknown"
                                coreDataStation.lngName = (thing["lng"] as? String) ?? "Unknown"
                                innerStationArray.append(coreDataStation)
                                self.stationsArray.append(coreDataStation)
                            }
/*                            let stationItem = kSecAttrDescription.insertNewObjectForEntityForName("Station", inManagedObjectContext: self.moc) as! Station
                            stationItem.sna = coreDataStation.stationName
                            stationItem.sarea = coreDataStation.sareaName
                            stationItem.sbi = coreDataStation.sbiName
                            stationItem.ar = coreDataStation.arName
                            stationItem.aren = coreDataStation.arenName
                            stationItem.lat = coreDataStation.latName
                            stationItem.lng = coreDataStation.lngName
                            do {
                                try self.moc.save()
                            }
                            catch {
                                fatalError("failure to save context : \(error)")
                            }
*/
                        }
                        DispatchQueue.main.async(){
                            self.tableView.reloadData()
                        }
                    }
                    catch {print("Error!")}
                }
            }
            task.resume()
        }

    
    }
*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView:UITableView,numberOfRowsInSection section:Int) -> Int {
        return stationsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        let cell: TbiCell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TbiCell
        
        cell.stationNameLabel.text = "\(stationsArray[indexPath.row].sareaName) / \(stationsArray[indexPath.row].stationName)"
        cell.stationPositionLabel.text = stationsArray[indexPath.row].arName
        
        cell.bikeAmountLabel.text = stationsArray[indexPath.row].sbiName
        
        cell.mapButton.addTarget(self, action: #selector(ViewController.MapBtnClicked), for: .touchUpInside)
        
        cell.mapButton.tag = indexPath.row
        
        countAmount = indexPath.row
        
        return cell
    }
    
    
    var latitude = 0.0
    var longtitude = 0.0
    var subtitle = ""
    var stationname = ""
    var stationposition = ""
    var bikeamount = ""
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        latitude = Double(stationsArray[indexPath.row].latName)!
        longtitude = Double(stationsArray[indexPath.row].lngName)!
        subtitle = "\(stationsArray[indexPath.row].sareaName) / \(stationsArray[indexPath.row].stationName)"
        stationname = "\(stationsArray[indexPath.row].sareaName) / \(stationsArray[indexPath.row].stationName)"
        stationposition = stationsArray[indexPath.row].arName
        bikeamount = stationsArray[indexPath.row].sbiName
        cellSelectPath = indexPath
        
        
        self.performSegue(withIdentifier: "cellMyMap", sender:self)
        
        cellSelectPath = indexPath
        
        
    }
    
    func MapBtnClicked(sender:UIButton)  {
        print(stationsArray[sender.tag].latName)
        latitude = Double(stationsArray[sender.tag].latName)!
        print(latitude)
        longtitude = Double(stationsArray[sender.tag].lngName)!
        subtitle = "\(stationsArray[sender.tag].sareaName) / \(stationsArray[sender.tag].stationName)"
        
        self.performSegue(withIdentifier: "showMap", sender: sender)
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showMap" {
            let destinationViewController = segue.destination as? MapViewController
            
            destinationViewController!.mapTitle = subtitle
            destinationViewController!.mapLatitude = latitude
            
            destinationViewController!.mapLongtitude = longtitude
        }
            
        else if segue.identifier == "cellMyMap" {
            let destinationViewController = segue.destination as? CellMapViewController
            
            destinationViewController!.mapTitle = subtitle
            destinationViewController!.mapLatitude = latitude
            destinationViewController!.mapLongtitude = longtitude
            destinationViewController!.mapStationname = stationname
            destinationViewController!.mapStationposition = stationposition
            
            destinationViewController!.mapBikeamount = bikeamount
            
            //            destinationViewController?.hidesBottomBarWhenPushed = true
            //
            //            navigationController?.pushViewController(ViewController, animated: true)
            
            segue.destination.hidesBottomBarWhenPushed = true
            
            //            self.navigationController?.pushViewController(segue.destinationViewController, animated: true)
        }
        
    }


/*
    let appdel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    //let moc = ViewController().managedObjectContext
    
    //coreData
    //coreData
    func fetch() {
        let fetchRequest = NSFetchRequest(entityName: "Station")
        do {
            let results = try moc.executeFetchRequest(fetchRequest) as! [Station]
            
            for result in results {
                print("Product Name: \(result.sbi), Price: \(result.sna)")
                
                var stationReal = stationObject()
                stationReal.stationName = result.sna!
                stationReal.sareaName = result.sarea!
                stationReal.sbiName = result.sbi!
                stationReal.arName = result.ar!
                stationReal.arenName = result.aren!
                stationReal.latName = result.lat!
                stationReal.lngName = result.lng!
                
                
                self.stationsArray.append(stationReal)
                
            }
            DispatchQueue.main.async(execute: { () -> Void in
                self.tableView.reloadData()
                
            })
            
        } catch{
            fatalError()
        }
        
    }
    
    func removeData () {
        // Remove the existing items
        let fetchRequest = NSFetchRequest(entityName: "Station")
        
        do {
            let stationItems = try moc.executeFetchRequest(fetchRequest) as! [Station]
            for stationItem in stationItems {
                moc.deleteObject(stationItem)
            }
            do {
                try moc.save()
            }
        } catch {
            print(error)
        }
        
    }

    
    var lastNewInformationflag = false
*/

}

//
//  MapViewController.swift
//  week_2_part_3
//
//  Created by 許雅筑 on 2016/8/31.
//  Copyright © 2016年 許雅筑. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController{

    func backToPrevious(){
        self.navigationController?.popViewController(animated: true)
    }

    @IBOutlet var myMap: MKMapView!
    var mapLatitude : Double = 0.0
    var mapLongtitude : Double = 0.0
    
    var mapTitle: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        var latitude:CLLocationDegrees = 0.000000
        var longitude:CLLocationDegrees = 0.000000
        let nav = self.navigationController?.navigationBar

        nav?.tintColor = UIColor(red: 251/255, green: 197/255, blue: 111/255, alpha: 1)

        self.navigationItem.title = mapTitle
        latitude = mapLatitude
        longitude = mapLongtitude
        let myposition = CLLocationCoordinate2DMake(latitude, longitude)

        //let myposition = CLLocationCoordinate2D(latitude: mapLatitude, longitude: mapLongtitude)
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegionMake(myposition, span)

        myMap.showsUserLocation = true
        myMap.isZoomEnabled = true

        myMap.setRegion(region,animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = myposition
        myMap.addAnnotation(annotation)

    }

    
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}


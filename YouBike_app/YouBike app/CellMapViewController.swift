//
//  CellMapViewController.swift
//  week_2_part_3
//
//  Created by 許雅筑 on 2016/9/4.
//  Copyright © 2016年 許雅筑. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CellMapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    var mapLatitude : Double = 0.0
    var mapLongtitude : Double = 0.0
    var mapTitle: String = ""
    //for card
    var mapStationname : String = ""
    var mapStationposition: String = ""
    var mapBikeamount: String = ""
    //get user
    var locationManager:CLLocationManager!
    var destination:MKMapItem = MKMapItem()

    var userCoordinate: CLLocationCoordinate2D!
    var myposition:CLLocationCoordinate2D!  //station position


    @IBOutlet var cellMyMap: MKMapView!
    @IBOutlet weak var onlyView: TbiView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let nav = self.navigationController?.navigationBar
        //navigation title
        nav?.tintColor = UIColor(red: 251/255, green: 197/255, blue: 111/255, alpha: 1)
        self.navigationItem.title = mapTitle
        
        //view
        onlyView.bikeAmountLabel.text = mapBikeamount
        onlyView.stationNameLabel.text = mapStationname
        onlyView.stationPositionLabel.text = mapStationposition
    
        //map station position
        myposition = CLLocationCoordinate2D(latitude: mapLatitude, longitude: mapLongtitude)
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegion(center:myposition,span:span)
        
        cellMyMap.showsUserLocation = true
        cellMyMap.isZoomEnabled = true
        
        cellMyMap.setRegion(region,animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = myposition
        cellMyMap.addAnnotation(annotation)
        //route path
        
        // 比較不容易crash
        determineCurrentLocation()
        showDirections()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        determineCurrentLocation()
//        showDirections()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func determineCurrentLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        cellMyMap.showsUserLocation = true
        cellMyMap.delegate = self
        
        userCoordinate = locationManager.location?.coordinate
 
    }


    func showDirections(){
        let request = MKDirectionsRequest()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userCoordinate, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: myposition, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .walking
        let directions = MKDirections(request: request)
        directions.calculate(completionHandler: {response,error in

        guard let unwrappedResponse = response else {return}
        for route in unwrappedResponse.routes{
            self.cellMyMap.add(route.polyline)
            let mapRect:MKMapRect = route.polyline.boundingMapRect
            //control region
            self.cellMyMap.setVisibleMapRect(mapRect,edgePadding:UIEdgeInsets(top: 140.0, left: 140.0, bottom: 140.0, right: 140.0),animated: true)
        
            }
        })
    }
  
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer{

        let polylineRenderer = MKPolylineRenderer(overlay: (overlay as? MKPolyline)!)
        polylineRenderer.strokeColor = UIColor(red: 201/255, green: 28/255, blue: 127/255, alpha: 1)
        polylineRenderer.lineWidth = 9
        return polylineRenderer

    }

    func locationManager(_ manager:CLLocationManager,didUpdateLocations locations:[CLLocation] ){

    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Errors: " + error.localizedDescription)
    }
}

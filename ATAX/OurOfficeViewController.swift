//
//  OurOfficeViewController.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import SafariServices
import MapKit

class OurOfficeViewController: UIViewController {

    @IBOutlet weak var mapViewOffice: MKMapView!
    
    let regionRadius: CLLocationDistance = 1000
    let lat:CLLocationDegrees = 40.877814
    let long:CLLocationDegrees = -73.905283
    
    var manager:CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()

        // Do any additional setup after loading the view.
    }
    
    func setupMapView()
    {
        mapViewOffice.mapType = MKMapType.standard
        mapViewOffice.isZoomEnabled = true
        
        // config
        
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.requestWhenInUseAuthorization()
        
        
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        let span = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007)
        let region = MKCoordinateRegion(center: location, span: span)
        
        mapViewOffice.setRegion(region, animated: false)
        
        let dropPin = MKPointAnnotation()
        dropPin.coordinate = location
        dropPin.title = "5536 Broadway"
        dropPin.subtitle = "Bronx, NY 10463"
        mapViewOffice.addAnnotation(dropPin)
        mapViewOffice.selectAnnotation(dropPin, animated: false)
        
    }
    
    @IBAction func getDirectionAction(_ sender: UIButton) {
        
        let location = CLLocationCoordinate2DMake(lat, long)
        let span = MKCoordinateRegionMakeWithDistance(location, regionRadius, regionRadius)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: span.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: span.span)]
        
        let placeMark = MKPlacemark(coordinate: location)
        let mapItem = MKMapItem(placemark: placeMark)
        mapItem.name = "5536 Broadway, Bronx, NY 10463"
        mapItem.openInMaps(launchOptions: options)
    }
    
    

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendMessageAction(_ sender: Any) {
        
        let contacttaxproVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contacttaxpro") as! ContactTaxProViewController
        
        self.present(contacttaxproVC, animated: true, completion: nil)
    }
    
   
    @IBAction func connectSocial(_ sender: UIButton) {
       
        if sender.tag == 1
        {
            let svc = SFSafariViewController(url: fbLink!, entersReaderIfAvailable: false)
            svc.delegate = self
            self.present(svc, animated: true, completion: nil)
            
        } else if sender.tag == 2
        {
            let svc = SFSafariViewController(url: ttLink!, entersReaderIfAvailable: false)
            svc.delegate = self
            self.present(svc, animated: true, completion: nil)
        }
        else
        {
            let svc = SFSafariViewController(url: youtubeLink!, entersReaderIfAvailable: false)
            svc.delegate = self
            self.present(svc, animated: true, completion: nil)
        }
    
    }
}




extension OurOfficeViewController: SFSafariViewControllerDelegate
{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

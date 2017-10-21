//
//  DetailMapViewController.swift
//  PlistToTableView
//
//  Created by 김종현 on 2017. 10. 6..
//  Copyright © 2017년 김종현. All rights reserved.
//

import UIKit
import MapKit

class DetailMapViewController: UIViewController {
    
    var dTitle: String?
    var dAddress: String?

    @IBOutlet weak var detailMapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("dTitle = \(String(describing: dTitle))")
        print("dAddress = \(String(describing: dAddress))")
        
        // navigation title 설정
        self.title = dTitle
        
        
        // geoCoding
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(dAddress!, completionHandler: { plackmarks, error in
            
            if error != nil {
                print(error!)
            }
            
            if plackmarks != nil {
                let myPlacemark  = plackmarks?[0]
                
                if (myPlacemark?.location) != nil {
                    let myLat = myPlacemark?.location?.coordinate.latitude
                    let myLong = myPlacemark?.location?.coordinate.longitude
                    let center = CLLocationCoordinate2DMake(myLat!, myLong!)
                    let span = MKCoordinateSpanMake(0.05, 0.05)
                    let region = MKCoordinateRegionMake(center, span)
                    self.detailMapView.setRegion(region, animated: true)
                    
                    // Pin 꼽기, title, suttitle
                    let anno = MKPointAnnotation()
                    anno.title = self.dTitle
                    anno.subtitle = self.dAddress
                    anno.coordinate = (myPlacemark?.location?.coordinate)!
                    self.detailMapView.addAnnotation(anno)
                    self.detailMapView.selectAnnotation(anno, animated: true)
                }
            }
            
        } )
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

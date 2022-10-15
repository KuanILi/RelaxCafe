//
//  DetailViewController.swift
//  RelaxCafe
//
//  Created by kuani on 2022/9/27.
//

import UIKit
import SafariServices
import MapKit

class DetailViewController: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var openTime: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var url:URL!
    
    var storeInfo:CoffeeStoreInfo?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeName.text = storeInfo?.name
        addressLabel.text = storeInfo?.address
        if storeInfo?.open_time == ""{
            openTime.text = "尚未提供"
        }
        else{
            openTime.text = storeInfo?.open_time
        }
        
        if let strUrl = storeInfo?.url{
            url = URL(string: strUrl)
        }
        
        /*
         url = URL(string: (storeInfo?.url)!)!
        */
        
        if let latitude = storeInfo?.latitude,let longitude = storeInfo?.longitude{
            let PointAnnotation = MKPointAnnotation()
            PointAnnotation.coordinate = CLLocationCoordinate2D(latitude:Double(latitude)!, longitude:Double(longitude)!)
            PointAnnotation.title = storeInfo?.name
            mapView.setRegion(MKCoordinateRegion(center: PointAnnotation.coordinate, latitudinalMeters: 500, longitudinalMeters: 500), animated: true)
            mapView.addAnnotation(PointAnnotation)
            
        }
        
    }
    
    @IBAction func goTo(_ sender: UIButton) {
        
        if url != nil{
            let safari = SFSafariViewController(url: url)
            safari.delegate = self
            present(safari, animated: true, completion: nil)
        }
        
        else{
            let alert = UIAlertController(title: "商家未提供資訊", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確定", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
          
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func goToCafe(_ sender: Any) {
        if let latitude = storeInfo?.latitude, let longitude = storeInfo?.longitude{
            let toPlacemark = CLLocationCoordinate2D(latitude:Double(latitude)!, longitude:Double(longitude)!)
            let toPin = MKPlacemark(coordinate: toPlacemark)
            let destMapItem = MKMapItem(placemark: toPin)
            let userMapItem = MKMapItem.forCurrentLocation()
            let routes = [userMapItem,destMapItem]
            let option = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
            MKMapItem.openMaps(with: routes, launchOptions: option)
            
             
        }
        
    }
    
}

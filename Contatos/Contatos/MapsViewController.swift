//
//  MapsViewController.swift
//  Contatos
//
//  Created by ios7649 on 04/07/18.
//  Copyright © 2018 ios7649. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let dao = ContatoDAO.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        // Na versao Swift 4 é necessario registrar o Identificador do Pin
        //mapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: mapView)

        locationManager.requestWhenInUseAuthorization()
        
        navigationItem.rightBarButtonItem = MKUserTrackingBarButtonItem(mapView: mapView)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        
        mapView.addAnnotations(dao.findAll())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        mapView.removeAnnotations(mapView.annotations)
    }

}

extension MapsViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // Caso seja o pino do Usuário deve se retornar nulo pois a Apple não permite customizar o pino do usuário
        if annotation is MKUserLocation { return nil }
        
        let identificador = "pin_ID"
        
        let pin = getPin(with: identificador, annotation: annotation)
        
        pin.pinTintColor = UIColor.green
        
        if let contato = annotation as? Contato {
            pin.canShowCallout = true
            let frame = CGRect(x: 0, y: 0, width: 32, height: 32)
            let imageView = UIImageView(frame: frame)
            imageView.image = contato.foto
            imageView.layer.cornerRadius = 16
            imageView.clipsToBounds = true
            pin.leftCalloutAccessoryView = imageView
        }
        
        
        return pin
        
    }
    
    private func getPin(with identificador: String, annotation: MKAnnotation) -> MKPinAnnotationView {
        guard let pin = mapView.dequeueReusableAnnotationView(withIdentifier: identificador) as? MKPinAnnotationView
            else {
                return MKPinAnnotationView(annotation: annotation, reuseIdentifier: identificador)
            }
        return pin
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else {
            return
        }
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05 )
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
    }
}

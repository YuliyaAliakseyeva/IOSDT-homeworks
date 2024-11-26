//
//  MapViewController.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 27.10.24.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var viewModel: MapViewModel?
    var coordinator: MapCoordinator?
    
    let locationManager = CLLocationManager()
    
    let items = [NSLocalizedString("Standart", comment: ""), NSLocalizedString("Satellite", comment: ""), NSLocalizedString("Hybrid", comment: "")]
    
    var annotationSource: MKPointAnnotation?
    var annotationDestination: MKPointAnnotation?
    
    private lazy var map: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    private lazy var routeButton: UIButton = {
        let control = UIButton()
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: items)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupConstreins()
        setupSubviews()
        setupLocationManager()
    }
    
    private func setupView(){
        view.backgroundColor = .lightGray
    }
    
    private func addSubviews() {
        view.addSubview(map)
        view.addSubview(routeButton)
        view.addSubview(segmentedControl)
    }
    
    private func setupConstreins() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            map.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            map.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            map.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            map.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            
            routeButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            routeButton.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: -16),
            routeButton.heightAnchor.constraint(equalToConstant: 45),
            routeButton.widthAnchor.constraint(equalToConstant: 45),
            
            segmentedControl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            segmentedControl.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 30)
            
            
        ])
    }
    
    private func setupSubviews() {
        let iconRoute = UIImage(named: "IconRoute")
        routeButton.setBackgroundImage(iconRoute, for: .normal)
        routeButton.backgroundColor = .white
        routeButton.clipsToBounds = true
        routeButton.layer.cornerRadius = 15
        routeButton.layer.borderWidth = 2
        routeButton.layer.borderColor = UIColor.lightGray.cgColor
        routeButton.addTarget(self, action: #selector(routeCreated), for: .touchUpInside)
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(selectedMapType), for: .valueChanged)
        
    }
    
    private func setupLocationManager() {
        map.showsUserLocation = true
        map.showsUserTrackingButton = true
        map.delegate = self
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        map.addGestureRecognizer(longPress)
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    @objc func selectedMapType(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            map.mapType = .standard
            print("\(map.mapType)")
        case 1:
            map.mapType = .satellite
            print("\(map.mapType)")
        case 2:
            map.mapType = .hybrid
            print("\(map.mapType)")
        default:
            print("Not found map type")
        }
    }
    
    @objc func longPressed(_ gr: UILongPressGestureRecognizer) {
        let point = gr.location(in: map)
        let location = map.convert(point, toCoordinateFrom: map)
        
        
        if annotationDestination == nil {
            annotationDestination = MKPointAnnotation()
            annotationDestination?.coordinate = location
            annotationDestination?.title = "Destination"
            map.addAnnotation(annotationDestination!)
        } else {
            map.removeAnnotation(annotationDestination!)
            annotationDestination = MKPointAnnotation()
            annotationDestination?.coordinate = location
            annotationDestination?.title = "Destination"
            map.addAnnotation(annotationDestination!)
        }
    }
    
    @objc func routeCreated() {
       
        guard let annotationSource, let annotationDestination else {
            return
        }
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: annotationSource.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: annotationDestination.coordinate))
        
        let direction = MKDirections(request: request)
        
        direction.calculate { [weak self] response, error in
            if let response, let route = response.routes.first {
                self?.map.addOverlay(route.polyline)
                self?.map.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
            
        }
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .blue
            renderer.lineWidth = 5
            return renderer
        }
        
        return MKOverlayRenderer()
    }
}


extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            goToCenter(location: location)
            annotationSource = MKPointAnnotation()
            annotationSource?.coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            annotationSource?.title = "Source"
            map.addAnnotation(annotationSource!)
            
        }
    }
    
    func goToCenter(location: CLLocation) {
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 5000, longitudinalMeters: 5000)
        map.setRegion(region, animated: true)
        
    }
}


// MARK: Практика по материалам лекции

//class MapViewController: UIViewController {
//
//    var viewModel: MapViewModel?
//    var coordinator: MapCoordinator?
//
//    let locationManager = CLLocationManager()
//
//    let items = ["Стандарт", "Спутник", "Гибрид"]
//
//    private lazy var map: MKMapView = {
//        let map = MKMapView()
//        map.translatesAutoresizingMaskIntoConstraints = false
//        return map
//    }()
//
//    private lazy var segmentedControl: UISegmentedControl = {
//        let control = UISegmentedControl(items: items)
//        control.translatesAutoresizingMaskIntoConstraints = false
//        return control
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        addSubviews()
//        setupConstreins()
//        setupSubviews()
//        setupLocationManager()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        setRegion()
//    }
//
//    private func setupView(){
//        view.backgroundColor = .systemBackground
//    }
//
//    private func addSubviews() {
//        view.addSubview(map)
//        view.addSubview(segmentedControl)
//    }
//
//    private func setupConstreins() {
//        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
//        NSLayoutConstraint.activate([
//            map.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            map.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
//            map.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
//            map.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
//
//            segmentedControl.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            segmentedControl.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            segmentedControl.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
//            segmentedControl.heightAnchor.constraint(equalToConstant: 30)
//
//
//        ])
//    }
//
//    private func setupSubviews() {
//
//        segmentedControl.selectedSegmentIndex = 0
//        segmentedControl.addTarget(self, action: #selector(selectedMapType), for: .valueChanged)
//
//    }
//
//    private func setupLocationManager() {
//        map.showsUserLocation = true
//        map.showsUserTrackingButton = true
//
//        locationManager.requestWhenInUseAuthorization()
////        locationManager.delegate = self
//        locationManager.startUpdatingLocation()
//
//        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
//        map.addGestureRecognizer(longPress)
//
//    }
//
//    // MARK: Отображение конкретного участка на карте
//    private func setRegion() {
////        54,5081 северной широты и 30,4172 восточной долготы
////        53,9 северной широты и 27,5667 восточной долготы
//        let center = CLLocationCoordinate2D(latitude: 54.5081, longitude: 30.4172)
//        let region = MKCoordinateRegion(center: center, latitudinalMeters: 5000, longitudinalMeters: 5000)
//        map.setRegion(region, animated: true)
//        addAnnotation(coordinate: center, title: "Орша")
//    }
//
//    func addAnnotation(coordinate: CLLocationCoordinate2D, title: String) {
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = coordinate
//        annotation.title = title
//        map.addAnnotation(annotation)
//    }
//
//    @objc func selectedMapType(sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            map.mapType = .standard
//            print("\(map.mapType)")
//        case 1:
//            map.mapType = .satellite
//            print("\(map.mapType)")
//        case 2:
//            map.mapType = .hybrid
//            print("\(map.mapType)")
//        default:
//            print("Not found map type")
//        }
//    }
//
//    @objc func longPressed(_ gr: UILongPressGestureRecognizer) {
//        let point = gr.location(in: map)
//        let location = map.convert(point, toCoordinateFrom: map)
//        addAnnotation(coordinate: location, title: "Destination")
//    }
//
//}
//
//
//extension MapViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.first {
//            goToCenter(location: location)
//
//        }
//    }
//
//    func goToCenter(location: CLLocation) {
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
//        map.setRegion(region, animated: true)
//
//    }
//}
//

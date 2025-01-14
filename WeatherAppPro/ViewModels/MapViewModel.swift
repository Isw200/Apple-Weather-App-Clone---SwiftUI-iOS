//
//  MapViewModel.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-21.
//

import Foundation
import CoreLocation
import MapKit
import SwiftUI
import Network

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    private let networkMonitor = NWPathMonitor()
    private let networkQueue = DispatchQueue(label: "NetworkMonitor")

    @Published var userLocation: CLLocationCoordinate2D?
    @Published var selectedCity: CityModel?
    @Published var isShowCitiesOpen: Bool = false
    @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.457105, longitude: -80.508361), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @Published var userDesiredRegion: MKCoordinateRegion?
    @Published var userCity: CityModel?
    @Published var isLocationEnabled: Bool = true
    @Published var isInternetAvailable: Bool = true

    var binding: Binding<MKCoordinateRegion> {
        Binding {
            self.mapRegion
        } set: {
            self.mapRegion = $0
        }
    }
    
    func checkIfLocationIsEnabled() async {
        if CLLocationManager.locationServicesEnabled() {
            DispatchQueue.main.async {
                self.isLocationEnabled = true
            }
            locationManager = CLLocationManager()
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.delegate = self
            locationManager?.requestWhenInUseAuthorization()
        } else {
            DispatchQueue.main.async {
                self.isLocationEnabled = false
            }
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            DispatchQueue.main.async {
                self.isLocationEnabled = false
            }
        case .authorizedAlways, .authorizedWhenInUse:
            DispatchQueue.main.async {
                self.isLocationEnabled = true
            }
            if let location = manager.location {
                DispatchQueue.main.async {
                    self.mapRegion = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
                }
            }
        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        DispatchQueue.main.async {
            self.userLocation = location.coordinate
        }
    }

    func centerOnUserLocation() {
        guard let userLocation = locationManager?.location else {
            print("Couldn't get user location")
            return
        }
        userDesiredRegion = MKCoordinateRegion(
            center: userLocation.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }

    func generateCityModelForUserLocation(completion: @escaping (CityModel?) -> Void) {
        guard let userLocation = locationManager?.location else {
            completion(nil)
            return
        }
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { placemarks, error in
            if let _ = error {
                completion(nil)
                return
            }
            guard let placemark = placemarks?.first else {
                completion(nil)
                return
            }
            let cityName = placemark.locality ?? "Unknown City"
            let country = placemark.isoCountryCode ?? "Unknown"
            let timeZoneOffset = TimeZone.current.secondsFromGMT() / 3600
            let cityModel = CityModel(
                id: generateCityId(lat: userLocation.coordinate.latitude, lon: userLocation.coordinate.longitude),
                name: cityName,
                lat: userLocation.coordinate.latitude,
                lon: userLocation.coordinate.longitude,
                timeZoneOffset: Double(timeZoneOffset),
                country: country,
                cityWeather: nil
            )
            completion(cityModel)
        }
    }
    
    func setupNetworkMonitor() {
        networkMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isInternetAvailable = (path.status == .satisfied)
            }
        }
        networkMonitor.start(queue: networkQueue)
    }
}

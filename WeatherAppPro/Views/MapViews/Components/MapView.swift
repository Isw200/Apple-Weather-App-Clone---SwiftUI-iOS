//
//  MapView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @ObservedObject var citiesVM: CitiesViewModel
    @ObservedObject var settingsVM: SettingsViewModel
    @ObservedObject var mapVM: MapViewModel
    @Binding var selectedLayerType: WeatherOverlayType
    @Binding var isShowMapView: Bool

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        addWeatherOverlay(to: mapView)
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        context.coordinator.selectedLayerType = selectedLayerType
        uiView.removeAnnotations(uiView.annotations)

        for city in citiesVM.cities {
            let annotation = CustomAnnotation(
                city: city,
                coordinate: CLLocationCoordinate2D(latitude: city.lat, longitude: city.lon),
                isUserLocation: false,
                citiesVM: citiesVM
            )
            uiView.addAnnotation(annotation)
        }

        if let userLocation = mapVM.userLocation {
            let userAnnotation = CustomAnnotation(
                city: nil,
                coordinate: userLocation,
                isUserLocation: true,
                citiesVM: citiesVM
            )
            uiView.addAnnotation(userAnnotation)
        }

        if let userDesiredRegion = mapVM.userDesiredRegion {
            uiView.setRegion(userDesiredRegion, animated: true)
        } else if let selectedCity = mapVM.selectedCity {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: selectedCity.lat, longitude: selectedCity.lon),
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            )
            uiView.setRegion(region, animated: true)
        }

        uiView.overlays.forEach { overlay in
            if overlay is MKTileOverlay {
                uiView.removeOverlay(overlay)
            }
        }
        let overlayURLTemplate = mapOverlayEndPoint(selectedLayerType: selectedLayerType)
        let tileOverlay = MKTileOverlay(urlTemplate: overlayURLTemplate)
        tileOverlay.canReplaceMapContent = false
        uiView.addOverlay(tileOverlay)

        context.coordinator.selectedLayerType = selectedLayerType
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self, selectedLayerType: selectedLayerType)
    }

    private func addWeatherOverlay(to mapView: MKMapView) {
        let overlayURLTemplate = mapOverlayEndPoint(selectedLayerType: selectedLayerType)
        let tileOverlay = MKTileOverlay(urlTemplate: overlayURLTemplate)
        tileOverlay.canReplaceMapContent = false
        mapView.addOverlay(tileOverlay)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        var selectedLayerType: WeatherOverlayType

        init(_ parent: MapView, selectedLayerType: WeatherOverlayType) {
            self.parent = parent
            self.selectedLayerType = selectedLayerType
        }

        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let tileOverlay = overlay as? MKTileOverlay {
                return MKTileOverlayRenderer(overlay: tileOverlay)
            }
            return MKOverlayRenderer(overlay: overlay)
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let annotation = annotation as? CustomAnnotation else { return nil }

            let identifier = annotation.isUserLocation ? "UserLocationAnnotation" : "CityAnnotation"
            var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            if view == nil {
                view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view?.canShowCallout = false
            }

            var value: Double = 0
            if !annotation.isUserLocation {
                switch selectedLayerType {
                case .clouds_new:
                    value = annotation.city?.cityWeather?.clouds ?? 0
                case .precipitation_new:
                    value = annotation.city?.cityWeather?.humidity ?? 0
                case .pressure_new:
                    value = annotation.city?.cityWeather?.pressure ?? 0
                case .wind_new:
                    value = annotation.city?.cityWeather?.windSpeed ?? 0
                case .temp_new:
                    value = annotation.city?.cityWeather?.temp ?? 0
                }
            }

            let annotationView = UIHostingController(
                rootView: CustomAnnotationView(
                    cityName: annotation.city?.name ?? "You",
                    value: value,
                    isUserLocation: annotation.isUserLocation,
                    city: annotation.city,
                    citiesVM: annotation.citiesVM,
                    // Pass the parent's Binding here
                    isShowMapView: parent.$isShowMapView
                )
            )
            annotationView.view.backgroundColor = UIColor.clear
            annotationView.view.frame = CGRect(x: 0, y: 0, width: 60, height: 60)

            view?.subviews.forEach { $0.removeFromSuperview() }
            view?.addSubview(annotationView.view)
            view?.frame = annotationView.view.frame
            return view
        }
    }
}

class CustomAnnotation: NSObject, MKAnnotation {
    let city: CityModel?
    let isUserLocation: Bool
    var coordinate: CLLocationCoordinate2D
    let citiesVM: CitiesViewModel

    init(city: CityModel?, coordinate: CLLocationCoordinate2D, isUserLocation: Bool = false, citiesVM: CitiesViewModel) {
        self.city = city
        self.coordinate = coordinate
        self.isUserLocation = isUserLocation
        self.citiesVM = citiesVM
        super.init()
    }
}

struct CustomAnnotationView: View {
    let cityName: String
    let value: Double
    let isUserLocation: Bool
    let city: CityModel?
    @ObservedObject var citiesVM: CitiesViewModel
    @Binding var isShowMapView: Bool

    var body: some View {
        VStack {
            Button {
                if let city = city {
                    citiesVM.selectedCity = city
                    citiesVM.slectedCityId = city.id
                }
                isShowMapView = false
            } label: {
                ZStack {
                    Circle()
                        .fill(.white)
                        .frame(width: 36, height: 36)
                    Circle()
                        .fill(.blue)
                        .frame(width: 30, height: 30)
                        .shadow(radius: 1)
                    VStack(spacing: 4) {
                        Text("\(Int(value))")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.white)
                    }
                }
                if !isUserLocation {
                    Text(cityName)
                        .font(.caption)
                        .foregroundColor(.white)
                        .shadow(radius: 1)
                }
            }
        }
    }
}

#Preview {
    MapView(
        citiesVM: CitiesViewModel(),
        settingsVM: SettingsViewModel(),
        mapVM: MapViewModel(),
        selectedLayerType: .constant(.temp_new),
        isShowMapView: .constant(true)
    )
}

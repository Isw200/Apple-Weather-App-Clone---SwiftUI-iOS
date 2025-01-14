//
//  MainViewModel.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-05.
//

import Foundation
import CoreLocation

@MainActor
class CitiesViewModel : ObservableObject {
    @Published var selectedCity : CityModel = colomboCity
    @Published var slectedCityId: String = colomboCity.id
    @Published var cities : [CityModel] = []
    @Published var searchText: String = ""
    @Published var searchResults: [CityModel] = []
    @Published var tempSelectedCity : CityModel?
    @Published var isSheetPresented: Bool = false
    @Published var isSeachablePresented: Bool = false
    @Published var userCity: CityModel?
    @Published var error: Bool = false
    
    private let geocoder = CLGeocoder()
        
    func getLocationDetails(for locationName: String, completion: @escaping (String, Double, Double, Double?) -> Void) {
        geocoder.geocodeAddressString(locationName) { placemarks, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(locationName, 0, 0, nil)
                return
            }
            
            if let placemark = placemarks?.first,
               let location = placemark.location {
                
                let name = placemark.locality ?? locationName
                let lat = location.coordinate.latitude
                let lon = location.coordinate.longitude
                let timeZoneOffset = (placemark.timeZone?.secondsFromGMT()).map { Double($0) / 3600.0 }
                guard let timeZoneOffset else { return }
                
                completion(name, lat, lon, timeZoneOffset)
            } else {
                completion(locationName, 0, 0, nil)
            }
        }
    }
    
    func searchForLocations(_ query: String) {
        searchResults.removeAll()

        guard !query.isEmpty else { return }

        geocoder.geocodeAddressString(query) { placemarks, error in
            if let error = error {
                print("Geocode error: \(error.localizedDescription)")
                return
            }

            guard let placemarks = placemarks, !placemarks.isEmpty else {
                print("No placemarks found for query: \(query)")
                return
            }

            let results = placemarks.compactMap { pm -> CityModel? in
                guard let loc = pm.location else { return nil }
                let name = pm.locality ?? pm.name ?? query
                let lat = loc.coordinate.latitude
                let lon = loc.coordinate.longitude
                let timeZoneOffset = (pm.timeZone?.secondsFromGMT()).map { Double($0) / 3600.0 } ?? 0.0

                return CityModel(
                    id: generateCityId(lat: lat, lon: lon),
                    name: name,
                    lat: lat,
                    lon: lon,
                    timeZoneOffset: timeZoneOffset,
                    country: pm.country,
                    cityWeather: nil
                )
            }

            DispatchQueue.main.async {
                self.searchResults = results
            }
        }
    }
    
    func dismissSearch() {
        searchText = ""
        searchResults.removeAll()
        tempSelectedCity = nil
        isSheetPresented = false
    }
    
    func fetchCityWeather(cityId: String, units: WeatherUnit) async {
        guard let city = cities.first(where: { $0.id == cityId }) else { return }
        
        DispatchQueue.main.async {
            if let index = self.cities.firstIndex(where: { $0.id == cityId }) {
                self.cities[index].isLoading = true
            }
        }
        
        let url = URL(string: cityCurrentWeatherEndPoint(lat: city.lat, lon: city.lon, unit: units))
        guard let unwrappedUrl = url else {
            DispatchQueue.main.async {
                if let index = self.cities.firstIndex(where: { $0.id == cityId }) {
                    self.cities[index].isLoading = false
                }
            }
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: unwrappedUrl)
            guard let response = response as? HTTPURLResponse else {
                if let index = self.cities.firstIndex(where: { $0.id == cityId }) {
                    self.cities[index].isLoading = false
                }
                print("Error in response: \(response)")
                self.error = true
                return
            }
            
            switch response.statusCode {
                case 200:
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    let cityWeatherResponse = try decoder.decode(CityWeatherResponse.self, from: data)
                
                    DispatchQueue.main.async {
                        if let index = self.cities.firstIndex(where: { $0.id == city.id }) {
                            var updatedCity = self.cities[index]
                            updatedCity.cityWeather = CityWeatherModel(from: cityWeatherResponse)
                            updatedCity.isLoading = false
                            self.cities[index] = updatedCity
                        }
                    }
                case 400...599 :
                    self.error = true
                    print("Error: \(response.statusCode)")
                default:
                    DispatchQueue.main.async {
                        if let index = self.cities.firstIndex(where: { $0.id == cityId }) {
                            self.cities[index].isLoading = false
                        }
                    }
                    self.error = true
                    print("Error: \(response.statusCode)")
            }

            
        } catch {
            DispatchQueue.main.async {
                if let index = self.cities.firstIndex(where: { $0.id == cityId }) {
                    self.cities[index].isLoading = false
                }
            }
            self.error = true
            print("Error: \(error)")
        }
    }
    
    func fetchCitieWeather(units: WeatherUnit) async {
        if cities.isEmpty { return }
        for city in cities {
            await fetchCityWeather(cityId: city.id, units: units)
        }
    }
}

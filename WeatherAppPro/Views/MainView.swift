//
//  ContentView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-04.
//

import SwiftUI

struct MainView: View {
    @FetchRequest(sortDescriptors: []) var savedCities: FetchedResults<CityEntity>
    @StateObject var citiesVM: CitiesViewModel = CitiesViewModel()
    @StateObject var settingsVM: SettingsViewModel = SettingsViewModel()
    @StateObject var mapVM: MapViewModel = MapViewModel()
    @State private var isLoading = true

    private func updateCities() {
        citiesVM.cities = savedCities.map { cityEntity in
            CityModel(
                id: generateCityId(lat: cityEntity.lat, lon: cityEntity.lon),
                name: cityEntity.name ?? "Unknown City",
                lat: cityEntity.lat,
                lon: cityEntity.lon,
                timeZoneOffset: cityEntity.timeZoneOffset,
                country: cityEntity.country,
                cityWeather: nil
            )
        }
        
        mapVM.generateCityModelForUserLocation { city in
            DispatchQueue.main.async {
                if let userCity = city {
                    mapVM.userCity = userCity
                    citiesVM.userCity = userCity
                    if !citiesVM.cities.contains(where: { $0.id == userCity.id }) {
                        citiesVM.cities.insert(userCity, at: 0)
                    }
                    if citiesVM.slectedCityId == colomboCity.id {
                        citiesVM.selectedCity = userCity
                        citiesVM.slectedCityId = userCity.id
                    }
                }
                isLoading = false
            }
        }
    }

    var body: some View {
        ZStack {
            NavigationStack {
                ZStack {
                    if settingsVM.darkMode {
                        Color.black.ignoresSafeArea()
                    } else {
                        Color.white.ignoresSafeArea()
                    }
                    
                    if citiesVM.cities.isEmpty && isLoading {
                        VStack {
                            ProgressView()
                            Text("Loading...")
                                .font(.headline)
                                .foregroundColor(settingsVM.darkMode ? Color.white : Color.black)
                        }
                    } else {
                        if !citiesVM.cities.isEmpty {
                            TabView(selection: $citiesVM.slectedCityId) {
                                ForEach(citiesVM.cities, id: \.self.id) { city in
                                    WeatherView(city: city, units: $settingsVM.unit, darkMode: $settingsVM.darkMode)
                                        .tag(city.id)
                                }
                            }
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .ignoresSafeArea(.all)
                        } else {
                            if (mapVM.userCity == nil) {
                                ZStack(alignment: .top) {
                                    TabView(selection: $citiesVM.slectedCityId) {
                                        ForEach([londonCity], id: \.self.id) { city in
                                            WeatherView(city: city, units: $settingsVM.unit, darkMode: $settingsVM.darkMode)
                                                .tag(city.id)
                                        }
                                    }
                                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                                    .ignoresSafeArea(.all)
                                    
                                    Text("Pull down to refresh")
                                        .font(.system(size: 16))
                                        .foregroundStyle(.white)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 10)
                                        .background(Color.black.opacity(0.5))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .padding()
                                        .padding(.top, 50)
                                }
                            }
                        }

                        VStack {
                            Spacer()

                            HStack {
                                NavigationLink(destination: MapContainerView(citiesVM: citiesVM, settingsVM: settingsVM, mapVM: mapVM)) {
                                    Image(systemName: "map")
                                        .foregroundColor(.white)
                                        .font(.system(size: 24, weight: .medium))
                                }

                                Spacer()

                                HStack(spacing: 8) {
                                    ForEach(citiesVM.cities, id: \.self.id) { city in
                                        Button {
                                            withAnimation {
                                                citiesVM.selectedCity = city
                                                citiesVM.slectedCityId = city.id
                                            }
                                        } label: {
                                            if city.id == citiesVM.cities.first?.id && citiesVM.userCity != nil {
                                                Image(systemName: "location.fill")
                                                    .resizable()
                                                    .foregroundColor(citiesVM.slectedCityId == city.id
                                                                     ? .white : .gray.opacity(0.5))
                                                    .frame(width: 12, height: 12)
                                            } else {
                                                Circle()
                                                    .foregroundColor(citiesVM.slectedCityId == city.id
                                                                     ? .white : .gray.opacity(0.5))
                                                    .frame(width: 10, height: 10)
                                            }
                                        }
                                    }
                                }

                                Spacer()
                                
                                NavigationLink(destination: AllLocationsView(citiesVM: citiesVM, settingsVM: settingsVM)) {
                                    Image(systemName: "list.bullet")
                                        .foregroundColor(.white)
                                        .font(.system(size: 24, weight: .medium))
                                }
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .padding(.bottom, 5)
                            .frame(height: 90)
                            .background(
                                ZStack {
                                    BlurView(darkMode: $settingsVM.darkMode)
                                }
                            )
                        }
                    }
                }
                .ignoresSafeArea(.all)
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
                .onAppear {
                    Task {
                        await mapVM.checkIfLocationIsEnabled()
                        updateCities()
                        mapVM.setupNetworkMonitor()
                    }
                }
            }
            .tint(Color(settingsVM.darkMode ? .white: .black))
            .preferredColorScheme(settingsVM.darkMode ? .dark : .light)
            
            if !mapVM.isInternetAvailable {
                InternetUnavailableView(mapVM: mapVM)
            }

            if !mapVM.isLocationEnabled {
                LocationUnavailableView()
            }
            
            if citiesVM.error {
                NetworkErrorView()
            }
        }
        .refreshable {
            updateCities()
        }
    }
}


#Preview {
    MainView()
}


//
//  MapContainerView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-24.
//

import SwiftUI
import MapKit

struct MapContainerView: View {
    @ObservedObject var citiesVM: CitiesViewModel
    @ObservedObject var settingsVM: SettingsViewModel
    @ObservedObject var mapVM: MapViewModel
    @State var selectedLayerType: WeatherOverlayType = .temp_new
    @State var showLayerSelection: Bool = false
    @Environment(\.dismiss) var dismiss
    @State var isShowMapView: Bool = true

    var body: some View {
        NavigationStack {
            ZStack(alignment: .topTrailing) {
                MapView(citiesVM: citiesVM, settingsVM: settingsVM, mapVM: mapVM, selectedLayerType: $selectedLayerType, isShowMapView: $isShowMapView)
                    .edgesIgnoringSafeArea(.all)

                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Done")
                                .font(.headline)
                        }
                        .padding(10)
                        .background(.buttonGray)
                        .foregroundStyle(settingsVM.darkMode ? Color.white : Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        showLevels(selectedLayerType: selectedLayerType, darkMode: settingsVM.darkMode)
                    }
                    .padding(.leading, 16)
                    .zIndex(1)
                    
                    Spacer()
                    
                    VStack{
                        VStack {
                            Button {
                                mapVM.centerOnUserLocation()
                            } label: {
                                ZStack {
                                    Image(systemName: "location.fill")
                                        .font(.title2)
                                }
                            }
                            .padding(.horizontal, 10)
                            .padding(.top, 15)
                            .padding(.bottom, 5)
                            
                            Divider()
                                .frame(width: 20, height: 1)
                                .background(.buttonGray)
                                .padding(0)
                            
                            Button {
                                mapVM.isShowCitiesOpen.toggle()
                            } label: {
                                ZStack {
                                    Image(systemName: "list.bullet")
                                        .font(.title2)
                                }
                            }
                            .padding(10)
                            .padding(.bottom, 5)
                        }
                        .background(.buttonGray)
                        .foregroundStyle(settingsVM.darkMode ? Color.white : Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        Menu {
                            ForEach(WeatherOverlayType.allCases, id: \.self) { overlay in
                                Button{
                                    selectedLayerType = overlay
                                } label: {
                                    HStack {
                                        Text("\(overlay.rawValue)")
                                        if overlay == selectedLayerType {
                                            Image(systemName: "checkmark")
                                        } else {
                                            Image(systemName: getOverlayIocn(overlay: overlay))
                                        }
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: "square.3.layers.3d")
                                .foregroundStyle(Color(settingsVM.darkMode ? .white : .black))
                                .font(.title2)
                        }
                        .padding(10)
                        .background(.buttonGray)
                        .foregroundStyle(settingsVM.darkMode ? Color.white : Color.black)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    }
                    .padding(.trailing, 16)
                }
            }
            .sheet(isPresented: $mapVM.isShowCitiesOpen) {
                VStack {
                    HStack {
                        HStack {
                            Image(systemName: getOverlayIocn(overlay: selectedLayerType))
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25)
                                .padding(.trailing, 5)
                            
                            VStack(alignment: .leading) {
                                Text("\(selectedLayerType.rawValue)")
                                    .foregroundStyle(settingsVM.darkMode ? Color.white : Color.black)
                                    .font(.system(size: 23, weight: .semibold))
                                Text("Your Locations")
                                    .foregroundStyle(.gray)
                                    .font(.system(size: 14))
                            }
                        }
                        Spacer()
                        Button {
                            mapVM.isShowCitiesOpen = false
                        } label: {
                            Image(systemName: "xmark")
                        }
                        .foregroundStyle(settingsVM.darkMode ? Color.white : Color.black)
                        .padding(10)
                        .background(.white.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                    }
                    .padding(.horizontal)
                    .padding(.top)

                    List(citiesVM.cities, id: \.id) { city in
                        Button {
                            mapVM.selectedCity = city
                            mapVM.userDesiredRegion = nil
                            mapVM.isShowCitiesOpen = false
                        } label: {
                            Text(city.name)
                        }
                    }
                    Spacer()
                }
                .presentationDetents([.fraction(0.5)])
                .clipShape(RoundedRectangle(cornerRadius: 30))
            }
            .onAppear {
                if mapVM.selectedCity == nil {
                    mapVM.selectedCity = citiesVM.cities.first ?? londonCity
                }
                Task {
                    await citiesVM.fetchCitieWeather(units: settingsVM.unit)
                }
            }
            .onAppear {
                Task {
                    await mapVM.checkIfLocationIsEnabled()
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .onChange(of: isShowMapView) {
                if !isShowMapView {
                    dismiss()
                }
            }
        }
    }
}

private func showLevels(selectedLayerType: WeatherOverlayType, darkMode: Bool) -> some View {
    switch selectedLayerType {
    case .clouds_new:
        return AnyView(
            VStack(alignment: .leading) {
                Text("Clouds %")
                    .font(.system(size: 14, weight: .medium))
                
                Divider()
                    .frame(width: 100, height: 1)
                
                HStack {
                    LinearGradient(
                        gradient: Gradient(colors: [.gray, .white]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(width: 8, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack(alignment: .leading) {
                        Text("0")
                        Spacer()
                        Text("25")
                        Spacer()
                        Text("50")
                        Spacer()
                        Text("75")
                        Spacer()
                        Text("100")
                    }
                    .font(.system(size: 12, weight: .medium))
                }
                .frame(height: 120)
            }
            .padding(10)
            .background(.buttonGray)
            .foregroundStyle(darkMode ? Color.white : Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        )
    case .precipitation_new:
        return AnyView(
            VStack(alignment: .leading) {
                Text("Precipitation mm/h")
                    .font(.system(size: 14, weight: .medium))
                
                Divider()
                    .frame(width: 100, height: 1)
                
                HStack {
                    LinearGradient(
                        gradient: Gradient(colors: [.purple, .red, .orange, .yellow, .white, .lightBlue, .green, .green]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(width: 8, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack(alignment: .leading) {
                        Text("0")
                        Spacer()
                        Text("0.5")
                        Spacer()
                        Text("1")
                        Spacer()
                        Text("2")
                        Spacer()
                        Text("10")
                        Spacer()
                        Text("14")
                        Spacer()
                        Text("24")
                        Spacer()
                        Text("32")
                        Spacer()
                        Text("60")
                    }
                    .font(.system(size: 12, weight: .medium))
                }
                .frame(height: 200)
            }
            .padding(10)
            .background(.buttonGray)
            .foregroundStyle(darkMode ? Color.white : Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        )
    case .pressure_new:
        return AnyView(
            VStack(alignment: .leading) {
                Text("Pressure hPa")
                    .font(.system(size: 14, weight: .medium))
                
                Divider()
                    .frame(width: 100, height: 1)
                
                HStack {
                    LinearGradient(
                        gradient: Gradient(colors: [.red, .red, .orange, .yellow, .green, .lightBlue, .blue]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(width: 8, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack(alignment: .leading) {
                        Text("950")
                        Spacer()
                        Text("980")
                        Spacer()
                        Text("1010")
                        Spacer()
                        Text("1040")
                        Spacer()
                        Text("1070")
                    }
                    .font(.system(size: 12, weight: .medium))
                }
                .frame(height: 120)
            }
            .padding(10)
            .background(.buttonGray)
            .foregroundStyle(darkMode ? Color.white : Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        )
    case .temp_new:
        return AnyView(
            VStack(alignment: .leading) {
                Text("Temperature °C")
                    .font(.system(size: 14, weight: .medium))
                
                Divider()
                    .frame(width: 100, height: 1)
                
                HStack {
                    LinearGradient(
                        gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue, .purple]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(width: 8, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack(alignment: .leading) {
                        Text("-40")
                        Spacer()
                        Text("-20")
                        Spacer()
                        Text("0")
                        Spacer()
                        Text("20")
                        Spacer()
                        Text("40")
                    }
                    .font(.system(size: 12, weight: .medium))
                }
                .frame(height: 120)
            }
            .padding(10)
            .background(.buttonGray)
            .foregroundStyle(darkMode ? Color.white : Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        )
    case .wind_new:
        return AnyView(
            VStack(alignment: .leading) {
                Text("Wind Speed m/s")
                    .font(.system(size: 14, weight: .medium))
                
                Divider()
                    .frame(width: 110, height: 1)
                
                HStack {
                    LinearGradient(
                        gradient: Gradient(colors: [.purple, .white]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                    .frame(width: 8, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack(alignment: .leading) {
                        Text("0")
                        Spacer()
                        Text("25")
                        Spacer()
                        Text("50")
                        Spacer()
                        Text("75")
                        Spacer()
                        Text("100")
                    }
                    .font(.system(size: 12, weight: .medium))
                }
                .frame(height: 120)
            }
            .padding(10)
            .background(.buttonGray)
            .foregroundStyle(darkMode ? Color.white : Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        )
    }
}


#Preview {
    MapContainerView(citiesVM: CitiesViewModel(), settingsVM: SettingsViewModel(), mapVM: MapViewModel())
}


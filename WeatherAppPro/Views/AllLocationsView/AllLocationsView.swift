//
//  AllLocationsView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-06.
//

import SwiftUI

struct AllLocationsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: []) var savedCities: FetchedResults<CityEntity>
    @ObservedObject var citiesVM : CitiesViewModel
    @ObservedObject var settingsVM : SettingsViewModel
    @State var focused : Bool = false
    @Environment(\.dismiss) var dismiss
    @Environment(\.editMode) private var editMode
    @State var showSettings : Bool = false
    @State var showUnitSettings : Bool = false
    @State var showReport : Bool = false
    
    func saveCity() {
        guard let city = citiesVM.tempSelectedCity else { return }
        
        if isCityAlreadySaved(city) {
            print("City is already saved.")
            citiesVM.dismissSearch()
            focused = false
            citiesVM.isSeachablePresented = false
            return
        }
        
        let newCity = CityEntity(context: managedObjectContext)
        newCity.id = city.id
        newCity.name = city.name
        newCity.lat = city.lat
        newCity.lon = city.lon
        newCity.timeZoneOffset = city.timeZoneOffset
        newCity.country = city.country
        
        do {
            try managedObjectContext.save()
            citiesVM.dismissSearch()
            focused = false
            citiesVM.isSeachablePresented = false
            citiesVM.cities.append(city)
        } catch {
            print("Error saving city: \(error)")
        }
    }

    private func isCityAlreadySaved(_ city: CityModel) -> Bool {
        return savedCities.contains { $0.id == city.id }
    }
    
    func moveCity(from source: IndexSet, to destination: Int) {
        citiesVM.cities.move(fromOffsets: source, toOffset: destination)
    }
    
    private func toggleEditMode() {
        withAnimation {
            editMode?.wrappedValue = editMode?.wrappedValue == .active ? .inactive : .active
        }
    }
    
    func deleteCity(at offsets: IndexSet) {
        offsets.forEach { index in
            let city = citiesVM.cities[index]

            if let cityEntity = savedCities.first(where: { $0.id == city.id }) {
                managedObjectContext.delete(cityEntity)
                do {
                    try managedObjectContext.save()
                } catch {
                    print("Error deleting city from Core Data: \(error)")
                }
            }

            citiesVM.cities.remove(at: index)
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                if !citiesVM.isSeachablePresented {
                    List {
                        ForEach(citiesVM.cities, id: \.id) { city in
                            HStack {
                                Button(action: {
                                    citiesVM.selectedCity = city
                                    citiesVM.slectedCityId = city.id
                                    dismiss()
                                }) {
                                    CityViewRowView(city: city, citiesVM: citiesVM)
                                }
                            }
                            .listRowInsets(EdgeInsets(top: 4, leading: 15, bottom: 4, trailing: 15))
                            .listStyle(.plain)
                        }
                        .onMove(perform: moveCity)
                        .onDelete(perform: deleteCity)
                        .listRowSeparator(.hidden)
                        
                        if citiesVM.cities.isEmpty {
                            HStack {
                                Spacer()
                                VStack (alignment: .center) {
                                    Image(systemName: "tray")
                                        .font(Font.system(size: 50))
                                        .padding(.bottom, 5)
                                    Text("No cities found")
                                        .font(Font.system(size: 20))
                                        .padding(.bottom, 10)
                                    HStack{
                                        Button{
                                            dismiss()
                                        } label: {
                                            Image(systemName: "arrow.left")
                                            Text("Go Back")
                                        }
                                        .buttonStyle(.bordered)
                                        .tint(Color.blue)
                                        
                                        Button{
                                            citiesVM.isSeachablePresented = true
                                        } label: {
                                            Text("Search Cities")
                                        }
                                        .buttonStyle(.borderedProminent)
                                        .tint(Color.blue)
                                    }
                                }
                                Spacer()
                            }
                        }
                        
                        HStack(alignment: .center, spacing: 2) {
                            Spacer()
                            Text("Learn more about")
                            Link(destination: URL(string: "https://openweathermap.org")!) {
                                Text("OpenWeatherMap")
                                    .underline()
                            }
                            Text(" and")
                            Link(destination: URL(string: "https://www.apple.com/maps/")!) {
                                Text("map data")
                                    .underline()
                            }
                            Spacer()
                        }
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(settingsVM.darkMode ? .white.opacity(0.3) : .black.opacity(0.3))
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .padding(.top, 4)
                    .scrollIndicators(.hidden)
                    .listRowSeparator(.hidden)

                }
                else {
                    List(citiesVM.searchResults, id: \.id) { city in
                        Button {
                            citiesVM.tempSelectedCity = city
                            citiesVM.searchText = ""
                            citiesVM.isSheetPresented.toggle()
                        } label: {
                            if let country = city.country {
                                Text("\(city.name), \(country)")
                                    .foregroundColor(settingsVM.darkMode ? .white : .black)
                            } else {
                                Text(city.name)
                                    .foregroundColor(settingsVM.darkMode ? .white : .black)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Weather")
            .navigationBarTitleDisplayMode(.automatic)
            .background(settingsVM.darkMode ? Color.black.ignoresSafeArea() : Color.white.ignoresSafeArea())
            .searchable(text: $citiesVM.searchText,
                        isPresented: $citiesVM.isSeachablePresented,
                        prompt: "Search for a city or airport"
            )
            .onChange(of: citiesVM.searchText) {
                citiesVM.searchForLocations(citiesVM.searchText)
            }
            .onChange(of: settingsVM.unit) {
                Task {
                    await citiesVM.fetchCitieWeather(units: settingsVM.unit)
                }
            }
            .sheet(isPresented: $citiesVM.isSheetPresented) {
                NavigationStack {
                    VStack {
                        WeatherView(city: citiesVM.tempSelectedCity ?? londonCity, units: $settingsVM.unit, darkMode: $settingsVM.darkMode)
                    }
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Cancel") {
                                citiesVM.dismissSearch()
                            }
                            .foregroundStyle(settingsVM.darkMode ? Color.white : Color.black)
                            .font(.system(size: 16, weight: .medium))
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Add") {
                                saveCity()
                                Task {
                                    await citiesVM.fetchCitieWeather(units: settingsVM.unit)
                                }
                            }
                            .foregroundStyle(settingsVM.darkMode ? Color.white : Color.black)
                            .font(.system(size: 16, weight: .semibold))
                        }
                    }
                    .toolbarBackgroundVisibility(.hidden)
                }
            }
            .onAppear {
                Task {
                    await citiesVM.fetchCitieWeather(units: settingsVM.unit)
                }
            }
            .toolbar {
                if editMode?.wrappedValue == .active {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                } else {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Button(action: toggleEditMode) {
                                Text(editMode?.wrappedValue == .active ? "Done" : "Edit List")
                                Image(systemName: "pencil")
                            }
                            Button{
                                showUnitSettings.toggle()
                            } label: {
                                Text("Units")
                                Image(systemName: "chart.bar")
                            }
                            Button{
                                showSettings.toggle()
                            } label: {
                                Text("Settings")
                                Image(systemName: "gear")
                            }
                            Button{
                                showReport.toggle()
                            } label: {
                                Text("Report an Issue")
                                Image(systemName: "exclamationmark.bubble")
                            }
                        } label: {
                            Image(systemName: "ellipsis.circle")
                                .foregroundStyle(Color(settingsVM.darkMode ? .white : .black))
                        }
                    }
                }
            }
            .sheet(isPresented: $showSettings) {
                SettingsView(settingsVM: settingsVM, showSettings: $showSettings)
            }
            .sheet(isPresented: $showUnitSettings) {
                UnitsView(showUnitSettings: $showUnitSettings, settingsVM: settingsVM)
            }
            .sheet(isPresented: $showReport) {
                ReportIssueView(settingsVM: settingsVM, showReport: $showReport)
            }
            .navigationBarBackButtonHidden(true)

        }
        .tint(Color(settingsVM.darkMode ? .white: .black))
    }
}

#Preview {
    AllLocationsView(citiesVM: CitiesViewModel(), settingsVM: SettingsViewModel())
}

//
//  UnitsView.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2025-01-03.
//

import SwiftUI

struct UnitsView: View {
    @Binding var showUnitSettings: Bool
    @ObservedObject var settingsVM: SettingsViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section {
                        Button {
                            settingsVM.unit = .metric
                        } label: {
                            HStack {
                                Text("Metric")
                                Spacer()
                                if settingsVM.unit == .metric {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                } else {
                                    Text("")
                                }
                            }
                        }
                        Button {
                            settingsVM.unit = .imperial
                        } label: {
                            HStack {
                                Text("Imperial")
                                Spacer()
                                if settingsVM.unit == .imperial {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.blue)
                                } else {
                                    Text("")
                                }
                            }
                        }
                    }
                    Section {
                        HStack {
                            Text("Temperature")
                            Spacer()
                            if settingsVM.unit == .imperial {
                                Text("°F")
                                    .foregroundStyle(.gray)
                            } else{
                                Text("°C")
                                    .foregroundStyle(.gray)
                            }
                        }
                        HStack {
                            Text("Precipitation")
                            Spacer()
                            if settingsVM.unit == .imperial {
                                Text("mm/hour")
                                    .foregroundStyle(.gray)
                            } else{
                                Text("mm/hour")
                                    .foregroundStyle(.gray)
                            }
                        }
                        HStack {
                            Text("Speed")
                            Spacer()
                            if settingsVM.unit == .imperial {
                                Text("meter/sec")
                                    .foregroundStyle(.gray)
                            } else{
                                Text("miles/hour")
                                    .foregroundStyle(.gray)
                            }
                        }
                        HStack {
                            Text("Pressure")
                            Spacer()
                            if settingsVM.unit == .imperial {
                                Text("hPa")
                                    .foregroundStyle(.gray)
                            } else{
                                Text("hPa")
                                    .foregroundStyle(.gray)
                            }
                        }
                        HStack {
                            Text("Distance")
                            Spacer()
                            if settingsVM.unit == .imperial {
                                Text("meter")
                                    .foregroundStyle(.gray)
                            } else{
                                Text("miles")
                                    .foregroundStyle(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Units")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Done") {
                        showUnitSettings = false
                    }
                }
            }
        }
    }
}

#Preview {
    UnitsView(showUnitSettings: .constant(true), settingsVM: SettingsViewModel())
}

//
//  SettingsViewModel.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-21.
//

import Foundation
import SwiftUI

class SettingsViewModel : ObservableObject {
    @AppStorage("darkMode") var darkMode: Bool = true
    @AppStorage("unit") var unit: WeatherUnit = .metric
    
    public func isDarkModeEnabled() -> Bool {
        return darkMode
    }
}

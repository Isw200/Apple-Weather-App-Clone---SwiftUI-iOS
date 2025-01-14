//
//  DataController.swift
//  WeatherAppPro
//
//  Created by Isuru Ariyarathna on 2024-12-06.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CitiesDataModel")
    
    init () {
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error.localizedDescription)")
            }
        }
    }
}

//
//  BaseStorageManager.swift
//  RouteProject
//
//  Created by Anton Bindovskyi on 29.03.2020.
//  Copyright © 2020 Anton Bindovskyi. All rights reserved.
//

import GLMap

final class BaseStorageManager: StorageProtocol {
    
    private(set) var points: [GLMapGeoPoint] = []
    
    var pointAmount: Int {
        return points.count
    }
    
    func add(point: GLMapGeoPoint) {
        points.append(point)
    }
    
    func remove(point: GLMapGeoPoint) {
        points.removeAll { $0.lat == point.lat && $0.lon == point.lon }
    }
    
    func removePoint(at index: Int) {
        guard index < points.count, index >= 0 else {
            return
        }
        points.remove(at: index)
    }
    
    func point(at index: Int) -> GLMapGeoPoint? {
        guard index < points.count, index >= 0 else {
            return nil
        }
        
        return points[index]
    }
}

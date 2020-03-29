//
//  PointsManager.swift
//  RouteProject
//
//  Created by Anton Bindovskyi on 29.03.2020.
//  Copyright © 2020 Anton Bindovskyi. All rights reserved.
//

import GLMap

final class PointsManager {
    private var storage: StorageProtocol
    private var router: RouteManagerProtocol
    
    var routerDelegate: RouteManagerDelegate? {
        set {
            router.delegate = newValue
        }
        get {
            return router.delegate
        }
    }
    
    init(storage: StorageProtocol, router: RouteManagerProtocol) {
        self.storage = storage
        self.router = router
    }
    
    private func requestForRoute() {        
        router.requestRoute(for: storage.points)
    }
}

extension PointsManager: StorageProtocol {
    func add(point: GLMapGeoPoint) {
        storage.add(point: point)
        requestForRoute()
    }
    
    func remove(point: GLMapGeoPoint) {
        storage.remove(point: point)
        requestForRoute()
    }
    
    func removePoint(at index: Int) {
        storage.removePoint(at: index)
        requestForRoute()
    }
    
    func removeLastPoint() {
        storage.removePoint(at: storage.points.count - 1)
        requestForRoute()
    }
        
    var points: [GLMapGeoPoint] {
        return storage.points
    }
}

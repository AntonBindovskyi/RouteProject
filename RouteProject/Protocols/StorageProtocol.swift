//
//  StorageProtocol.swift
//  RouteProject
//
//  Created by Anton Bindovskyi on 29.03.2020.
//  Copyright © 2020 Anton Bindovskyi. All rights reserved.
//

import GLMap

protocol StorageProtocol {
    func add(point: GLMapGeoPoint)
    func remove(point: GLMapGeoPoint)
    func removePoint(at index: Int)
    
    var points: [GLMapGeoPoint] { get }
}

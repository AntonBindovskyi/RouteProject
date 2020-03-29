//
//  RouteManagerProtocol.swift
//  RouteProject
//
//  Created by Anton Bindovskyi on 29.03.2020.
//  Copyright © 2020 Anton Bindovskyi. All rights reserved.
//

import GLMap
import GLRoute

protocol RouteManagerDelegate: class {
    func didReceive(track: GLMapTrack)
    func didReceive(error: Error?)
    
    func deleteRoute(track: GLMapTrack?)
}

protocol RouteManagerProtocol {
    var delegate: RouteManagerDelegate? { get set }
    
    func requestRoute(for points: [GLMapGeoPoint])
}

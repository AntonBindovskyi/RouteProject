//
//  RouteManager.swift
//  RouteProject
//
//  Created by Anton Bindovskyi on 29.03.2020.
//  Copyright © 2020 Anton Bindovskyi. All rights reserved.
//

import GLMap
import GLRoute

final class RouteManager: RouteManagerProtocol {
    weak var delegate: RouteManagerDelegate?
    private var track: GLMapTrack?
    
    func requestRoute(for points: [GLMapGeoPoint]) {
        guard points.count >= 2 else {
            deleteTrack()
            return
        }
        
        let request = GLRouteRequest()
        points.forEach({ request.add(.init(pt: $0, heading: 1, isStop: false)) })
        
        request.start { [weak self] (route, error) in
            if let route = route,
                let trackData = route.trackData(with: .init(uiColor: .blue)) {
                if let track = self?.track {
                    track.setTrackData(trackData)
                    self?.delegate?.didReceive(track: track)
                } else {
                    let newTrack = GLMapTrack(drawOrder: 0, andTrackData: trackData)
                    self?.track = newTrack
                    self?.delegate?.didReceive(track: newTrack)
                }
            } else {
                self?.delegate?.didReceive(error: error)
            }
        }
    }
    
    private func deleteTrack() {
        delegate?.deleteRoute(track: track)
        track = nil
    }
    
}

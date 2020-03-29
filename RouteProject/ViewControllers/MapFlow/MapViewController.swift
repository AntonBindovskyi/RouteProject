//
//  MapViewController.swift
//  RouteProject
//
//  Created by Anton Bindovskyi on 29.03.2020.
//  Copyright © 2020 Anton Bindovskyi. All rights reserved.
//

import UIKit
import GLMap

class MapViewController: UIViewController {
    
    // MARK: - Variables, Constants and Outlets
    
    @IBOutlet private var mapView: GLMapView!
    @IBOutlet private var infoButton: UIButton!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    
    lazy private var manager: PointsManager = {
        return PointsManager(storage: BaseStorageManager(), router: RouteManager())
    }()
        
    // MARK: - ViewController LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        prepareMap()
        prepareManager()
        prepareInfoButton()
    }
    
    private func prepareMap() {
        mapView.longPressGestureBlock = .init({ [weak self] (point) in
            self?.startLoading()
            self?.addPoint(point)
        })
        
        mapView.tapGestureBlock = .init({ [weak self] (_) in
            self?.startLoading()
            self?.manager.removeLastPoint()
        })
    }
    
    private func prepareManager() {
        manager.routerDelegate = self
    }
    
    private func prepareInfoButton() {
        infoButton.addTarget(self, action: #selector(showInfoAction(_:)), for: .touchUpInside)
    }
}

// MARK: - Actions
extension MapViewController {
    @objc private func showInfoAction(_ sender: Any) {
        let alert =
            UIAlertController.infoAlert(title: "info_title".localized,
                                        message: "tap_to_delete_point".localized)
        
        present(alert, animated: true, completion: nil)
    }
    
    private func addPoint(_ point: CGPoint) {
        let point = mapView.makeGeoPoint(fromDisplay: point)
        manager.add(point: point)
    }
    
    private func startLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }
    }
    
    private func stopLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
        }
    }
}

// MARK: - RouteManagerDelegate
extension MapViewController: RouteManagerDelegate {
    func deleteRoute(track: GLMapTrack?) {
        if let track = track {
            mapView.remove(track)
        }
        stopLoading()
        if manager.points.count == 1 {
            let alert = UIAlertController.infoAlert(title: "Info".localized,
                                                    message: "first_point_added".localized)
            present(alert, animated: true, completion: nil)
        }
    }
    
    func didReceive(track: GLMapTrack) {
        mapView.add(track)
        stopLoading()
    }
    
    func didReceive(error: Error?) {
        stopLoading()
        let alert = UIAlertController.infoAlert(title: "error".localized, message: error?.localizedDescription)
        present(alert, animated: true, completion: nil)
    }
}

//
//  CoreLocation+Rx.swift
//  runnerpia
//
//  Created by 박경준 on 2023/10/11.
//

import Foundation
import CoreLocation
import RxCocoa
import RxSwift

extension CLLocationManager: HasDelegate{
    public typealias Delegate = CLLocationManagerDelegate
}

class RxCLLocationManagerDelegateProxy: DelegateProxy<CLLocationManager, CLLocationManagerDelegate>, DelegateProxyType, CLLocationManagerDelegate{
    weak private(set) var locationManager: CLLocationManager?

    init(locationManager: CLLocationManager){
        self.locationManager = locationManager
        super.init(parentObject: locationManager, delegateProxy: RxCLLocationManagerDelegateProxy.self)
    }

    static func registerKnownImplementations() {
        self.register {
            RxCLLocationManagerDelegateProxy(locationManager: $0)
        }
    }
}

extension Reactive where Base: CLLocationManager{
    var delegate: DelegateProxy<CLLocationManager, CLLocationManagerDelegate>{
        return RxCLLocationManagerDelegateProxy.proxy(for: base)
    }

    var didUpdateLocations: Observable<[CLLocation]> {
        return delegate.methodInvoked(#selector(CLLocationManagerDelegate.locationManager(_:didUpdateLocations:)))
            .map{ parameters in
                return parameters[1] as! [CLLocation]
            }
    }
}

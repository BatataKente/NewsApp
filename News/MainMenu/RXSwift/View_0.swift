//
//  View_0.swift
//  News
//
//  Created by Josicleison on 26/10/22.
//

import UIKit
import RxSwift
import RxRelay

class View_0: UIViewController {
    
    let names = BehaviorRelay(value: ["Josicleison"])
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "\(type(of: self))"
        
        view.backgroundColor = .systemPurple
        
        names.asObservable()
            .throttle(RxTimeInterval.milliseconds(500), scheduler: MainScheduler.instance)
            .filter {valeu in
                
                return valeu.count > 1
            }
            .debug()
            .map {valeu in
                
                return "users: \(valeu)"
            }
            .subscribe(onNext: {valeu in
            
                print(valeu)
            }).dispose()
        
        names.accept(["Josicleison", "Josicleide"])
        
        names.accept(["Pneumoultramicroscopicosilicovulcanoconiose"])
    }
}

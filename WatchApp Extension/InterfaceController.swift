//
//  InterfaceController.swift
//  WatchApp Extension
//
//  Created by Kristaps Grinbergs on 05/02/2017.
//  Copyright © 2017 fassko. All rights reserved.
//

import WatchKit
import Foundation

import RxSwift
import RxCocoa

class InterfaceController: WKInterfaceController {
  
  /// Current image
  @IBOutlet var currentImage: WKInterfaceImage!
  
  /// Temperature label
  @IBOutlet var tempLabel: WKInterfaceLabel!
  
  /// Wind label
  @IBOutlet var windLabel: WKInterfaceLabel!
  
  /// Measured label
  @IBOutlet var measuredLabel: WKInterfaceLabel!
  
  /// View model
  private var tartuWeatherViewModel = TartuWeatherViewModel()
  
  private let disposeBag = DisposeBag()


  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    // Configure interface objects here.
  }
  
  override func willActivate() {
    // This method is called when watch view controller is about to be visible to user
    super.willActivate()
    
    // Set up labels bindings
    tartuWeatherViewModel.temperature
      .asObservable()
      .subscribe(onNext: {temp in
        self.tempLabel.setText(temp)
      })
      .disposed(by: disposeBag)
    
    tartuWeatherViewModel.wind
      .asObservable()
      .subscribe(onNext: {wind in
        self.windLabel.setText(wind)
      })
      .disposed(by: disposeBag)
    
    tartuWeatherViewModel.measuredTime
      .asObservable()
      .subscribe(onNext: {time in
        self.measuredLabel.setText(time)
      })
      .disposed(by: disposeBag)
    
    // Set up live image binding
    tartuWeatherViewModel.smallImage
      .asObservable()
      .flatMap({ $0.map { Observable.just($0) } ?? Observable.empty()  })
      .flatMap({ imageURL in
        Observable<UIImage?>.create({ observer in
          URLSession.shared.dataTask(with: URL(string: imageURL)!) { data, response, error in
            DispatchQueue.main.async {
              if let error = error {
                observer.onError(error)
              } else if let data = data {
                let image = UIImage(data: data)
                observer.onNext(image)
              }
              observer.onCompleted()
            }
          }.resume()
  
          return Disposables.create()
        })
      })
      .subscribe(onNext: { image in
        self.currentImage.setImage(image)
      })
      .disposed(by: disposeBag)
    
    tartuWeatherViewModel.updateWeather()
    
    // Update weather data with timer
    Observable<Int>
      .interval(RxTimeInterval(30), scheduler: MainScheduler.instance)
      .subscribe(onNext: {_ in
        self.tartuWeatherViewModel.updateWeather()
      })
      .disposed(by: disposeBag)
  }
  
  override func didDeactivate() {
    // This method is called when watch view controller is no longer visible
    super.didDeactivate()
  }
  
  /**
    Reload data when button pressed
  */
  @IBAction func reloadData() {
    reload()
  }
  
  @IBAction func reloadFromMenu() {
    reload()
  }
  
  
  /**
   Relod data and create notification
  **/
  fileprivate func reload() {
    WKInterfaceDevice().play(.notification)
    tartuWeatherViewModel.updateWeather()
  }
  
}

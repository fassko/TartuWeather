//
//  ViewController.swift
//  TartuWeather
//
//  Created by Kristaps Grinbergs on 17/01/16.
//  Copyright © 2016 fassko. All rights reserved.
//

import UIKit
import QuartzCore
import Intents

//import Lightbox

class NowViewController: UIViewController {

  // MARK: - Interface
  /// Temperature label
  @IBOutlet weak var temperatureLabel: UILabel!
  
  /// Wind label
  @IBOutlet weak var windLabel: UILabel!
  
  /// Current image label
  @IBOutlet weak var currentImage: UIImageView!
  
  /// Measured time label
  @IBOutlet weak var measuredTimeLabel: UILabel!
  
  /// Share button
  @IBOutlet var shareButton: UIBarButtonItem!
  
  // MARK: - Class variables
  /// View model
  private var tartuWeatherViewModel = TartuWeatherViewModel()
  
  /// Live image
//  var lightboxController: LightboxController?
  
  /// Pull to refresh control
  let refreshControl = UIRefreshControl()
  
  
  private var timer: Timer?
  
  // MARK: - View lifecycle methods
  override func viewDidLoad() {
    super.viewDidLoad()
    
    shareButton.isEnabled = false
    
    NotificationCenter.default.addObserver(self, selector: #selector(update), name: NSNotification.Name.NSExtensionHostDidBecomeActive, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(update), name: NSNotification.Name.NSExtensionHostWillEnterForeground, object: nil)
    
    timer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) {[weak self] _ in
      self?.update()
    }
    
    // Add pull to refresh
    refreshControl.tintColor = UIColor(red: 0.18, green: 0.35, blue: 0.50, alpha: 1.0)
    refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    guard let scrollView = view as? UIScrollView else { return }
    scrollView.refreshControl = refreshControl
    
    donateIntents()
    
    update()
  }
  
  @IBAction func refresh(_ sender: Any) {
    update()
  }
  
  @objc func update() {
    tartuWeatherViewModel.getWeatherData {[weak self] data in
      self?.refreshControl.endRefreshing()
      self?.shareButton.isEnabled = true
      
      self?.getLiveImage(data.smallImage)
      self?.temperatureLabel.text = data.temperature
      self?.windLabel.text = data.wind
      self?.measuredTimeLabel.text = data.measuredTime
    }
  }
  
  public func donateIntents() {
    if #available(iOS 12.0, *) {
      
      GetTemperatureIntent().donate()
      GetWindIntent().donate()
      
    } else {
    }
  }
  
  // MARK: - Actions
  /**
    Show live image
   
    - Parameters:
      - sender: Tap recognizer of image
   
  **/
  @IBAction func showImage(_ sender: UITapGestureRecognizer) {
//    guard let lightboxController = lightboxController else { return }
//    lightboxController.modalPresentationStyle = .fullScreen
//    present(lightboxController, animated: true, completion: nil)
  }
  
  // MARK: - Additional methods
  /**
    Get live image from Internet and update imageview
   
    - Parameters:
      - imageURL: Image String URL
  */
  fileprivate func getLiveImage(_ imageURL: String) {
    let request = URLRequest(url: URL(string: imageURL)!,
                             cachePolicy: .reloadIgnoringLocalCacheData,
                             timeoutInterval: 60)
    URLSession.shared.dataTask(with: request) {[weak self] data, _, _ in
      DispatchQueue.main.async {
        if let data = data {
          guard let image = UIImage(data: data) else { return }
          self?.currentImage.image = image
        
//          self?.lightboxController = LightboxController(images: [LightboxImage(image: image)])
//          self?.lightboxController?.dynamicBackground = true
//          self?.lightboxController?.pageDelegate = nil
        }
      }
    }.resume()
  }
  
  /**
    Pull to refresh data
   
    - Parameters:
      - refreshControl: Refresh control
  */
  @objc func pullToRefresh(_ refreshControl: UIRefreshControl) {
    update()
  }
  
  /**
    Share temperature and wind
  */
  @IBAction func share(_ sender: Any) {
    guard let temperature = temperatureLabel.text,
      let wind = windLabel.text else {
        return
    }
    
    let activityViewController = UIActivityViewController(activityItems:
      ["\(String(describing: temperature)), \(String(describing: wind))"], applicationActivities: nil)
    navigationController?.present(activityViewController, animated: true, completion: {})
  }
}

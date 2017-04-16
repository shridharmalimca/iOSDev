//
//  ViewController.swift
//  WebonoiseAssignment
//
//  Created by Shridhar Mali on 4/15/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit
import GoogleMaps
import SDWebImage
class ViewController: UIViewController {

    @IBOutlet weak var googleMapView: GMSMapView!               // GoogleMap IBOutlet
    @IBOutlet weak var placePhotoGallery: UICollectionView!     // Horizontal CollectionView
    let locationManager = CLLocationManager()                   // Location Manager instance
    let objPlaceDetailModel = PlaceDetailModel.shardInstance    // PlaceDetailModel Singleton model
    var placePhotoUrls = [URL]()                                // Holding photo reference url of google place API
    var image = UIImage()                                       // Cached Image
    var latitude: Double = 19.0176147                           // first time load location latitude on the map
    var longitude: Double = 72.8561644                          // first time load location longitude on the map
    var imageFileName = ""
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Google Places"
        // Show alert for grant user current location access
        updateLocation()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if SRKUtility.isInternetAvailable() {                   // Checking internet rechability
            initGoogleMaps()                                    // intialize google map with current location marker
            extractPhotoRefenceImageUrls()                      // extract photo reference url after user come back from auto complete search
            placePhotoGallery.reloadData()
        } else {
            SRKUtility.showErrorMessage(title: "Internet Status", message: "Please check your internet connectivity", viewController: self)
        }
        // navigation left bar button for navigation to image gallery view 
        // to see downloaded images which is selected on place photo horizontal scroll
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Images", style: .plain, target: self, action: #selector(self.imagesClicked))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        placePhotoGallery.reloadData()
    }

    //MARK:- Private Methods
    func updateLocation() {
        locationManager.delegate = self                                     // CLLocationManager settings
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    //MARK:- Intialize GoogleMap
    func initGoogleMaps() {
        var title: String = "Current Location"                                  // title of pin annotation
        let subTitle = ""                                                       // subTitle of pin annotation kept nil
        if let lat = objPlaceDetailModel.placeDetailsInfo?.geometry?.location?.latitude, let lng = objPlaceDetailModel.placeDetailsInfo?.geometry?.location?.longitude {                                               // check is selected place lat and lng and
                                                                                // set it to google map camera position
            latitude = lat
            longitude = lng
            if let titleText = objPlaceDetailModel.placeDetailsInfo?.name {     // check place info and set to annotation view title of GoogleMap
                title = titleText
            }
        }
        let camera = GMSCameraPosition.camera(withLatitude: latitude , longitude: longitude, zoom: 17.0) // Set google Map focus on provide lat lng
        self.googleMapView.camera = camera
        self.googleMapView.delegate = self
        self.googleMapView.isMyLocationEnabled = true
        self.googleMapView.settings.myLocationButton = true
        
        //Create a marker in the center of the map
        let marker = GMSMarker()                                                // Google Map Annotation with title(Place information)
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = title
        marker.snippet = subTitle
        marker.map = self.googleMapView
    }
    
    func extractPhotoRefenceImageUrls() {                                            // Photo reference for get place photo using google photo API
        if let photoReferenceArr = objPlaceDetailModel.placeDetailsInfo?.photos {
            for(index, _) in photoReferenceArr.enumerated() {
                objPlaceDetailModel.isPlacePhoto = true
                if let photoRef = photoReferenceArr[index].photoReference {
                    DispatchQueue.main.async {
                    _ = Server.APIPlacePhoto.invokeAPIPlacePhoto(photoReference: photoRef) { (response:APIPlacePhotoReponse) in
                        OperationQueue.main.addOperation {
                            switch response {
                            case .error(let error):
                                print(error)
                            case .success(let placesDetail):
                                if let url = placesDetail.imageUrl {
                                    self.placePhotoUrls.append(url as! URL)           // Get image URL response of place photo
                                    self.placePhotoGallery.reloadData()
                                }
                            }
                        }
                    }
                    }
                }
            }
        }
    }
    
    // Download image in background which selected by user and store it into
    // device internal memory i.e device document directory
    func downloadImageWithUrlAndStoreInDevice(url: URL?) {
        var downloadTask: URLSessionDownloadTask!
        var backgroundSession: URLSession!
        if let imageUrl = url {
            let backgroundSessionConfiguration = URLSessionConfiguration.background(withIdentifier: "backgroundSession")
            backgroundSession = URLSession(configuration: backgroundSessionConfiguration, delegate: self as URLSessionDelegate, delegateQueue: OperationQueue.main)
            imageFileName = imageUrl.absoluteString
            downloadTask = backgroundSession.downloadTask(with: imageUrl)
            downloadTask.resume()

        }
    }
   
    func showFileWithPath(path: String){
        // This method is for the checking for an image isExists / Saved
        let isFileFound:Bool? = FileManager.default.fileExists(atPath: path)
        if isFileFound == true{
            print(path)
        } else {
            print("File not found at path")
        }
    }
    // Navigation to Gallery screen
    func imagesClicked() {
        self.performSegue(withIdentifier: "images", sender: self)
    }
    
    //MARK:- Actions
    @IBAction func searchAddress(_ sender: Any) {                               // Search button on top of navigation bar (rightBarButtonItem)
        if SRKUtility.isInternetAvailable() {
            objPlaceDetailModel.isPlacePhoto = false
            self.placePhotoUrls.removeAll()
            self.performSegue(withIdentifier: "autoCompletePlaces", sender: self)
        } else {
            SRKUtility.showErrorMessage(title: "Internet Status", message: "Please check your internet connectivity", viewController: self)
        }
    }
}

//MARK:- UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.placePhotoUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlacePhotoCell
        cell.placePhotoImgView.sd_setShowActivityIndicatorView(true)
        cell.placePhotoImgView.sd_setIndicatorStyle(.gray)
        cell.placePhotoImgView.layer.cornerRadius = 10
        if self.placePhotoUrls.count != 0 {
            cell.placePhotoImgView.sd_setImage(with: self.placePhotoUrls[indexPath.row], placeholderImage: UIImage(named: "fab_icon_touch"))
        }
        
        return cell
    }
}

//MARK:- UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.placePhotoUrls.count != 0 {
            downloadImageWithUrlAndStoreInDevice(url: self.placePhotoUrls[indexPath.row])
        }
    }
}

//MARK:- CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        latitude = (location?.coordinate.latitude)!
        longitude = (location?.coordinate.longitude)!
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 17.0)
        self.googleMapView.animate(to: camera)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get the current location of user \(error.localizedDescription)")
    }
}

//MARK:- GMSMapViewDelegate
extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        self.googleMapView.isMyLocationEnabled = true
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        self.googleMapView.isMyLocationEnabled = true
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        print("clicked")
        if SRKUtility.isInternetAvailable() {
            initGoogleMaps()
        } else {
            SRKUtility.showErrorMessage(title: "Internet Status", message: "Please check your internet connectivity", viewController: self)
        }
        return true
    }
}

//MARK:- URLSessionDownloadDelegate
extension ViewController: URLSessionDownloadDelegate {
    func urlSession(_ session: URLSession,
                    downloadTask: URLSessionDownloadTask,
                    didFinishDownloadingTo location: URL){
        
        objPlaceDetailModel.counter = objPlaceDetailModel.counter + 1
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDirectoryPath:String = path[0]
        let fileManager = FileManager()
        let destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath.appendingFormat("/\(objPlaceDetailModel.counter).png"))
        print(destinationURLForFile)
        if fileManager.fileExists(atPath: destinationURLForFile.path){
            showFileWithPath(path: destinationURLForFile.path)
        }
        else{
            do {
                try fileManager.copyItem(at: location, to: destinationURLForFile)
                // show file
                showFileWithPath(path: destinationURLForFile.path)
            }catch{
                print("An error occurred while moving file to destination url")
            }
        }
    }
}


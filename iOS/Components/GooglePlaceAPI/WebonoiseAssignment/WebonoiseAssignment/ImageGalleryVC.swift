//
//  ImageGalleryVC.swift
//  WebonoiseAssignment
//
//  Created by Shridhar Mali on 4/16/17.
//  Copyright © 2017 Shridhar Mali. All rights reserved.
//

import UIKit

class ImageGalleryVC: UIViewController {
    var pngFiles = [URL]()
    
    @IBOutlet weak var placePhotoCollectionView: UICollectionView!
    
    //MARK:- ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Gallery"
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getImagesFromDocumentDir()
        placePhotoCollectionView.reloadData()
        print(self.pngFiles.count)
    }

    //MARK:- Private Methods
    func getImagesFromDocumentDir() {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        do {
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            print(directoryContents)
            // if you want to filter the directory contents you can do like this:
            pngFiles = directoryContents.filter{ $0.pathExtension == "png" }
            placePhotoCollectionView.reloadData()
        } catch {
            print("error reading files")
        }
    }

}

//MARK:- UICollectionViewDataSource
extension ImageGalleryVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pngFiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PlacePhotoCell
        do {
            let data = try Data(contentsOf: pngFiles[indexPath.row])
            let image = UIImage(data: data)
            cell.placePhotoImgView.image = image
        } catch {
            print("Error")
        }
        return cell
    }
}




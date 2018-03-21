//
//  ViewController.swift
//  InstaExplore
//
//  Created by Appinventiv on 07/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var index: Int?
    //fileprivate let sectionInsets = UIEdgeInsets(top: 0.0, left: 5.0, bottom: 50.0, right: 5.0)
    fileprivate let itemsPerRow: CGFloat = 3
    
    var images = ["3","rio-de-janeiro-thumb","saint-vincent-and-grenadines-thumb","sydney-thumb","walt-disney-world-thumb","barcelona-thumb","beijing-thumb","denali-national-park-and-preserve-thumb","istanbul-thumb","london-thumb","new-york-city-thumb","paris-thumb","rio-de-janeiro-thumb","saint-vincent-and-grenadines-thumb","sydney-thumb"]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addButton(_ sender: Any) {
        images.insert("addImage", at: index!)
        let indexPath = IndexPath(
            item: index!,
            section: 0
        )
        collectionView?.performBatchUpdates({
            self.collectionView?.insertItems(at: [indexPath])
        }, completion: nil)
    }
    @IBAction func deleteButton(_ sender: Any) {
        images.remove(at: index!)
        let indexPath = IndexPath(
            item: index!,
            section: 0
        )
        collectionView?.performBatchUpdates({
            self.collectionView?.deleteItems(at: [indexPath])
        }, completion: nil)
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setDelegates(){
        collectionView.delegate = self
        collectionView.dataSource = self
        if let layout = collectionView?.collectionViewLayout as? CustomLayout {
            layout.delegate = self
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = UIImage(named: images[indexPath.item])
        var obj = CustomLayout()
        obj.index = indexPath.item
        return cell
    }
    
    //    func collectionView(_ collectionView: UICollectionView,
    //                        layout collectionViewLayout: UICollectionViewLayout,
    //                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    //
    //        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    //        let availableWidth = view.frame.width - paddingSpace
    //        var widthPerItem = availableWidth / itemsPerRow
    //
    //        if indexPath.item == 0{
    //            widthPerItem = (2 * widthPerItem) + 5
    //            return CGSize(width: widthPerItem, height: widthPerItem)
    //        }
    //        return CGSize(width: widthPerItem, height: widthPerItem)
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView,
    //                        layout collectionViewLayout: UICollectionViewLayout,
    //                        insetForSectionAt section: Int) -> UIEdgeInsets {
    //        return sectionInsets
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView,
    //                        layout collectionViewLayout: UICollectionViewLayout,
    //                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    //        return sectionInsets.left
    //    }
    //
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    //        return sectionInsets.left
    //    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {

        case UICollectionElementKindSectionHeader:
        
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,withReuseIdentifier: "HeaderCollectionReusableView",for: indexPath) as! HeaderCollectionReusableView
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.index = indexPath.item
    }
}

extension ViewController: MyLayoutDelegate
{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        if indexPath.item == 0 {
            return CGFloat(241)
        }
        else{
            return CGFloat(117)
        }
    }
}




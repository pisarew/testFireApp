//
//  AssignmentsViewController.swift
//  testFireApp
//
//  Created by Глеб Писарев on 20.04.2022.
//

import UIKit
import Firebase


class AssignmentsViewController: UICollectionViewController {

    let itemsPerRow: CGFloat = 2
    let size = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func logoutAction(_ sender: UIBarButtonItem) {
        let fireAuth = Auth.auth()
        do {
            try fireAuth.signOut()
        }
        catch let error as NSError {
            print("Ошибка - ", error)
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 15
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .gray
        cell.layer.cornerRadius = 15
        return cell
    }

}

extension AssignmentsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        let paddingWidth = size.left * (itemsPerRow + 1)
        let avilableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = avilableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return size.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return size.right
    }
}

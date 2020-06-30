//
//  ViewController.swift
//  VoiceClub
//
//  Created by Bibin Jaimon on 20/03/20.
//  Copyright © 2020 Bibin Jaimon. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    @IBOutlet weak var audioCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        title = "Browse"
        setupCollectionView()
    }

    private func setupCollectionView() {
        self.audioCollectionView.dataSource = self
        self.audioCollectionView.delegate = self
        self.audioCollectionView.register(UINib.init(nibName: "LastPlayedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LastPlayedCollectionViewCell")
        self.audioCollectionView.register(UINib.init(nibName: "AudioListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AudioListCollectionViewCell")
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 26
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastPlayedCollectionViewCell", for: indexPath) as! LastPlayedCollectionViewCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AudioListCollectionViewCell", for: indexPath) as! AudioListCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentAudioPlayVC()
    }
    
    func presentAudioPlayVC() {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlayVoiceViewController") as! PlayVoiceViewController
//        let vc = PlayVoiceViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row < 3 {
            let sideLength = (collectionView.bounds.size.width / 3) - 10
            return CGSize(width: sideLength, height: sideLength)
        }
        let width = collectionView.bounds.size.width
        return CGSize(width: width, height: 70)
        
    }

}

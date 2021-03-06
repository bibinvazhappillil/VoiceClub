//
//  ViewController.swift
//  VoiceClub
//
//  Created by Bibin Jaimon on 20/03/20.
//  Copyright © 2020 Bibin Jaimon. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet weak var audioCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        title = "Browse"
        setupCollectionView()
        
    }
    
    @IBAction func didTappedAddButton(_ sender: UIBarButtonItem) {
        let documentPicker = UIDocumentPickerViewController(documentTypes: ["public.mp3"], in: .open)
        documentPicker.delegate = self
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    

    private func setupCollectionView() {
        self.audioCollectionView.dataSource = self
        self.audioCollectionView.delegate = self
        self.audioCollectionView.register(UINib.init(nibName: "LastPlayedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LastPlayedCollectionViewCell")
        self.audioCollectionView.register(UINib.init(nibName: "AudioListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AudioListCollectionViewCell")
    }

}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 26
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /*if indexPath.row < 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LastPlayedCollectionViewCell", for: indexPath) as! LastPlayedCollectionViewCell
            return cell
        }*/
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AudioListCollectionViewCell", for: indexPath) as! AudioListCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentAudioPlayVC(contentURL: nil)
    }
    
    func presentAudioPlayVC(contentURL: URL?) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlayVoiceViewController") as! PlayVoiceViewController
        vc.contentURL = contentURL
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
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
        
        /*if indexPath.row < 3 {
            let sideLength = (collectionView.bounds.size.width / 3) - 10
            return CGSize(width: sideLength, height: sideLength)
        }*/
        let width = collectionView.bounds.size.width
        return CGSize(width: ((width / 2) - 10) , height: 200)
        
    }

}

extension HomeViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print(urls.first?.absoluteString)
        presentAudioPlayVC(contentURL: urls.first)
    }
}

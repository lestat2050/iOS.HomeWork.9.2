//
//  ExhibitionDetailVC.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 8/20/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import UIKit

class ExhibitionInfoViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private(set) weak var exhibitionInfoScrollView: UIScrollView!
    @IBOutlet private(set) weak var exhibitionNameLabel: UILabel!
    @IBOutlet private(set) weak var authorNameLabel: UILabel!
    @IBOutlet private(set) weak var exhibitionDateInterval: UILabel!
    @IBOutlet private(set) weak var galleryNameLabel: UILabel!
    @IBOutlet private(set) weak var galleryLogoImage: UIImageView!
    @IBOutlet private(set) weak var galleryStartTimeLabel: UILabel!
    @IBOutlet private(set) weak var galleryEndTimeLabel: UILabel!
    @IBOutlet private(set) weak var locationLabel: UILabel!
    @IBOutlet private(set) weak var phoneNumberLabel: UILabel!
    @IBOutlet private(set) weak var linkLabel: UILabel!
    @IBOutlet private(set) weak var facebookLabel: UILabel!
    @IBOutlet private(set) weak var galleryDescriptionTextView: UITextView!
    @IBOutlet private(set) weak var aboutExhibitionTextView: UITextView!
    @IBOutlet private(set) weak var authorDescriptionTextView: UITextView!
    @IBOutlet private(set) weak var linksTextView: UITextView!
    @IBOutlet private(set) weak var exhibitionDetailView: UIView!
    @IBOutlet private(set) weak var galleryDescriptionView: UIView!
    @IBOutlet private(set) weak var detailButtonView: UIView!
    @IBOutlet private(set) weak var detailButton: UIButton!
    @IBOutlet private(set) weak var worksCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    weak var selectedExhibition: Exhibition?
    
    lazy var dateFormat: DateFormatter = {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd.MM.yyyy"
        return dateFormat
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        worksCollectionView.dataSource = self
        configurateNavigatinBar()
        showSelectedExhibition()
        hideExhibitionDetailView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - Actions
    
    @IBAction func switchVisibilityExhibitionDetail(_ sender: UIButton) {
        var rotationAngle: CGFloat = 0
        
        if exhibitionDetailView.isHidden {
            rotationAngle = CGFloat.pi
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.detailButton.transform = CGAffineTransform(rotationAngle: rotationAngle)
            self.exhibitionDetailView.isHidden = !self.exhibitionDetailView.isHidden
            self.galleryDescriptionView.isHidden = !self.galleryDescriptionView.isHidden
        })
    }
    
    // MARK: - Methods
    
    private func configurateNavigatinBar() {
        guard let nc = navigationController else {
            fatalError("No Navigation Controller")
        }
        
        let backButtonImage = UIImage(named: backButtonImageName)
        
        nc.setNavigationBarHidden(false, animated: false)
        nc.navigationBar.backIndicatorImage = backButtonImage
        nc.navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        nc.navigationBar.backItem?.title = ""
    }
    
    private func hideExhibitionDetailView() {
        exhibitionDetailView.isHidden = true
        galleryDescriptionView.isHidden = true
    }
    
    private func showSelectedExhibition() {
        if let selectedExhibition = selectedExhibition {
            exhibitionNameLabel.text = selectedExhibition.name
            authorNameLabel.text = selectedExhibition.authorName
            if let tempDateStart = selectedExhibition.dateStart,
                let tempDateEnd = selectedExhibition.dateEnd {
                let dateStart = dateFormat.string(from: tempDateStart)
                let dateEnd = dateFormat.string(from: tempDateEnd)
                exhibitionDateInterval.text = dateStart + " - " + dateEnd
            }
            galleryNameLabel.text = selectedExhibition.gallery?.name
            galleryLogoImage.image = UIImage(named: (selectedExhibition.gallery?.galleryLogo)!)
            if let scheduleWeekend = selectedExhibition.gallery?.scheduleWeekend {
                galleryStartTimeLabel.text = "Mon - Thu " + scheduleWeekend
            }
            if let scheduleWeekdays = selectedExhibition.gallery?.scheduleWeekdays {
                galleryEndTimeLabel.text = "Fri - Sat " + scheduleWeekdays
            }
            locationLabel.text = selectedExhibition.gallery?.address
            phoneNumberLabel.text = selectedExhibition.gallery?.phone
            linkLabel.text = selectedExhibition.gallery?.link
            facebookLabel.text = selectedExhibition.gallery?.facebook
            galleryDescriptionTextView.text = selectedExhibition.gallery?.galleryDescription
            aboutExhibitionTextView.text = selectedExhibition.about
            authorDescriptionTextView.text = selectedExhibition.authorDescription
            linksTextView.text = selectedExhibition.links
        }
    }

}

extension ExhibitionInfoViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let selectedExhibition = selectedExhibition {
            return selectedExhibition.works.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkCell.identifier,
                                                      for: indexPath) as! WorkCell
        var works: [Work] = []
        if let selectedExhibition = selectedExhibition {
            works = Array(selectedExhibition.works)
        }
        
        cell.workImageView.image = UIImage(named: works[indexPath.row].imgPicture)
        return cell
    }
    
}




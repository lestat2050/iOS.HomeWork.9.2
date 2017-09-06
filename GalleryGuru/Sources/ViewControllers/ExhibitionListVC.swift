//
//  ExhibitionVC.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 8/20/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import UIKit

class ExhibitionListVC: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private(set) weak var exhibitionListTableView: UITableView!
    
    // MARK: - Properties
    
    private let saver = DataSaver()
    
    var exhibitions: [Exhibition] = []
    var selectedExhibition: Exhibition?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurateExhibitionVC()
        subscribeOnChanges()
        saver.subscribeOnChanges()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        if let row = exhibitionListTableView.indexPathForSelectedRow {
            self.exhibitionListTableView.deselectRow(at: row, animated: true)
        }
        selectedExhibition = nil
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: exhibitionUpdateNotificationName,
                                                  object: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! ExhibitionInfoViewController
        nextVC.selectedExhibition = selectedExhibition
    }
    
    // MARK: - Methods
    
    private func subscribeOnChanges() {
        NotificationCenter.default.addObserver(forName: exhibitionUpdateNotificationName,
                                               object: nil, queue: nil) { _ in
            self.exhibitionListTableView.reloadData()
        }
    }
    
    private func configurateExhibitionVC() {
        exhibitionListTableView.dataSource = self
        exhibitionListTableView.delegate = self
        exhibitionListTableView.register(UINib(nibName: ExhibitionCell.identifier,
                                               bundle: nil),
                                         forCellReuseIdentifier: ExhibitionCell.identifier)
    }
    
}

extension ExhibitionListVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.size.width
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedExhibition = exhibitions[indexPath.row]
        performSegue(withIdentifier: exhibitionDetailSegueID, sender: nil)
    }

}

extension ExhibitionListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exhibitions.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExhibitionCell.identifier)!
        ExhibitionCellConfigurator().configure(with: cell as! ConfigurableCell,
                                               model: exhibitions[indexPath.row])
    
        return cell
    }
    
}

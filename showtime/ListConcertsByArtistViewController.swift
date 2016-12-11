//
//  ListConcertsByArtistViewController.swift
//  showtime
//
//  Created by Iñigo Solano Pàez on 03/12/2016.
//  Copyright © 2016 UOC. All rights reserved.
//

import UIKit
import CoreData

class ListConcertsByArtistViewController: ShowtimeBaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var showsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!

    let context = CoreDataHelpers.viewContext
    var fetchedResultController: NSFetchedResultsController<Concert>!
    var didSelect: (Concert) -> () = { _ in }
    var artist: Artist!
    var scope: ConcertScope = .all

    override func viewDidLoad() {
        super.viewDidLoad()
        scope = .artist(artist)
        setupTableView()
        setupLabels()
        setupImageView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }

    func reloadData() {
        fetchedResultController.fetchRequest.predicate = scope.predicate
        try? fetchedResultController.performFetch()

        tableView.reloadData()
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.sections?[section].numberOfObjects ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "concertByArtist", for: indexPath)
        let concert = fetchedResultController.object(at: indexPath)

        cell.textLabel?.text = "\(concert.venue)"
        cell.detailTextLabel?.text = "\(concert.formattedDate)"
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let concert = fetchedResultController.object(at: indexPath)
        didSelect(concert)
    }

    // MARK: private section

    private func setupImageView() {
        imageView.layer.borderColor = Theme.Colors.tint.color.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius =  imageView.frame.height / 2
        imageView.clipsToBounds = true

        // add gesture recognizer
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(recognizer)
    }

    private func setupTableView() {
        fetchedResultController = NSFetchedResultsController(fetchRequest: Concert.sortedFetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        tableView.register(RightDetailCell.self, forCellReuseIdentifier: "concertByArtist")
    }

    private func setupLabels() {
        artistName.text = artist.name
        imageView.image = artist.image

        artistName.style(Theme.Styles.title.style)
        showsLabel.style(Theme.Styles.subtitle.style)
    }

    @objc private func imageTapped() {
        let actionSheet = UIAlertController(title: "Artist Image", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Select image from library", style: .default, handler: { action in
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self

            self.present(picker, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true, completion: nil)
    }
}

extension ListConcertsByArtistViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        DispatchQueue.main.async {
            guard let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage else { return }
            if let image = self.resizeImage(originalImage) {
                self.imageView.image = image
                self.artist.storedImage = image
                self.context.saveIt()
            }
        }
        dismiss(animated: true, completion: nil)
    }

    private func resizeImage(_ image: UIImage) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 128, height: 128)
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

}

//
//  ViewController.swift
//  BaseCode
//
//  Created by Orange Mantra on 15/11/21.
//

import UIKit
import ShazamKit
@available(iOS 15.0, *)
class ViewController: UIViewController {
    // MARK: IBOutlet
    @IBOutlet weak var imgSong: UIImageView!
    @IBOutlet weak var lblSongName: UILabel!
    @IBOutlet weak var lblSongSinger: UILabel!
    @IBOutlet weak var lblSongWriter: UILabel!
    @IBOutlet weak var lblSongStatus: UILabel!
    @IBOutlet weak var btnStartMatch: UIButton!
    // MARK: Variables
    var activityIndicator = UIActivityIndicatorView()
    var matcher: MatchingHelper?
    var isListening = false
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isListening = false
        matcher?.stopListening()
    }
    // MARK: Methods
    private func setupUI() {
        matcher = MatchingHelper(matchHandler: songMatched)
        changeLabelHiddenStatus(isHidden: true)
    }
    private func changeLabelHiddenStatus(isHidden: Bool, isStatusHide: Bool = true) {
        imgSong.isHidden = isHidden
        lblSongName.isHidden = isHidden
        lblSongSinger.isHidden = isHidden
        lblSongWriter.isHidden = isHidden
        lblSongStatus.isHidden = isStatusHide
    }
    func songMatched(item: SHMatchedMediaItem?, error: Error?) {
        self.activityIndicator.removeFromSuperview()
        btnStartMatch.isUserInteractionEnabled = true
        isListening = false
        if error != nil {
            changeLabelHiddenStatus(isHidden: true, isStatusHide: false)
            lblSongStatus.text = "Cannot match the audio :("
            print(String(describing: error.debugDescription))
        } else {
            changeLabelHiddenStatus(isHidden: false, isStatusHide: false)
            lblSongStatus.text = "Song matched!"
            print("Found song!")
            lblSongName.text = item?.title
            lblSongSinger.text = item?.subtitle
            lblSongWriter.text = item?.artist
            if let url = item?.artworkURL {
                ImageDownloader.downloadImage(url) {
                    image, _ in
                    if let imageObject = image {
                        DispatchQueue.main.async {
                            self.imgSong.image = imageObject
                        }
                    }
                }
            }
        }
    }
    // MARK: IBAction
    @IBAction func btnMatchOnAction(_ sender: UIButton) {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        changeLabelHiddenStatus(isHidden: true, isStatusHide: false)
        sender.isUserInteractionEnabled = false
        lblSongStatus.text = "Listening..."
        isListening = true
        do {
            try matcher?.match()
        } catch {
            lblSongStatus.text = "Error matching the song"
            print("Error matching audio")
        }
    }
}

class ImageDownloader {
    static func downloadImage(_ url: URL, completion: ((_ _image: UIImage?, _ urlString: String?) -> ())?) {
        URLSession.shared.dataTask(with: url) { (data, response,error) in
            if let error = error {
                print("error in downloading image: \(error)")
                completion?(nil, "urlString")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                completion?(nil, "urlString")
                return
            }
            if let data = data, let image = UIImage(data: data) {
                completion?(image, "urlString")
                return
            }
            completion?(nil, "urlString")
        }.resume()
    }
}

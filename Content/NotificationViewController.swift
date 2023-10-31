//
//  NotificationViewController.swift
//  Content
//
//  Created by Shivam Ratnam on 10/10/23.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import AVFoundation
import AVKit
enum NotificationType: String {
    case text = "text"
    case image = "image"
    case video = "video"
    case collectionView = "carousel"
}

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    var imageUrls: [String] = []
    var timer: Timer?
        var currentPage: Int = 0

//        override func viewWillAppear(_ animated: Bool) {
//            super.viewWillAppear(animated)
//            startAutomaticSliding()
//        }
//
//        override func viewWillDisappear(_ animated: Bool) {
//            super.viewWillDisappear(animated)
//            stopAutomaticSliding()
//        }
//
//        func startAutomaticSliding() {
//            timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(automaticSlide), userInfo: nil, repeats: true)
//        }
//
//        func stopAutomaticSliding() {
//            timer?.invalidate()
//            timer = nil
//        }
//
//        @objc func automaticSlide() {
//            if currentPage < imageUrls.count - 1 {
//                currentPage += 1
//            } else {
//                currentPage = 0
//            }
//            collectionViewCaroussel.scrollToItem(at: IndexPath(row: currentPage, section: 0), at: .right, animated: true)
//            pageControl.currentPage = currentPage
//        }

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var hview1: NSLayoutConstraint!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var hView2: NSLayoutConstraint!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var hCollectionView: NSLayoutConstraint!
    @IBOutlet weak var collectionViewCaroussel: UICollectionView!
    @IBOutlet var label: UILabel?
    var Player: AVPlayer?
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var view4Constraint: UIView!
    @IBOutlet weak var imageView2: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewCaroussel.delegate = self
        collectionViewCaroussel.dataSource = self
        // Do any required interface initialization here.
        preferredContentSize = CGSize(width: view.bounds.size.width, height: 130)
        view1.isHidden=true
        view2.isHidden=true
        view3.isHidden=true
        view4.isHidden=true
//        hview1.constant = 0
//        hView2.constant = 0
       // hCollectionView.constant = 0
        
        
        
        
    }
    
    func didReceive(_ notification: UNNotification) {
        
        print("userinfo",notification.request.content.userInfo)
        print("categoryIdentifier",notification.request.content.categoryIdentifier)
        
        let notifcationType = NotificationType(rawValue: notification.request.content.categoryIdentifier)
        
        
        
        if notifcationType == .text {
            view1.isHidden=false
//            hview1.constant = 200
            preferredContentSize = CGSize(width: view1.bounds.size.width, height: hview1.constant+10)
            label?.text = ""
            if let title = notification.request.content.userInfo["title"] as? String{
                // label?.text = title
                
                
            }
        }
        else if notifcationType == .image {
            view2.isHidden = false
            preferredContentSize = CGSize(width: view1.bounds.size.width, height: hView2.constant+30)
            
            guard let imageURLStringArray = notification.request.content.userInfo["imageUrL"] as? [String],
                  let imageURL = URL(string: imageURLStringArray.first ?? "") else {
                return
            }
            
            downloadImage(from: imageURL)
            
        }
        
        else if notifcationType == .collectionView {
            view3.isHidden = false
//            consview3TopMargin.constant = 0
            
            view3.layoutIfNeeded()
            preferredContentSize = CGSize(width: view1.bounds.size.width, height: 170) // 145 - view3 Height
            
            if let imageUrlStrings = notification.request.content.userInfo["imageUrL"] as? [String] {
                imageUrls = imageUrlStrings
                if imageUrls.count > 1 {
                    startAutomaticSliding()
                }
                pageControl.numberOfPages = imageUrls.count
                collectionViewCaroussel.reloadData()
            }
            
            
            
        }
            
        
        
        else if notifcationType == .video {
            view4.isHidden = false
           
            
            guard let videoURLString = notification.request.content.userInfo["video_url"] as? String,
                          let videoURL = URL(string: videoURLString) else {
                        return
                    }
            let desiredHeight: CGFloat = 200.0 // Set your desired height here
               var view4Frame = view4.frame
               view4Frame.size.height = desiredHeight
               view4.frame = view4Frame
            view4.contentMode = .scaleAspectFit

               // Update preferred content size to reflect the new height
               let newHeight = desiredHeight
               preferredContentSize = CGSize(width: view1.bounds.size.width, height: newHeight)

                    // Download and play the video
                    playVideo(from: videoURL)
                }
       
            

            
            
            
        }
    func playVideo(from url: URL) {
        // Implement code to play the video from the provided URL
        // You can use AVPlayer or AVPlayerViewController to play the video
        // Handle the playback based on your application's needs
        // Example:
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            player.play()
        }
    }
    
        
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        print("userINFO",response.notification.request.content.userInfo)
        let dict = response.notification.request.content.userInfo
        if response.actionIdentifier == "Action1Identifier" {
        
            guard let  buttonArray = dict["button"] as? [[String:AnyObject]] else {
                return
            }
            guard let buttonURLDict = buttonArray.last ,
                    let buttonUrl = buttonURLDict["buttonUrl"] as? String  else {
                return
            }
            print("button URL", buttonUrl)
           // let url = URL(string: buttonUrl)!
            if let url = URL(string: "demoInapp://" + buttonUrl) {
                        extensionContext?.open(url, completionHandler: nil)
                    }
           // completion(.dismissAndForwardAction)

            

        }
        if response.actionIdentifier == "Action2Identifier" {
        
            guard let  buttonArray = dict["button"] as? [[String:AnyObject]] else {
                return
            }
            guard let buttonURLDict = buttonArray.last ,
                    let buttonUrl = buttonURLDict["buttonUrl"] as? String  else {
                return
            }
            print("button URL", buttonUrl)
           // UIApplication.shared.open(buttonUrl as! URL, options: [:], completionHandler: nil)
            let url = URL(string: buttonUrl)!
            extensionContext?.open(url, completionHandler: nil)
           // completion(.dismissAndForwardAction)

            

        }
        
        
        
//        if response.actionIdentifier == "Action2Identifier" {
//            if imageUrls.count > (pageControl.currentPage+1) {
//                self.collectionViewCaroussel.scrollToItem(at: IndexPath(row: pageControl.currentPage+1, section: 0), at: .right, animated: true)
//                pageControl.currentPage = pageControl.currentPage + 1
//            }
//        }
//        if response.actionIdentifier == "Action1Identifier" {
//            if (pageControl.currentPage-1) != -1 {
//                self.collectionViewCaroussel.scrollToItem(at: IndexPath(row: pageControl.currentPage-1, section: 0), at: .right, animated: true)
//                pageControl.currentPage = pageControl.currentPage - 1
//            }
//        }
        
        if response.actionIdentifier == "play_action" {
            let content = response.notification.request.content
            guard let attachment = content.attachments.first else { return }
            
            if attachment.url.startAccessingSecurityScopedResource() {
                let item = AVPlayerItem(url: attachment.url)
                self.Player = AVPlayer(playerItem: item)
                
               
                let playerLayer = AVPlayerLayer(player: self.Player)
                playerLayer.frame = self.view.layer.bounds
                self.view.layer.addSublayer(playerLayer)
                self.Player?.play()
            }
            attachment.url.stopAccessingSecurityScopedResource()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.Player?.pause()
                self.Player = nil
            }
            completion(.doNotDismiss)
            
        }
    }
    
    func downloadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard error == nil, let data = data, let image = UIImage(data: data) else {
                // Handle error or show a placeholder image
                return
            }
            
            // Update the UI on the main thread
            DispatchQueue.main.async {
                self?.imageView2.image = image
            }
        }.resume()
    }
    
}
   
extension NotificationViewController: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        startAutomaticSliding()
//    }
//
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAutomaticSliding()
    }

    func startAutomaticSliding() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(automaticSlide), userInfo: nil, repeats: true)
    }

    func stopAutomaticSliding() {
        timer?.invalidate()
        timer = nil
    }

    @objc func automaticSlide() {
        if currentPage < imageUrls.count - 1 {
            currentPage += 1
        } else {
            currentPage = 0
        }
        collectionViewCaroussel.scrollToItem(at: IndexPath(row: currentPage, section: 0), at: .right, animated: true)
        pageControl.currentPage = currentPage
    }

    
    
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageUrls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as? CarouselCell else {
            return UICollectionViewCell()
        }

        // Load image from URL and display in the cell
        if let url = URL(string: imageUrls[indexPath.row]) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        cell.imageView.image = image
                    }
                }
            }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: self.view.frame.size.width, height: 104.0)
        let cellWidth = collectionView.frame.width // Set the cell width to the collection view width
               // Set the desired cell height
        let cellHeight = collectionView.frame.height

               return CGSize(width: cellWidth, height: cellHeight)
           
    }
    
}

 
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//
//https://vod-progressive.akamaized.net/exp=1696910514~acl=%2Fvimeo-prod-skyfire-std-us%2F01%2F3879%2F11%2F294398597%2F1119067365.mp4~hmac=242a77799fcfb477e0c4604b9d6d2738ffdfdc257721ec0afb15a2bbc5693dd9/vimeo-prod-skyfire-std-us/01/3879/11/294398597/1119067365.mp4?download=1&filename=pexels_videos_1494295+%281080p%29.mp4
//
    
    
  /*
    func didReceive(_ notification: UNNotification) {
        
        
    
        if let title = notification.request.content.userInfo["title"] as? String{
                    print("title == \(title)")
            view1.isHidden=false
            hview1.constant = 70
            
            preferredContentSize = CGSize(width: view1.bounds.size.width, height: hview1.constant)
           
            }
        if let title = notification.request.content.userInfo["imageUrL"] as? [String]{
            preferredContentSize = CGSize(width: view.bounds.size.width, height: view.bounds.size.height)

            print("title == \(title)")
            view3.isHidden=false

            }
        if let title = notification.request.content.userInfo["imageUrL"] as? String{
            print("title == \(title)")
            guard let imageURLString = notification.request.content.userInfo["imageUrL"] as? String,
                          let imageURL = URL(string: imageURLString) else {
                        return
                    }
                    
                    // Download the image from the URL
                    downloadImage(from: imageURL)
                }
                
                func downloadImage(from url: URL) {
                    URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                        guard error == nil, let data = data, let image = UIImage(data: data) else {
                            // Handle error or show a placeholder image
                            return
                        }
                        
                        // Update the UI on the main thread
                        DispatchQueue.main.async {
                            self?.imageView2.image = image
                        }
                    }.resume()
                
            
            view2.isHidden=false

            }
        if let title = notification.request.content.userInfo["video_url"] as? String{
            print("title == \(title)")
            view4.isHidden=false

            }
        let content = notification.request.content
        print(notification.request.content.userInfo)
        //self.label?.text = notification.request.content.body
        let notificationText = "\(notification.request.content.title) \(notification.request.content.body)"
                
                // Calculate the size needed for the given text and the font used
        let size = notificationText.size(withAttributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17.0) // Adjust font size as needed
            ])

            // Calculate the height needed for the text and add extra padding
            let heightNeeded = size.height+10 // Adjust the padding as needed

            // Set the preferred content size based on the calculated width and the height needed
            preferredContentSize = CGSize(width: view1.bounds.size.width, height: heightNeeded)
                
                // Set the preferred content size based on the calculated size
               // preferredContentSize = CGSize(width: view.bounds.size.width, height: size.height) // Add some extra height
                
                // Update your UI components accordingly
        self.label?.preferredMaxLayoutWidth = 40
                self.label?.text = "powered by wigzo"
                self.label?.textColor = UIColor(red: 86/255, green: 86/255, blue: 86/255, alpha: 1.0)
                self.label?.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
            
            // Set the left constraint
                self.label?.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60).isActive = true
                self.label?.widthAnchor.constraint(equalToConstant: size.width).isActive = true
        view1.frame = CGRect(x: view1.frame.origin.x, y: view1.frame.origin.y, width: view1.frame.width, height: heightNeeded)


       
//        guard let attachment = content.attachments.first else { return }
//
//        if attachment.url.startAccessingSecurityScopedResource() {
//            if let imageData = try? Data(contentsOf: attachment.url) {
//                if let image = UIImage(data: imageData) {
//                    imageView2.image = image
//                }
//            }
//        }
//        attachment.url.stopAccessingSecurityScopedResource()
    }
     
 */




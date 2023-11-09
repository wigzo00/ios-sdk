//
//  File.swift
//
//
//  Created by Shivam Ratnam on 30/10/23.
//

import UIKit


class Util {
    static func convertHexColortoUI(color name: String) -> UIColor? {
        guard !name.isEmpty else { return nil }
        return UIColor.red
    }
}

public class InAppNotificationViewController: UIViewController {
    var payload: NotificationDataModel?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        // Perform any custom initialization here
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        if let payload = payload {
            // Access the data from the payload
            let notificationTitle = payload.notification?.title
            let button = payload.data?.button
            let imageURLs = payload.data?.imageUrl
           
            
            // Example: Display the title in a UILabel
            let titleLabel = UILabel()
            titleLabel.text = notificationTitle
            titleLabel.textColor = .red // Util.convertHexColortoUI(color: notificationDetails?.templateBackground ?? "");
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(titleLabel)
            titleLabel.numberOfLines = .zero
            titleLabel.textAlignment = .center
            
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(imageView)
            if let imageURLString = imageURLs?.first, let imageURL = URL(string: imageURLString) {
                let session = URLSession.shared.dataTask(with: imageURL) { data, response, error in
                    if let error = error {
                        print("Error loading image: \(error)")
                        return
                    }
                    
                    if let data = data, let image = UIImage(data: data) {
                        // Update the UI on the main thread
                        DispatchQueue.main.async {
                            imageView.image = image
                        }
                    }
                }
                session.resume()
            }
            let dismissButton = UIButton(type: .custom)
            dismissButton.translatesAutoresizingMaskIntoConstraints = false
            
            // Set the custom image as the button's background image
            var dismissImage = UIImage()
            if #available(iOS 13.0, *) {
                dismissImage = UIImage(systemName: "xmark.circle.fill")!
            } else {
                // Fallback on earlier versions
            } // Use the name of your custom image asset
            dismissButton.setBackgroundImage(dismissImage, for: .normal)
            
            // Customize the appearance of the button
            dismissButton.tintColor = UIColor.white
            
            // Add the dismiss button to your view
            view.addSubview(dismissButton)
            NSLayoutConstraint.activate([
                dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
            ])
            dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
            
            
            
            let buttonStackView = UIStackView()
            buttonStackView.axis = .horizontal
            buttonStackView.distribution = .fillEqually // Distribute buttons equally
            buttonStackView.spacing = 10 // Adjust the spacing between buttons
            buttonStackView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(buttonStackView)
            
            // Add multiple buttons to the stack view
            for buttonIndex in 1...2 {
                let button = UIButton(type: .system)
                button.setTitle("Button \(buttonIndex)", for: .normal)
                button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                button.translatesAutoresizingMaskIntoConstraints = false
                
                if buttonIndex == 1 {
                    button.setTitleColor(UIColor.black, for: .normal)
                    button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                    button.layer.frame.size = CGSize(width: 138, height: 43)
                    button.layer.cornerRadius = 5
                    button.backgroundColor = .white
                    button.layer.borderColor = UIColor.black.cgColor // Change the color to the desired border color
                    button.layer.borderWidth = 1.0 // Adjust the width of the border as needed
                    
                    
                } else {
                    button.setTitleColor(UIColor.white, for: .normal)
                    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
                    button.layer.frame.size = CGSize(width: 138, height: 43)
                    button.layer.cornerRadius = 5
                    button.backgroundColor = .black
                }
                
                
                buttonStackView.addArrangedSubview(button)
            }
            // Add constraints
            NSLayoutConstraint.activate([
                // Title label constraints
                imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: -20),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                imageView.heightAnchor.constraint(equalToConstant: 232),
                
                
                
                titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
                titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                
                buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                buttonStackView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -50), // Align buttonStackView at the bottom of the view
                buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
                
            ])
        }
    }
    @objc func buttonTapped() {
        // Handle button tap here
        // You can perform any action you want when the button is tapped
        print("tapped successfully")
    }
    
    
    @objc func dismissButtonTapped() {
        // Implement the action to dismiss the view here
        // For example: self.dismiss(animated: true, completion: nil)
        self.view.removeFromSuperview()
    }
}






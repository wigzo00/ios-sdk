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
    public override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            calculatePreferredSize()
        }
    func calculatePreferredSize() {
        let targetSize = CGSize(width: view.bounds.width,
                                height: UIView.layoutFittingCompressedSize.height)
        preferredContentSize = view.systemLayoutSizeFitting(targetSize)
    }
    func extractFontSize(from input: String) -> CGFloat? {
        // Remove "px" from the end of the string
        let trimmedString = input.replacingOccurrences(of: "px", with: "").trimmingCharacters(in: .whitespaces)
        
        // Attempt to convert the trimmed string to a CGFloat
        if let doubleValue = Double(trimmedString) {
            return CGFloat(doubleValue)
        } else {
            // Return nil if conversion is not possible
            return nil
        }
    }

    
    public override func viewDidLoad() {
        super.viewDidLoad()
       

        if let payload = payload {
            // Access the data from the payload
            let notificationTitle = payload.notification?.title
            let buttonArray = payload.data?.button ?? []

            let imageURLs = payload.data?.imageUrl
            let templateOrientation = payload.data?.notificationDetails?.templateOrientation
            let description = payload.data?.description
            if let templateBackground = payload.data?.notificationDetails?.templateBackground,
               let templateColor = UIColor(hex: templateBackground) {
                view.backgroundColor = templateColor
            }
            let titleColor = payload.data?.notificationDetails?.titleColor
            let descriptionFontColor = payload.data?.notificationDetails?.descriptionFontColor
            
            let titleFontSizeString = payload.data?.notificationDetails?.titleFontSize
            let trimmedFontSizeStringForTitle = titleFontSizeString!.replacingOccurrences(of: "px", with: "")
            let sizeForTitle = Float(trimmedFontSizeStringForTitle)
            let descriptionFontSizeString = payload.data?.notificationDetails?.descriptionFontSize
            let trimmedFontSizeforDescription = descriptionFontSizeString!.replacingOccurrences(of: "px", with: "")
            let sizeForDescription = Float(trimmedFontSizeforDescription)
            
            
            
            
           
            
            // Example: Display the title in a UILabel
            if templateOrientation == "top" {
                
              
                let mainStackView = UIStackView()
                mainStackView.axis = .horizontal
                mainStackView.distribution = .fillProportionally
                mainStackView.spacing = 10
                mainStackView.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(mainStackView)

                let titleLabel = UILabel()
                titleLabel.text = notificationTitle
                titleLabel.textColor = UIColor(hex: titleColor!)
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                titleLabel.numberOfLines = 0
                	
                titleLabel.textAlignment = .left
               
                titleLabel.font = UIFont.systemFont(ofSize: CGFloat(sizeForTitle!))
                
                let descriptionTxt = UILabel()
                descriptionTxt.text = description
                descriptionTxt.translatesAutoresizingMaskIntoConstraints = false
                descriptionTxt.numberOfLines = 0
                descriptionTxt.textAlignment = .left
                descriptionTxt.textColor = UIColor(hex: descriptionFontColor!)
                descriptionTxt.font = UIFont.systemFont(ofSize: CGFloat(sizeForDescription!))

                

                let dismissButton = UIButton(type: .custom)
                dismissButton.translatesAutoresizingMaskIntoConstraints = false
                
                // Set the custom image as the button's background image
                var dismissImage = UIImage()
                if #available(iOS 13.0, *) {
                    dismissImage = UIImage(systemName: "xmark.circle.fill")!
                } else {
                    // Fallback on earlier versions
                } // Use the name of your custom image asset
                dismissButton.setImage(dismissImage, for: .normal)
                
                // Customize the appearance of the button
                dismissButton.tintColor = UIColor.black
                
                // Add the dismiss button to your view
                dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
                
                
                let labelStackView = UIStackView()
                labelStackView.axis = .vertical
                labelStackView.alignment = .top
                labelStackView.distribution = .fillProportionally
                labelStackView.spacing = 10
                labelStackView.translatesAutoresizingMaskIntoConstraints = false
                labelStackView.addArrangedSubview(titleLabel)
                labelStackView.addArrangedSubview(descriptionTxt)
                

                let buttonStackView = UIStackView()
                buttonStackView.axis = payload.data?.notificationDetails?.buttonOrientation?.lowercased() == "horizontal".lowercased() ? .horizontal : .vertical
                buttonStackView.distribution = .fillEqually
                buttonStackView.spacing = 10
                buttonStackView.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(buttonStackView)
                view.addSubview(dismissButton)


                for (buttonIndex, buttonObj) in buttonArray.enumerated() {
                    let button = UIButton(type: .system)
                    button.setTitle(buttonObj.buttonName, for: .normal)
                    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                    button.translatesAutoresizingMaskIntoConstraints = false
                    
                    if buttonIndex == 0 {
                        
                        let size = extractFontSize(from: buttonObj.buttonFontSize!)
                        button.titleLabel?.font = UIFont.systemFont(ofSize: size!)
                        let fontColor = UIColor(hex: buttonObj.buttonFontColor!)
                        button.setTitleColor(fontColor, for: .normal)
//
//                        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                       // button.layer.frame.size = CGSize(width: 138, height: 30)
                        button.layer.cornerRadius = 5
                        button.backgroundColor = UIColor(hex: buttonObj.buttonColor!)
                        
                        button.layer.borderColor = UIColor.black.cgColor
                        button.layer.borderWidth = 1.0
                    } else {
                        let fontColor = UIColor(hex: buttonObj.buttonFontColor!)
                        button.setTitleColor(fontColor, for: .normal)
                        let size = extractFontSize(from: buttonObj.buttonFontSize!)
                        button.titleLabel?.font = UIFont.systemFont(ofSize: size!)
                       // button.layer.frame.size = CGSize(width: 138, height: 30)
                        button.layer.cornerRadius = 5
                        button.backgroundColor = UIColor(hex: buttonObj.buttonColor!)
                    }

                    buttonStackView.addArrangedSubview(button)
                }
               
                if payload.data?.notificationDetails?.buttonOrientation == "horizontal"{
                    buttonStackView.distribution = .fillEqually
                }
                else{
                    buttonStackView.distribution = .fill
                }
                
                
                
                let imageView = UIImageView()

                // Check if imageURLs is not empty and the first URL is valid
                if let imageURLString = imageURLs?.first, !imageURLString.isEmpty, let imageURL = URL(string: imageURLString) {
                    imageView.contentMode = .scaleAspectFit
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    mainStackView.addArrangedSubview(imageView)
                    
                    let subview2Width = imageView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.3)
                    NSLayoutConstraint.activate([subview2Width])
                    
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
                
                
                mainStackView.addArrangedSubview(labelStackView)

               
                // Add constraints
                NSLayoutConstraint.activate([
                    // Main stack view constraints
                   
                    mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                    mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                    mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    mainStackView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -10),

                    // Button stack view constraints
                    buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
                    buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
                   // buttonStackView.heightAnchor.constraint(equalToConstant: 30),
                  
                    dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                    dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
                ])
//                    mainStackView.bottomAnchor.constraint(greaterThanOrEqualTo: buttonStackView.bottomAnchor, constant: 20).isActive = true
                    mainStackView.bottomAnchor.constraint(greaterThanOrEqualTo: labelStackView.bottomAnchor, constant: 10).isActive = true
            }

                
            else if templateOrientation == "middle" {
                
                let mainStackView = UIStackView()
                mainStackView.axis = .vertical
                mainStackView.distribution = .fill
//                mainStackView.spacing = 10
                mainStackView.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(mainStackView)
                
                let titleLabel = UILabel()
                titleLabel.text = notificationTitle
                titleLabel.textColor = UIColor(hex: titleColor!)
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
//                view.addSubview(titleLabel)
                titleLabel.numberOfLines = 0
                titleLabel.textAlignment = .center
                titleLabel.font = UIFont.systemFont(ofSize: CGFloat(sizeForTitle!))
                
            
               
                let descriptionTxt = UILabel()
                descriptionTxt.text = description
                descriptionTxt.translatesAutoresizingMaskIntoConstraints = false
//                view.addSubview(descriptionTxt)
                descriptionTxt.numberOfLines = 0
                descriptionTxt.textAlignment = .center
                descriptionTxt.textColor = UIColor(hex: descriptionFontColor!)
                descriptionTxt.font = UIFont.systemFont(ofSize: CGFloat(sizeForDescription!))
                
                
                let labelStackView = UIStackView()
                labelStackView.axis = .vertical
                labelStackView.alignment = .center
                labelStackView.distribution = .fill
                labelStackView.spacing = 10
                labelStackView.translatesAutoresizingMaskIntoConstraints = false
                labelStackView.addArrangedSubview(titleLabel)
                labelStackView.addArrangedSubview(descriptionTxt)
//                view.addSubview(labelStackView)

                 let imageView = UIImageView()

                // Check if imageURLs is not empty and the first URL is valid
                if let imageURLString = imageURLs?.first, !imageURLString.isEmpty, let imageURL = URL(string: imageURLString) {
                    imageView.contentMode = .scaleAspectFill
                    imageView.translatesAutoresizingMaskIntoConstraints = false
//                   view.addSubview(imageView)
                    mainStackView.addArrangedSubview(imageView)
                    NSLayoutConstraint.activate([
//                    imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
//                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
                    imageView.heightAnchor.constraint(equalToConstant: 232),
                    
])
                    
//                    let subview2Width = imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
//                    NSLayoutConstraint.activate([subview2Width])
                    
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
                buttonStackView.axis = payload.data?.notificationDetails?.buttonOrientation?.lowercased() == "horizontal".lowercased() ? .horizontal : .vertical
                buttonStackView.distribution = .fillEqually // Distribute buttons equally
                buttonStackView.spacing = 10 // Adjust the spacing between buttons
                buttonStackView.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(buttonStackView)

                
                
                // Add multiple buttons to the stack view
                
                for (buttonIndex, buttonObj) in buttonArray.enumerated() {
                    let button = UIButton(type: .system)
                    button.setTitle(buttonObj.buttonName, for: .normal)
                    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                    button.translatesAutoresizingMaskIntoConstraints = false
                    
                    if buttonIndex == 0 {
                        
                        let size = extractFontSize(from: buttonObj.buttonFontSize!)
                        button.titleLabel?.font = UIFont.systemFont(ofSize: size!)
                        let fontColor = UIColor(hex: buttonObj.buttonFontColor!)
                        button.setTitleColor(fontColor, for: .normal)
//
//                        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                       // button.layer.frame.size = CGSize(width: 138, height: 30)
                        button.layer.cornerRadius = 5
                        button.backgroundColor = UIColor(hex: buttonObj.buttonColor!)
                        
                        button.layer.borderColor = UIColor.black.cgColor
                        button.layer.borderWidth = 1.0
                    } else {
                        let fontColor = UIColor(hex: buttonObj.buttonFontColor!)
                        button.setTitleColor(fontColor, for: .normal)
                        let size = extractFontSize(from: buttonObj.buttonFontSize!)
                        button.titleLabel?.font = UIFont.systemFont(ofSize: size!)
                       // button.layer.frame.size = CGSize(width: 138, height: 30)
                        button.layer.cornerRadius = 5
                        button.backgroundColor = UIColor(hex: buttonObj.buttonColor!)
                    }

                    buttonStackView.addArrangedSubview(button)
                }
                
                let labelView = UIView()
                labelView.translatesAutoresizingMaskIntoConstraints = false
                labelView.addSubview(labelStackView)
                mainStackView.addArrangedSubview(labelView)

                // Add constraints
                //NSLayoutConstraint.activate([
                    // Title label constraints
                   
                    
//                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50)
                    
                    
                    
                NSLayoutConstraint.activate([
                    // Title label constraints
                    
                    labelStackView.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 20),
                    labelStackView.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 10),
                    labelStackView.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -10),
                    labelStackView.bottomAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 20),

                    mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                    mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                    mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//
                    buttonStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 40), // Align buttonStackView below labelStackView
                    buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    
                    buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20) // Align buttonStackView at the bottom of the view
                ])
                view.bottomAnchor.constraint(greaterThanOrEqualTo: buttonStackView.bottomAnchor, constant: 20).isActive = true
            }
            
            if templateOrientation == "footer" {
                
              
                let mainStackView = UIStackView()
                mainStackView.axis = .horizontal
                mainStackView.distribution = .fillProportionally
                mainStackView.spacing = 10
                mainStackView.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(mainStackView)

                let titleLabel = UILabel()
                titleLabel.text = notificationTitle
                titleLabel.textColor = UIColor(hex: titleColor!)
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                titleLabel.numberOfLines = 0
                    
                titleLabel.textAlignment = .left
               
                titleLabel.font = UIFont.systemFont(ofSize: CGFloat(sizeForTitle!))
                
                let descriptionTxt = UILabel()
                descriptionTxt.text = description
                descriptionTxt.translatesAutoresizingMaskIntoConstraints = false
                descriptionTxt.numberOfLines = 0
                descriptionTxt.textAlignment = .left
                descriptionTxt.textColor = UIColor(hex: descriptionFontColor!)
                descriptionTxt.font = UIFont.systemFont(ofSize: CGFloat(sizeForDescription!))

                

                let dismissButton = UIButton(type: .custom)
                dismissButton.translatesAutoresizingMaskIntoConstraints = false
                
                // Set the custom image as the button's background image
                var dismissImage = UIImage()
                if #available(iOS 13.0, *) {
                    dismissImage = UIImage(systemName: "xmark.circle.fill")!
                } else {
                    // Fallback on earlier versions
                } // Use the name of your custom image asset
                dismissButton.setImage(dismissImage, for: .normal)
                
                // Customize the appearance of the button
                dismissButton.tintColor = UIColor.black
                
                // Add the dismiss button to your view
                dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
                
                
                let labelStackView = UIStackView()
                labelStackView.axis = .vertical
                labelStackView.alignment = .top
                labelStackView.distribution = .fillProportionally
                labelStackView.spacing = 10
                labelStackView.translatesAutoresizingMaskIntoConstraints = false
                labelStackView.addArrangedSubview(titleLabel)
                labelStackView.addArrangedSubview(descriptionTxt)
                

                let buttonStackView = UIStackView()
                buttonStackView.axis = payload.data?.notificationDetails?.buttonOrientation?.lowercased() == "horizontal".lowercased() ? .horizontal : .vertical
                buttonStackView.distribution = .fillEqually
                buttonStackView.spacing = 10
                buttonStackView.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(buttonStackView)
                view.addSubview(dismissButton)


                for (buttonIndex, buttonObj) in buttonArray.enumerated() {
                    let button = UIButton(type: .system)
                    button.setTitle(buttonObj.buttonName, for: .normal)
                    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                    button.translatesAutoresizingMaskIntoConstraints = false
                    
                    if buttonIndex == 0 {
                        
                        let size = extractFontSize(from: buttonObj.buttonFontSize!)
                        button.titleLabel?.font = UIFont.systemFont(ofSize: size!)
                        let fontColor = UIColor(hex: buttonObj.buttonFontColor!)
                        button.setTitleColor(fontColor, for: .normal)
//
//                        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                       // button.layer.frame.size = CGSize(width: 138, height: 30)
                        button.layer.cornerRadius = 5
                        button.backgroundColor = UIColor(hex: buttonObj.buttonColor!)
                        
                        button.layer.borderColor = UIColor.black.cgColor
                        button.layer.borderWidth = 1.0
                    } else {
                        let fontColor = UIColor(hex: buttonObj.buttonFontColor!)
                        button.setTitleColor(fontColor, for: .normal)
                        let size = extractFontSize(from: buttonObj.buttonFontSize!)
                        button.titleLabel?.font = UIFont.systemFont(ofSize: size!)
                       // button.layer.frame.size = CGSize(width: 138, height: 30)
                        button.layer.cornerRadius = 5
                        button.backgroundColor = UIColor(hex: buttonObj.buttonColor!)
                    }

                    buttonStackView.addArrangedSubview(button)
                }
               
                if payload.data?.notificationDetails?.buttonOrientation == "horizontal"{
                    buttonStackView.distribution = .fillEqually
                }
                else{
                    buttonStackView.distribution = .fill
                }
                
                
                
                let imageView = UIImageView()

                // Check if imageURLs is not empty and the first URL is valid
                if let imageURLString = imageURLs?.first, !imageURLString.isEmpty, let imageURL = URL(string: imageURLString) {
                    imageView.contentMode = .scaleAspectFit
                    imageView.translatesAutoresizingMaskIntoConstraints = false
                    mainStackView.addArrangedSubview(imageView)
                    
                    let subview2Width = imageView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.3)
                    NSLayoutConstraint.activate([subview2Width])
                    
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
                
                
                mainStackView.addArrangedSubview(labelStackView)

               
                // Add constraints
                NSLayoutConstraint.activate([
                    // Main stack view constraints
                   
                    mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                    mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                    mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    mainStackView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -10),

                    // Button stack view constraints
                    buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
                    buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
                   // buttonStackView.heightAnchor.constraint(equalToConstant: 30),
                  
                    dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                    dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
                ])
//                    mainStackView.bottomAnchor.constraint(greaterThanOrEqualTo: buttonStackView.bottomAnchor, constant: 20).isActive = true
                    mainStackView.bottomAnchor.constraint(greaterThanOrEqualTo: labelStackView.bottomAnchor, constant: 10).isActive = true
            }
                
            else if templateOrientation == "fullScreen" {
                let imageView = UIImageView()
                              //  imageView.contentMode = .scaleAspectFit
                                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.contentMode = .scaleAspectFill
                imageView.clipsToBounds = true
                view.backgroundColor = .gray
                                view.addSubview(imageView)
                let titleLabel = UILabel()
                titleLabel.text = notificationTitle
                titleLabel.textColor = UIColor(hex: titleColor!)
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(titleLabel)
                titleLabel.numberOfLines = 0
                titleLabel.textAlignment = .center
                titleLabel.font = UIFont.systemFont(ofSize: CGFloat(sizeForTitle!))

                
                let descriptionTxt = UILabel()
                descriptionTxt.text = description
                descriptionTxt.translatesAutoresizingMaskIntoConstraints = false
                view.addSubview(descriptionTxt)
                descriptionTxt.numberOfLines = 0
                descriptionTxt.textAlignment = .center
                descriptionTxt.textColor = UIColor(hex: descriptionFontColor!)
                descriptionTxt.font = UIFont.systemFont(ofSize: CGFloat(sizeForDescription!))

                                // Load the image asynchronously
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

                                let buttonStackView = UIStackView()
                buttonStackView.axis = payload.data?.notificationDetails?.buttonOrientation?.lowercased() == "horizontal".lowercased() ? .horizontal : .vertical
                                buttonStackView.distribution = .fillEqually
                                buttonStackView.spacing = 10
                                buttonStackView.translatesAutoresizingMaskIntoConstraints = false
                                view.addSubview(buttonStackView)

                                // Add two buttons to the stack view
                
                for (buttonIndex, buttonObj) in buttonArray.enumerated() {
                    let button = UIButton(type: .system)
                    button.setTitle(buttonObj.buttonName, for: .normal)
                    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
                    button.translatesAutoresizingMaskIntoConstraints = false
                    
                    if buttonIndex == 0 {
                        
                        let size = extractFontSize(from: buttonObj.buttonFontSize!)
                        button.titleLabel?.font = UIFont.systemFont(ofSize: size!)
                        let fontColor = UIColor(hex: buttonObj.buttonFontColor!)
                        button.setTitleColor(fontColor, for: .normal)
//
//                        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                       // button.layer.frame.size = CGSize(width: 138, height: 30)
                        button.layer.cornerRadius = 5
                        button.backgroundColor = UIColor(hex: buttonObj.buttonColor!)
                        
                        button.layer.borderColor = UIColor.black.cgColor
                        button.layer.borderWidth = 1.0
                    } else {
                        let fontColor = UIColor(hex: buttonObj.buttonFontColor!)
                        button.setTitleColor(fontColor, for: .normal)
                        let size = extractFontSize(from: buttonObj.buttonFontSize!)
                        button.titleLabel?.font = UIFont.systemFont(ofSize: size!)
                       // button.layer.frame.size = CGSize(width: 138, height: 30)
                        button.layer.cornerRadius = 5
                        button.backgroundColor = UIColor(hex: buttonObj.buttonColor!)
                    }

                    buttonStackView.addArrangedSubview(button)
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
                dismissButton.setImage(dismissImage, for: .normal)
                
                // Customize the appearance of the button
                dismissButton.tintColor = UIColor.white
                dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
                // Add the dismiss button to your view
                view.addSubview(dismissButton)
                
                
                                // Set up constraints
                                NSLayoutConstraint.activate([
                                    // Image view constraints
                                    imageView.topAnchor.constraint(equalTo: view.topAnchor),
                                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                    
                                    titleLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
                                    titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
                                    titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
                                   
                                    
                                    descriptionTxt.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
                                    descriptionTxt.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
                                    descriptionTxt.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
                                    
                                    // Button stack view constraints
                                    buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                                    buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
                                    buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),

                                    // Dismiss button constraints
                                    dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
                                    dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
                                    dismissButton.heightAnchor.constraint(equalToConstant: 40),
                                    dismissButton.widthAnchor.constraint(equalToConstant: 40),
                                ])
               
                            }
                
            else{
                
            }
        }
    }
    @objc func buttonTapped(sender: UIButton) {
        let buttonArray = payload?.data?.button ?? []
        // Ensure the tapped index is within the bounds of the buttonArray
        guard sender.tag < buttonArray.count else {
            return
        }

        let buttonObj = buttonArray[sender.tag]

        // Open the URL associated with the tapped button
        if let buttonURLString = buttonObj.buttonUrl, let buttonURL = URL(string: buttonURLString) {
            UIApplication.shared.open(buttonURL, options: [:], completionHandler: nil)
        }
    }
    
    @objc func dismissButtonTapped() {
        // Implement the action to dismiss the view here
        self.view.removeFromSuperview()
        
    }
}
extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
            return nil
        }

        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: 1.0
        )
    }
}






////
////  File.swift
////
////
////  Created by Shivam Ratnam on 30/10/23.
////
//
//import UIKit
//
//
//class Util {
//    static func convertHexColortoUI(color name: String) -> UIColor? {
//        guard !name.isEmpty else { return nil }
//        return UIColor.red
//    }
//}
//
//public class InAppNotificationViewController: UIViewController {
//    var payload: NotificationDataModel?
//
//    init() {
//        super.init(nibName: nil, bundle: nil)
//        // Perform any custom initialization here
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    public override func viewDidLayoutSubviews() {
//            super.viewDidLayoutSubviews()
//            calculatePreferredSize()
//        }
//    func calculatePreferredSize() {
//        let targetSize = CGSize(width: view.bounds.width,
//                                height: UIView.layoutFittingCompressedSize.height)
//        preferredContentSize = view.systemLayoutSizeFitting(targetSize)
//    }
//    func extractFontSize(from input: String) -> CGFloat? {
//        // Remove "px" from the end of the string
//        let trimmedString = input.replacingOccurrences(of: "px", with: "").trimmingCharacters(in: .whitespaces)
//
//        // Attempt to convert the trimmed string to a CGFloat
//        if let doubleValue = Double(trimmedString) {
//            return CGFloat(doubleValue)
//        } else {
//            // Return nil if conversion is not possible
//            return nil
//        }
//    }
//
//
//    public override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        if let payload = payload {
//            // Access the data from the payload
//            let notificationTitle = payload.notification?.title
//            let buttonArray = payload.data?.button ?? []
//
//            let imageURLs = payload.data?.imageUrl
//            let templateOrientation = payload.data?.notificationDetails?.templateOrientation
//            let description = payload.data?.description
//            if let templateBackground = payload.data?.notificationDetails?.templateBackground,
//               let templateColor = UIColor(hex: templateBackground) {
//                view.backgroundColor = templateColor
//            }
//            let titleColor = payload.data?.notificationDetails?.titleColor
//            let descriptionFontColor = payload.data?.notificationDetails?.descriptionFontColor
//
//            let titleFontSizeString = payload.data?.notificationDetails?.titleFontSize
//            let trimmedFontSizeStringForTitle = titleFontSizeString!.replacingOccurrences(of: "px", with: "")
//            let sizeForTitle = Float(trimmedFontSizeStringForTitle)
//            let descriptionFontSizeString = payload.data?.notificationDetails?.descriptionFontSize
//            let trimmedFontSizeforDescription = descriptionFontSizeString!.replacingOccurrences(of: "px", with: "")
//            let sizeForDescription = Float(trimmedFontSizeforDescription)
//
//
//
//
//
//
//            // Example: Display the title in a UILabel
//            if templateOrientation == "top" {
//
//
//                let mainStackView = UIStackView()
//                mainStackView.axis = .horizontal
//                mainStackView.distribution = .fillProportionally
//                mainStackView.spacing = 10
//                mainStackView.translatesAutoresizingMaskIntoConstraints = false
//                view.addSubview(mainStackView)
//
//                let titleLabel = UILabel()
//                titleLabel.text = notificationTitle
//                titleLabel.textColor = UIColor(hex: titleColor!)
//                titleLabel.translatesAutoresizingMaskIntoConstraints = false
//                titleLabel.numberOfLines = 0
//
//                titleLabel.textAlignment = .left
//
//                titleLabel.font = UIFont.systemFont(ofSize: CGFloat(sizeForTitle!))
//
//                let descriptionTxt = UILabel()
//                descriptionTxt.text = description
//                descriptionTxt.translatesAutoresizingMaskIntoConstraints = false
//                descriptionTxt.numberOfLines = 0
//                descriptionTxt.textAlignment = .left
//                descriptionTxt.textColor = UIColor(hex: descriptionFontColor!)
//                descriptionTxt.font = UIFont.systemFont(ofSize: CGFloat(sizeForDescription!))
//
//
//
//                let dismissButton = UIButton(type: .custom)
//                dismissButton.translatesAutoresizingMaskIntoConstraints = false
//
//                // Set the custom image as the button's background image
//                var dismissImage = UIImage()
//                if #available(iOS 13.0, *) {
//                    dismissImage = UIImage(systemName: "xmark.circle.fill")!
//                } else {
//                    // Fallback on earlier versions
//                } // Use the name of your custom image asset
//                dismissButton.setImage(dismissImage, for: .normal)
//
//                // Customize the appearance of the button
//                dismissButton.tintColor = UIColor.black
//
//                // Add the dismiss button to your view
//                dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
//
//
//                let labelStackView = UIStackView()
//                labelStackView.axis = .vertical
//                labelStackView.alignment = .top
//                labelStackView.distribution = .fillProportionally
//                labelStackView.spacing = 10
//                labelStackView.translatesAutoresizingMaskIntoConstraints = false
//                labelStackView.addArrangedSubview(titleLabel)
//                labelStackView.addArrangedSubview(descriptionTxt)
//
//
//                let buttonStackView = UIStackView()
//                buttonStackView.axis = payload.data?.notificationDetails?.buttonOrientation?.lowercased() == "horizontal".lowercased() ? .horizontal : .vertical
//                buttonStackView.distribution = .fillEqually
//                buttonStackView.spacing = 10
//                buttonStackView.translatesAutoresizingMaskIntoConstraints = false
//                view.addSubview(buttonStackView)
//                view.addSubview(dismissButton)
//
//
//                for (buttonIndex, buttonObj) in buttonArray.enumerated() {
//                    let button = UIButton(type: .system)
//                    button.setTitle(buttonObj.buttonName, for: .normal)
//                    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
//                    button.translatesAutoresizingMaskIntoConstraints = false
//
//                    if buttonIndex == 0 {
//
//                        let size = extractFontSize(from: buttonObj.buttonFontSize!)
//                        button.titleLabel?.font = UIFont.systemFont(ofSize: size!)
//                        let fontColor = UIColor(hex: buttonObj.buttonFontColor!)
//                        button.setTitleColor(fontColor, for: .normal)
////
////                        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//                       // button.layer.frame.size = CGSize(width: 138, height: 30)
//                        button.layer.cornerRadius = 5
//                        button.backgroundColor = UIColor(hex: buttonObj.buttonColor!)
//
//                        button.layer.borderColor = UIColor.black.cgColor
//                        button.layer.borderWidth = 1.0
//                    } else {
//                        let fontColor = UIColor(hex: buttonObj.buttonFontColor!)
//                        button.setTitleColor(fontColor, for: .normal)
//                        let size = extractFontSize(from: buttonObj.buttonFontSize!)
//                        button.titleLabel?.font = UIFont.systemFont(ofSize: size!)
//                       // button.layer.frame.size = CGSize(width: 138, height: 30)
//                        button.layer.cornerRadius = 5
//                        button.backgroundColor = UIColor(hex: buttonObj.buttonColor!)
//                    }
//
//                    buttonStackView.addArrangedSubview(button)
//                }
//
//                if payload.data?.notificationDetails?.buttonOrientation == "horizontal"{
//                    buttonStackView.distribution = .fillEqually
//                }
//                else{
//                    buttonStackView.distribution = .fill
//                }
//
//
//
//                let imageView = UIImageView()
//
//                // Check if imageURLs is not empty and the first URL is valid
//                if let imageURLString = imageURLs?.first, !imageURLString.isEmpty, let imageURL = URL(string: imageURLString) {
//                    imageView.contentMode = .scaleAspectFit
//                    imageView.translatesAutoresizingMaskIntoConstraints = false
//                    mainStackView.addArrangedSubview(imageView)
//
//                    let subview2Width = imageView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.3)
//                    NSLayoutConstraint.activate([subview2Width])
//
//                    let session = URLSession.shared.dataTask(with: imageURL) { data, response, error in
//                        if let error = error {
//                            print("Error loading image: \(error)")
//                            return
//                        }
//
//                        if let data = data, let image = UIImage(data: data) {
//                            // Update the UI on the main thread
//                            DispatchQueue.main.async {
//                                imageView.image = image
//                            }
//                        }
//                    }
//
//                    session.resume()
//                }
//
//
//                mainStackView.addArrangedSubview(labelStackView)
//
//
//                // Add constraints
//                NSLayoutConstraint.activate([
//                    // Main stack view constraints
//
//                    mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
//                    mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//                    mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//                    mainStackView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -10),
//
//                    // Button stack view constraints
//                    buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
//                    buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//                    buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
//                   // buttonStackView.heightAnchor.constraint(equalToConstant: 30),
//
//                    dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
//                    dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
//                ])
////                    mainStackView.bottomAnchor.constraint(greaterThanOrEqualTo: buttonStackView.bottomAnchor, constant: 20).isActive = true
//                    mainStackView.bottomAnchor.constraint(greaterThanOrEqualTo: labelStackView.bottomAnchor, constant: 10).isActive = true
//            }
//
//
//            else if templateOrientation == "middle" {
//
//                let mainStackView = UIStackView()
//                mainStackView.axis = .vertical
//                mainStackView.distribution = .fill
////                mainStackView.spacing = 10
//                mainStackView.translatesAutoresizingMaskIntoConstraints = false
//                view.addSubview(mainStackView)
//
//                let titleLabel = UILabel()
//                titleLabel.text = notificationTitle
//                titleLabel.textColor = UIColor(hex: titleColor!)
//                titleLabel.translatesAutoresizingMaskIntoConstraints = false
////                view.addSubview(titleLabel)
//                titleLabel.numberOfLines = 0
//                titleLabel.textAlignment = .center
//                titleLabel.font = UIFont.systemFont(ofSize: CGFloat(sizeForTitle!))
//
//
//
//                let descriptionTxt = UILabel()
//                descriptionTxt.text = description
//                descriptionTxt.translatesAutoresizingMaskIntoConstraints = false
////                                view.addSubview(descriptionTxt)
//                descriptionTxt.numberOfLines = 0
//                descriptionTxt.textAlignment = .center
//                descriptionTxt.textColor = UIColor(hex: descriptionFontColor!)
//                descriptionTxt.font = UIFont.systemFont(ofSize: CGFloat(sizeForDescription!))
//
//
//                let labelStackView = UIStackView()
//                labelStackView.axis = .vertical
//                labelStackView.alignment = .center
//                labelStackView.distribution = .fill
//                labelStackView.spacing = 10
//                labelStackView.translatesAutoresizingMaskIntoConstraints = false
//                labelStackView.addArrangedSubview(titleLabel)
//                labelStackView.addArrangedSubview(descriptionTxt)
////                view.addSubview(labelStackView)
//
//                 let imageView = UIImageView()
//
//                // Check if imageURLs is not empty and the first URL is valid
//                if let imageURLString = imageURLs?.first, !imageURLString.isEmpty, let imageURL = URL(string: imageURLString) {
//                    imageView.contentMode = .scaleAspectFill
//                    imageView.translatesAutoresizingMaskIntoConstraints = false
////                   view.addSubview(imageView)
//                    mainStackView.addArrangedSubview(imageView)
//                    NSLayoutConstraint.activate([
////                    imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
////                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
////                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//                    imageView.heightAnchor.constraint(equalToConstant: 232),
//
//])
//
////                    let subview2Width = imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1)
////                    NSLayoutConstraint.activate([subview2Width])
//
//                    let session = URLSession.shared.dataTask(with: imageURL) { data, response, error in
//                        if let error = error {
//                            print("Error loading image: \(error)")
//                            return
//                        }
//
//                        if let data = data, let image = UIImage(data: data) {
//                            // Update the UI on the main thread
//                            DispatchQueue.main.async {
//                                imageView.image = image
//                            }
//                        }
//                    }
//
//                    session.resume()
//
//                }
//
//
//
//                let dismissButton = UIButton(type: .custom)
//                dismissButton.translatesAutoresizingMaskIntoConstraints = false
//
//                // Set the custom image as the button's background image
//                var dismissImage = UIImage()
//                if #available(iOS 13.0, *) {
//                    dismissImage = UIImage(systemName: "xmark.circle.fill")!
//                } else {
//                    // Fallback on earlier versions
//                } // Use the name of your custom image asset
//                dismissButton.setBackgroundImage(dismissImage, for: .normal)
//
//                // Customize the appearance of the button
//                dismissButton.tintColor = UIColor.white
//
//                // Add the dismiss button to your view
//                view.addSubview(dismissButton)
//                NSLayoutConstraint.activate([
//                    dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
//                    dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
//                ])
//                dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
//
//
//
//                let buttonStackView = UIStackView()
//                buttonStackView.axis = payload.data?.notificationDetails?.buttonOrientation?.lowercased() == "horizontal".lowercased() ? .horizontal : .vertical
//                buttonStackView.distribution = .fillEqually // Distribute buttons equally
//                buttonStackView.spacing = 10 // Adjust the spacing between buttons
//                buttonStackView.translatesAutoresizingMaskIntoConstraints = false
//                view.addSubview(buttonStackView)
//
//
//
//                // Add multiple buttons to the stack view
//
//                for (buttonIndex, buttonObj) in buttonArray.enumerated() {
//                    let button = UIButton(type: .system)
//                    button.setTitle(buttonObj.buttonName, for: .normal)
//                    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
//                    button.translatesAutoresizingMaskIntoConstraints = false
//
//                    if buttonIndex == 0 {
//
//                        let size = extractFontSize(from: buttonObj.buttonFontSize!)
//                        button.titleLabel?.font = UIFont.systemFont(ofSize: size!)
//                        let fontColor = UIColor(hex: buttonObj.buttonFontColor!)
//                        button.setTitleColor(fontColor, for: .normal)
////
////                        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//                       // button.layer.frame.size = CGSize(width: 138, height: 30)
//                        button.layer.cornerRadius = 5
//                        button.backgroundColor = UIColor(hex: buttonObj.buttonColor!)
//
//                        button.layer.borderColor = UIColor.black.cgColor
//                        button.layer.borderWidth = 1.0
//                    } else {
//                        let fontColor = UIColor(hex: buttonObj.buttonFontColor!)
//                        button.setTitleColor(fontColor, for: .normal)
//                        let size = extractFontSize(from: buttonObj.buttonFontSize!)
//                        button.titleLabel?.font = UIFont.systemFont(ofSize: size!)
//                       // button.layer.frame.size = CGSize(width: 138, height: 30)
//                        button.layer.cornerRadius = 5
//                        button.backgroundColor = UIColor(hex: buttonObj.buttonColor!)
//                    }
//
//                    buttonStackView.addArrangedSubview(button)
//                }
//
//                let labelView = UIView()
//                labelView.translatesAutoresizingMaskIntoConstraints = false
//                labelView.addSubview(labelStackView)
//                mainStackView.addArrangedSubview(labelView)
//
//                // Add constraints
//                //NSLayoutConstraint.activate([
//                    // Title label constraints
//
//
////                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 50)
//
//
//
//                NSLayoutConstraint.activate([
//                    // Title label constraints
//
//                    labelStackView.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 20),
//                    labelStackView.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 10),
//                    labelStackView.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -10),
//                    labelStackView.bottomAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 20),
//
//                    mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
//                    mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//                    mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
////
//                    buttonStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 40), // Align buttonStackView below labelStackView
//                    buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//                    buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//
//                    buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20) // Align buttonStackView at the bottom of the view
//                ])
//                view.bottomAnchor.constraint(greaterThanOrEqualTo: buttonStackView.bottomAnchor, constant: 20).isActive = true
//            }
//
//            if templateOrientation == "footer" {
//
//
//                let mainStackView = UIStackView()
//                mainStackView.axis = .horizontal
//                mainStackView.distribution = .fillProportionally
//                mainStackView.spacing = 10
//                mainStackView.translatesAutoresizingMaskIntoConstraints = false
//                view.addSubview(mainStackView)
//
//                let titleLabel = UILabel()
//                titleLabel.text = notificationTitle
//                titleLabel.textColor = UIColor(hex: titleColor!)
//                titleLabel.translatesAutoresizingMaskIntoConstraints = false
//                titleLabel.numberOfLines = 0
//
//                titleLabel.textAlignment = .left
//
//                titleLabel.font = UIFont.systemFont(ofSize: CGFloat(sizeForTitle!))
//
//                let descriptionTxt = UILabel()
//                descriptionTxt.text = description
//                descriptionTxt.translatesAutoresizingMaskIntoConstraints = false
//                descriptionTxt.numberOfLines = 0
//                descriptionTxt.textAlignment = .left
//                descriptionTxt.textColor = UIColor(hex: descriptionFontColor!)
//                descriptionTxt.font = UIFont.systemFont(ofSize: CGFloat(sizeForDescription!))
//
//
//
//                let dismissButton = UIButton(type: .custom)
//                dismissButton.translatesAutoresizingMaskIntoConstraints = false
//
//                // Set the custom image as the button's background image
//                var dismissImage = UIImage()
//                if #available(iOS 13.0, *) {
//                    dismissImage = UIImage(systemName: "xmark.circle.fill")!
//                } else {
//                    // Fallback on earlier versions
//                } // Use the name of your custom image asset
//                dismissButton.setImage(dismissImage, for: .normal)
//
//                // Customize the appearance of the button
//                dismissButton.tintColor = UIColor.black
//
//                // Add the dismiss button to your view
//                dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
//
//
//                let labelStackView = UIStackView()
//                labelStackView.axis = .vertical
//                labelStackView.alignment = .top
//                labelStackView.distribution = .fillProportionally
//                labelStackView.spacing = 10
//                labelStackView.translatesAutoresizingMaskIntoConstraints = false
//                labelStackView.addArrangedSubview(titleLabel)
//                labelStackView.addArrangedSubview(descriptionTxt)
//
//
//                let buttonStackView = UIStackView()
//                buttonStackView.axis = payload.data?.notificationDetails?.buttonOrientation?.lowercased() == "horizontal".lowercased() ? .horizontal : .vertical
//                buttonStackView.distribution = .fillEqually
//                buttonStackView.spacing = 10
//                buttonStackView.translatesAutoresizingMaskIntoConstraints = false
//                view.addSubview(buttonStackView)
//                view.addSubview(dismissButton)
//
//
//                for (buttonIndex, buttonObj) in buttonArray.enumerated() {
//                    let button = UIButton(type: .system)
//                    button.setTitle(buttonObj.buttonName, for: .normal)
//                    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
//                    button.translatesAutoresizingMaskIntoConstraints = false
//
//                    if buttonIndex == 0 {
//
//                        let size = extractFontSize(from: buttonObj.buttonFontSize!)
//                        button.titleLabel?.font = UIFont.systemFont(ofSize: size!)
//                        let fontColor = UIColor(hex: buttonObj.buttonFontColor!)
//                        button.setTitleColor(fontColor, for: .normal)
////
////                        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//                       // button.layer.frame.size = CGSize(width: 138, height: 30)
//                        button.layer.cornerRadius = 5
//                        button.backgroundColor = UIColor(hex: buttonObj.buttonColor!)
//
//                        button.layer.borderColor = UIColor.black.cgColor
//                        button.layer.borderWidth = 1.0
//                    } else {
//                        let fontColor = UIColor(hex: buttonObj.buttonFontColor!)
//                        button.setTitleColor(fontColor, for: .normal)
//                        let size = extractFontSize(from: buttonObj.buttonFontSize!)
//                        button.titleLabel?.font = UIFont.systemFont(ofSize: size!)
//                       // button.layer.frame.size = CGSize(width: 138, height: 30)
//                        button.layer.cornerRadius = 5
//                        button.backgroundColor = UIColor(hex: buttonObj.buttonColor!)
//                    }
//
//                    buttonStackView.addArrangedSubview(button)
//                }
//
//                if payload.data?.notificationDetails?.buttonOrientation == "horizontal"{
//                    buttonStackView.distribution = .fillEqually
//                }
//                else{
//                    buttonStackView.distribution = .fill
//                }
//
//
//
//                let imageView = UIImageView()
//
//                // Check if imageURLs is not empty and the first URL is valid
//                if let imageURLString = imageURLs?.first, !imageURLString.isEmpty, let imageURL = URL(string: imageURLString) {
//                    imageView.contentMode = .scaleAspectFit
//                    imageView.translatesAutoresizingMaskIntoConstraints = false
//                    mainStackView.addArrangedSubview(imageView)
//
//                    let subview2Width = imageView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, multiplier: 0.3)
//                    NSLayoutConstraint.activate([subview2Width])
//
//                    let session = URLSession.shared.dataTask(with: imageURL) { data, response, error in
//                        if let error = error {
//                            print("Error loading image: \(error)")
//                            return
//                        }
//
//                        if let data = data, let image = UIImage(data: data) {
//                            // Update the UI on the main thread
//                            DispatchQueue.main.async {
//                                imageView.image = image
//                            }
//                        }
//                    }
//
//                    session.resume()
//                }
//
//
//                mainStackView.addArrangedSubview(labelStackView)
//
//
//                // Add constraints
//                NSLayoutConstraint.activate([
//                    // Main stack view constraints
//
//                    mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
//                    mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//                    mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//                    mainStackView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -10),
//
//                    // Button stack view constraints
//                    buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
//                    buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//                    buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
//                   // buttonStackView.heightAnchor.constraint(equalToConstant: 30),
//
//                    dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
//                    dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
//                ])
////                    mainStackView.bottomAnchor.constraint(greaterThanOrEqualTo: buttonStackView.bottomAnchor, constant: 20).isActive = true
//                    mainStackView.bottomAnchor.constraint(greaterThanOrEqualTo: labelStackView.bottomAnchor, constant: 10).isActive = true
//            }
//
//            else if templateOrientation == "fullScreen" {
//                let imageView = UIImageView()
//                              //  imageView.contentMode = .scaleAspectFit
//                                imageView.translatesAutoresizingMaskIntoConstraints = false
//                imageView.contentMode = .scaleAspectFill
//                imageView.clipsToBounds = true
//                view.backgroundColor = .gray
//                                view.addSubview(imageView)
//                let titleLabel = UILabel()
//                titleLabel.text = notificationTitle
//                titleLabel.textColor = UIColor(hex: titleColor!)
//                titleLabel.translatesAutoresizingMaskIntoConstraints = false
//                view.addSubview(titleLabel)
//                titleLabel.numberOfLines = 0
//                titleLabel.textAlignment = .center
//                titleLabel.font = UIFont.systemFont(ofSize: CGFloat(sizeForTitle!))
//
//
//                let descriptionTxt = UILabel()
//                descriptionTxt.text = description
//                descriptionTxt.translatesAutoresizingMaskIntoConstraints = false
//                view.addSubview(descriptionTxt)
//                descriptionTxt.numberOfLines = 0
//                descriptionTxt.textAlignment = .center
//                descriptionTxt.textColor = UIColor(hex: descriptionFontColor!)
//                descriptionTxt.font = UIFont.systemFont(ofSize: CGFloat(sizeForDescription!))
//
//                                // Load the image asynchronously
//                                if let imageURLString = imageURLs?.first, let imageURL = URL(string: imageURLString) {
//                                    let session = URLSession.shared.dataTask(with: imageURL) { data, response, error in
//                                        if let error = error {
//                                            print("Error loading image: \(error)")
//                                            return
//                                        }
//
//                                        if let data = data, let image = UIImage(data: data) {
//                                            // Update the UI on the main thread
//                                            DispatchQueue.main.async {
//                                                imageView.image = image
//                                            }
//                                        }
//                                    }
//                                    session.resume()
//                                }
//
//                                let buttonStackView = UIStackView()
//                buttonStackView.axis = payload.data?.notificationDetails?.buttonOrientation?.lowercased() == "horizontal".lowercased() ? .horizontal : .vertical
//                                buttonStackView.distribution = .fillEqually
//                                buttonStackView.spacing = 10
//                                buttonStackView.translatesAutoresizingMaskIntoConstraints = false
//                                view.addSubview(buttonStackView)
//
//                                // Add two buttons to the stack view
//
//                for (buttonIndex, buttonObj) in buttonArray.enumerated() {
//                    let button = UIButton(type: .system)
//                    button.setTitle(buttonObj.buttonName, for: .normal)
//                    button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
//                    button.translatesAutoresizingMaskIntoConstraints = false
//
//                    if buttonIndex == 0 {
//
//                        let size = extractFontSize(from: buttonObj.buttonFontSize!)
//                        button.titleLabel?.font = UIFont.systemFont(ofSize: size!)
//                        let fontColor = UIColor(hex: buttonObj.buttonFontColor!)
//                        button.setTitleColor(fontColor, for: .normal)
////
////                        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//                       // button.layer.frame.size = CGSize(width: 138, height: 30)
//                        button.layer.cornerRadius = 5
//                        button.backgroundColor = UIColor(hex: buttonObj.buttonColor!)
//
//                        button.layer.borderColor = UIColor.black.cgColor
//                        button.layer.borderWidth = 1.0
//                    } else {
//                        let fontColor = UIColor(hex: buttonObj.buttonFontColor!)
//                        button.setTitleColor(fontColor, for: .normal)
//                        let size = extractFontSize(from: buttonObj.buttonFontSize!)
//                        button.titleLabel?.font = UIFont.systemFont(ofSize: size!)
//                       // button.layer.frame.size = CGSize(width: 138, height: 30)
//                        button.layer.cornerRadius = 5
//                        button.backgroundColor = UIColor(hex: buttonObj.buttonColor!)
//                    }
//
//                    buttonStackView.addArrangedSubview(button)
//                }
//                let dismissButton = UIButton(type: .custom)
//                dismissButton.translatesAutoresizingMaskIntoConstraints = false
//
//                // Set the custom image as the button's background image
//                var dismissImage = UIImage()
//                if #available(iOS 13.0, *) {
//                    dismissImage = UIImage(systemName: "xmark.circle.fill")!
//                } else {
//                    // Fallback on earlier versions
//                } // Use the name of your custom image asset
//                dismissButton.setImage(dismissImage, for: .normal)
//
//                // Customize the appearance of the button
//                dismissButton.tintColor = UIColor.white
//                dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
//                // Add the dismiss button to your view
//                view.addSubview(dismissButton)
//
//
//                                // Set up constraints
//                                NSLayoutConstraint.activate([
//                                    // Image view constraints
//                                    imageView.topAnchor.constraint(equalTo: view.topAnchor),
//                                    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                                    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                                    imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//
//                                    titleLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
//                                    titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
//                                    titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
//
//
//                                    descriptionTxt.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
//                                    descriptionTxt.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
//                                    descriptionTxt.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -30),
//
//                                    // Button stack view constraints
//                                    buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
//                                    buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
//                                    buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
//
//                                    // Dismiss button constraints
//                                    dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
//                                    dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
//                                    dismissButton.heightAnchor.constraint(equalToConstant: 40),
//                                    dismissButton.widthAnchor.constraint(equalToConstant: 40),
//                                ])
//
//                            }
//
//            else{
//
//            }
//        }
//    }
//    @objc func buttonTapped(sender: UIButton) {
//        let buttonArray = payload?.data?.button ?? []
//        // Ensure the tapped index is within the bounds of the buttonArray
//        guard sender.tag < buttonArray.count else {
//            return
//        }
//
//        let buttonObj = buttonArray[sender.tag]
//
//        // Open the URL associated with the tapped button
//        if let buttonURLString = buttonObj.buttonUrl, let buttonURL = URL(string: buttonURLString) {
//            UIApplication.shared.open(buttonURL, options: [:], completionHandler: nil)
//        }
//    }
//
//    @objc func dismissButtonTapped() {
//        // Implement the action to dismiss the view here
//        self.view.removeFromSuperview()
//
//    }
//}
//extension UIColor {
//    convenience init?(hex: String) {
//        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
//        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
//
//        var rgb: UInt64 = 0
//
//        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else {
//            return nil
//        }
//
//        self.init(
//            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
//            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
//            blue: CGFloat(rgb & 0x0000FF) / 255.0,
//            alpha: 1.0
//        )
//    }
//}
//
//
//
//
//


import UIKit

//class Util {
//    static func convertHexColortoUI(color name: String) -> UIColor? {
//        guard !name.isEmpty else { return nil }
//        return UIColor.red // Replace with your actual implementation
//    }
    class WigzoUtil {
        static func convertHexColorToUI(color name: String) -> UIColor? {
            guard !name.isEmpty else { return nil }
            return UIColor(hex: name)
        }
        static func extractFontSize(from input: String) -> Int? {
                let numericString = input.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                return Int(numericString)
            }

}


public class InAppNotificationViewController: UIViewController {
     var payload: NotificationDataModel?
     var sizeForTitle: Int?
     var sizeForDescription: Int?
     var titleColor: String?
     var descriptionFontColor: String?
    
     

    // MARK: - Initialization

    init() {
        super.init(nibName: nil, bundle: nil)
        // Perform any custom initialization here
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        applyPayload()
    }

    // MARK: - Layout

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        calculatePreferredSize()
    }
    
    func calculatePreferredSize() {
        let targetSize = CGSize(width: view.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        preferredContentSize = view.systemLayoutSizeFitting(targetSize)
    }

    // MARK: - Payload Handling
 func applyPayload() {
                guard let payload = payload else { return }

                let notificationTitle = payload.notification?.title
                let buttonArray = payload.data?.button ?? []
                let imageURLs = payload.data?.imageUrl
                let templateOrientation = payload.data?.notificationDetails?.templateOrientation
                let description = payload.data?.description
                let templateBackground = payload.data?.notificationDetails?.templateBackground
                let templateColor = WigzoUtil.convertHexColorToUI(color: templateBackground ?? "#fff")
                titleColor = payload.data?.notificationDetails?.titleColor
                descriptionFontColor = payload.data?.notificationDetails?.descriptionFontColor
                let titleFontSizeString = payload.data?.notificationDetails?.titleFontSize
                sizeForTitle = WigzoUtil.extractFontSize(from: titleFontSizeString ?? "14")
                let descriptionFontSizeString = payload.data?.notificationDetails?.descriptionFontSize
                sizeForDescription = WigzoUtil.extractFontSize(from: descriptionFontSizeString ?? "12")
                if let templateBackground = payload.data?.notificationDetails?.templateBackground,
                    let templateColor = UIColor(hex: templateBackground) {
                     view.backgroundColor = templateColor
                 }

                // Rest of your code...
            
        

        // Apply common payload data to UI elements
      //  view.backgroundColor = templateColor

        // Apply template orientation specific payload data to UI elements
        setupTemplate(templateOrientation: templateOrientation, title: notificationTitle, description: description, titleColor: titleColor, descriptionFontColor: descriptionFontColor, sizeForTitle: sizeForTitle, sizeForDescription: sizeForDescription, imageURLs: imageURLs, buttonArray: buttonArray)
    }

    // MARK: - UI Setup

    func setupViews() {
        // Setup common UI elements
        // ...
    }

    func setupTemplate(templateOrientation: String?, title: String?, description: String?, titleColor: String?, descriptionFontColor: String?, sizeForTitle: Int?, sizeForDescription: Int?, imageURLs: [String]?, buttonArray: [ButtonClass] ) {
        guard let templateOrientation = templateOrientation else { return }

        switch templateOrientation {
        case "top":
            setupTopTemplate(title: title, description: description, titleColor: titleColor, descriptionFontColor: descriptionFontColor, sizeForTitle: sizeForTitle, sizeForDescription: sizeForDescription, imageURLs: imageURLs, buttonArray: buttonArray)

        case "middle":
            setupMiddleTemplate(title: title, description: description, titleColor: titleColor, descriptionFontColor: descriptionFontColor, sizeForTitle: sizeForTitle, sizeForDescription: sizeForDescription, imageURLs: imageURLs, buttonArray: buttonArray)
            
        case "footer":
            setupMiddleTemplate(title: title, description: description, titleColor: titleColor, descriptionFontColor: descriptionFontColor, sizeForTitle: sizeForTitle, sizeForDescription: sizeForDescription, imageURLs: imageURLs, buttonArray: buttonArray)

        default:
            break
        }
    }

    func setupTopTemplate(title: String?, description: String?, titleColor: String?, descriptionFontColor: String?, sizeForTitle: Int?, sizeForDescription: Int?, imageURLs: [String]?, buttonArray: [ButtonClass]) {
        let mainStackView = setupMainStackView(templateOrientation: "top")
        let buttonStackView = setupButtonStackView(buttonArray: buttonArray)
        let imageView = setupImageView(templateOrientation: "top", imageURLs: imageURLs)
        let dismissButton = setupDismissButton()
        let labelStackView = setupLabelStackView()
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        labelStackView.addArrangedSubview(createTitle(title: title ?? "Hello Dude"))
        labelStackView.addArrangedSubview(createDescription(description: description ?? "What are you doing!"))
        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(labelStackView)
        
        view.addSubview(buttonStackView)
        view.addSubview(dismissButton)
        
        
        // Add constraints for 'top' orientation
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
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(greaterThanOrEqualTo: labelStackView.bottomAnchor, constant: 10)
        ])
        let subview2Width = imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        NSLayoutConstraint.activate([subview2Width])
    }

    func setupMiddleTemplate(title: String?, description: String?, titleColor: String?, descriptionFontColor: String?, sizeForTitle: Int?, sizeForDescription: Int?, imageURLs: [String]?, buttonArray: [ButtonClass]) {
        // Setup UI elements for "middle" template orientation
        let mainStackView = setupMainStackView(templateOrientation: "middle")
        let buttonStackView = setupButtonStackView(buttonArray: buttonArray)
        let dismissButton = setupDismissButton()
        let imageView = setupImageView(templateOrientation: "middle", imageURLs: imageURLs)
        let labelStackView = setupLabelStackView()
        
        let labelView = UIView()
        labelView.translatesAutoresizingMaskIntoConstraints = false
        labelView.addSubview(labelStackView)
        mainStackView.addArrangedSubview(labelView)
        
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        labelStackView.addArrangedSubview(createTitle(title: title ?? "Hello Dude"))
        labelStackView.addArrangedSubview(createDescription(description: description ?? "What are you doing!"))

        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(labelView)
        
        view.addSubview(buttonStackView)
        view.addSubview(dismissButton)


        // Add constraints for 'middle' orientation
        NSLayoutConstraint.activate([
            // Main stack view constraints
                                labelStackView.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 20),
                                labelStackView.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 10),
                                labelStackView.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -10),
                                labelStackView.bottomAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 20),
            
                                mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                                mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                                mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
                                buttonStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 40), // Align buttonStackView below labelStackView
                                buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                                buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
                                buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20), // Align buttonStackView at the bottom of the view
                                dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                                dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
                                imageView.heightAnchor.constraint(equalToConstant: 232),
                                imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
                                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
                                view.bottomAnchor.constraint(greaterThanOrEqualTo: buttonStackView.bottomAnchor, constant: 20)
                            ])
                            
    }
    func setupFooterTemplate(title: String?, description: String?, titleColor: String?, descriptionFontColor: String?, sizeForTitle: Int?, sizeForDescription: Int?, imageURLs: [String]?, buttonArray: [ButtonClass]) {
        let mainStackView = setupMainStackView(templateOrientation: "top")
        let buttonStackView = setupButtonStackView(buttonArray: buttonArray)
        let imageView = setupImageView(templateOrientation: "top", imageURLs: imageURLs)
        let dismissButton = setupDismissButton()
        let labelStackView = setupLabelStackView()
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        labelStackView.addArrangedSubview(createTitle(title: title ?? "Hello Dude"))
        labelStackView.addArrangedSubview(createDescription(description: description ?? "What are you doing!"))
        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(labelStackView)
        
        view.addSubview(buttonStackView)
        view.addSubview(dismissButton)
        
        
        // Add constraints for 'top' orientation
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
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(greaterThanOrEqualTo: labelStackView.bottomAnchor, constant: 10)
        ])
        let subview2Width = imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        NSLayoutConstraint.activate([subview2Width])
    }


    func setupMainStackView(templateOrientation: String) -> UIStackView {
        // Setup main stack view
        let mainStackView = UIStackView()
        switch templateOrientation {
            case "top":
                mainStackView.axis = .horizontal
                mainStackView.distribution = .fillProportionally
            case "middle":
                mainStackView.axis = .vertical
                mainStackView.distribution = .fill
            case "footer":
                mainStackView.axis = .horizontal
                mainStackView.distribution = .fillProportionally  // You can adjust this distribution as needed
            default:
                break
            }
        mainStackView.spacing = 10
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        return mainStackView
    }

    func setupButtonStackView(buttonArray: [ButtonClass]) -> UIStackView {
        // Setup button stack view
        let buttonStackView = UIStackView()
        buttonStackView.axis = payload?.data?.notificationDetails?.buttonOrientation?.lowercased() == "horizontal".lowercased() ? .horizontal : .vertical
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 10
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStackView)

        // Add multiple buttons to the stack view
        for (buttonIndex, buttonObj) in buttonArray.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(buttonObj.buttonName, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false

            if buttonIndex == 0 {
                let size = WigzoUtil.extractFontSize(from: buttonObj.buttonFontSize!)
                button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(size ?? 14))
                let fontColor = UIColor(hex: buttonObj.buttonFontColor ?? "#fff")
                button.setTitleColor(fontColor, for: .normal)
                button.layer.cornerRadius = 5
                button.backgroundColor = UIColor(hex: buttonObj.buttonColor ?? "#fff")
                button.layer.borderColor = UIColor.black.cgColor
                button.layer.borderWidth = 1.0
            } else {
                let fontColor = UIColor(hex: buttonObj.buttonFontColor!)
                button.setTitleColor(fontColor, for: .normal)
                let size = WigzoUtil.extractFontSize(from: buttonObj.buttonFontSize ?? "14")
                button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(size ?? 14))
                button.layer.cornerRadius = 5
                button.backgroundColor = UIColor(hex: buttonObj.buttonColor ?? "#fff")
            }

            buttonStackView.addArrangedSubview(button)
        }

        return buttonStackView
    }
    func createTitle(title: String) -> UILabel {
        // Title label
      
        let titleLabel = UILabel()
        titleLabel.text = payload?.data?.title
        titleLabel.textColor = UIColor(hex: titleColor ?? "#fff")
        titleLabel.numberOfLines = 0
        if let textAlignmentString = payload?.data?.notificationDetails?.textAllignment {
                // Convert the string value to NSTextAlignment
                if let textAlignment = textAlignmentFromString(textAlignmentString) {
                    titleLabel.textAlignment = textAlignment
                } else {
                    // Default to left alignment if the conversion fails
                    titleLabel.textAlignment = .left
                }
            } else {
                // Default to left alignment if the value is nil
                titleLabel.textAlignment = .left
            }
        titleLabel.font = UIFont.systemFont(ofSize: CGFloat(sizeForTitle ?? 14))

        // Description label
        

        return titleLabel
    }
    func textAlignmentFromString(_ alignmentString: String) -> NSTextAlignment? {
        switch alignmentString.lowercased() {
        case "left":
            return .left
        case "center":
            return .center
        case "right":
            return .right
        default:
            return nil
        }
    }
    func createDescription(description: String) -> UILabel {
        // Title label
    
        // Description label
        let descriptionLabel = UILabel()
        descriptionLabel.text = payload?.data?.description
        descriptionLabel.numberOfLines = 0
        if let textAlignmentString = payload?.data?.notificationDetails?.textAllignment {
                // Convert the string value to NSTextAlignment
                if let textAlignment = textAlignmentFromString(textAlignmentString) {
                    descriptionLabel.textAlignment = textAlignment
                } else {
                    // Default to left alignment if the conversion fails
                    descriptionLabel.textAlignment = .left
                }
            } else {
                // Default to left alignment if the value is nil
                descriptionLabel.textAlignment = .left
            }
        descriptionLabel.textColor = UIColor(hex: descriptionFontColor ?? "#fff")
        descriptionLabel.font = UIFont.systemFont(ofSize: CGFloat(sizeForDescription ?? 14))

        return descriptionLabel
    }
    
    func setupLabelStackView() -> UIStackView {
        // Setup label stack view
        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
//        labelStackView.alignment = .top
        labelStackView.distribution = .fillProportionally
        labelStackView.spacing = 10
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        // Add any additional setup for label stack view as needed
        return labelStackView
    }
    func setupDismissButton() -> UIButton {
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

        // Add additional setup for the dismiss button as needed
        // ...

        return dismissButton
    }

    func setupImageView(templateOrientation: String, imageURLs: [String]?) -> UIImageView {
        let imageView = UIImageView()

        // Check if imageURLs is not empty and the first URL is valid
        if let imageURLString = imageURLs?.first, !imageURLString.isEmpty, let imageURL = URL(string: imageURLString) {
            switch templateOrientation {
                    case "top":
                        imageView.contentMode = .scaleAspectFit
                    case "middle":
                        imageView.contentMode = .scaleAspectFill
                    case "footer":
                        imageView.contentMode = .scaleAspectFit  // You can adjust this mode as needed
                    default:
                        break
                    }
            imageView.translatesAutoresizingMaskIntoConstraints = false

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

        return imageView
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

    // MARK: - Actions

    
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

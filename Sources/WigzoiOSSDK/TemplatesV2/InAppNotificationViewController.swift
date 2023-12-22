//
//  File.swift
//
//
//  Created by Shivam Ratnam on 30/10/23.
//

import UIKit

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
    
    public var payload: WigzoNotification1?
    
    
    // var payload: NotificationDataModel?
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
       
        applyPayload()
        let notificationTitle = payload?.title
             
        let buttonArray = payload?.button
             
             
        let imageURLs = payload?.imageURL
            
        let templateOrientation = payload?.notificationDetails?.templateOrientation
             
        let description = payload?.description
        let templateBackground = payload?.notificationDetails?.templateBackground ?? ""
            
        let titleColorString = payload?.notificationDetails?.titleColor ?? ""
             
        let descriptionFontColorString = payload?.notificationDetails?.descriptionFontColor ?? ""
             
        let titleFontSizeString = payload?.notificationDetails?.titleFontSize ?? ""
             
        let descriptionFontSizeString = payload?.notificationDetails?.descriptionFontSize ?? ""
//        else {
//                  // Handle the case when payload or its properties are nil
//                  return
//              }

        // Convert hex colors to UIColor
        let templateColor = WigzoUtil.convertHexColorToUI(color: templateBackground)
        let titleColor = UIColor(hex: titleColorString)
        let descriptionFontColor = UIColor(hex: descriptionFontColorString)

        // Extract font sizes
        let sizeForTitle = WigzoUtil.extractFontSize(from: titleFontSizeString) ?? 14
        let sizeForDescription = WigzoUtil.extractFontSize(from: descriptionFontSizeString) ?? 12

        // Set view background color
        view.backgroundColor = templateColor

        setupTemplate(templateOrientation: templateOrientation, title: notificationTitle, description: description, titleColor: titleColorString, descriptionFontColor: descriptionFontColorString, sizeForTitle: sizeForTitle, sizeForDescription: sizeForDescription, imageURLs: imageURLs, buttonArray: buttonArray)
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
    func applyPayload() {
        // Unwrap optional properties from payload
        guard let payload = payload else { return }
             
            let notificationTitle = payload.title
            let description = payload.description
            let buttonArray = payload.button
            let imageURLs = payload.imageURL
            
            let templateOrientation = payload.notificationDetails?.templateOrientation
            let templateBackground = payload.notificationDetails?.templateBackground ?? ""
            let titleColorString = payload.notificationDetails?.titleColor ?? ""
             
            let descriptionFontColorString = payload.notificationDetails?.descriptionFontColor ?? ""
            let titleFontSizeString = payload.notificationDetails?.titleFontSize ?? ""
             
             let descriptionFontSizeString = payload.notificationDetails?.descriptionFontSize ?? ""
//        else {
//                  // Handle the case when payload or its properties are nil
//                  return
//              }

        // Convert hex colors to UIColor
        let templateColor = WigzoUtil.convertHexColorToUI(color: templateBackground)
        let titleColor = UIColor(hex: titleColorString)
        let descriptionFontColor = UIColor(hex: descriptionFontColorString)

        // Extract font sizes
        let sizeForTitle = WigzoUtil.extractFontSize(from: titleFontSizeString) ?? 14
        let sizeForDescription = WigzoUtil.extractFontSize(from: descriptionFontSizeString) ?? 12

        // Set view background color
        view.backgroundColor = templateColor

        
    }

    func setupTemplate(templateOrientation: String?, title: String?, description: String?, titleColor: String?, descriptionFontColor: String?, sizeForTitle: Int?, sizeForDescription: Int?, imageURLs: [String]?, buttonArray: [WigzoButton]?) {
        guard let templateOrientation = templateOrientation else { return }

        switch templateOrientation {
        case "top":
            setupTopTemplate(title: title, description: description, titleColor: titleColor, descriptionFontColor: descriptionFontColor, sizeForTitle: sizeForTitle, sizeForDescription: sizeForDescription, imageURLs: imageURLs, buttonArray: buttonArray)

        case "middle":
            setupMiddleTemplate(title: title, description: description, titleColor: titleColor, descriptionFontColor: descriptionFontColor, sizeForTitle: sizeForTitle, sizeForDescription: sizeForDescription, imageURLs: imageURLs, buttonArray: buttonArray)
            
        case "footer":
            setupFooterTemplate(title: title, description: description, titleColor: titleColor, descriptionFontColor: descriptionFontColor, sizeForTitle: sizeForTitle, sizeForDescription: sizeForDescription, imageURLs: imageURLs, buttonArray: buttonArray)
            
        case "fullScreen":
            setupFullScreen(title: title, description: description, titleColor: titleColor, descriptionFontColor: descriptionFontColor, sizeForTitle: sizeForTitle, sizeForDescription: sizeForDescription, imageURLs: imageURLs, buttonArray: buttonArray)


        default:
            break
        }
    }

    func setupTopTemplate(title: String?, description: String?, titleColor: String?, descriptionFontColor: String?, sizeForTitle: Int?, sizeForDescription: Int?, imageURLs: [String]?, buttonArray: [WigzoButton]?) {
        let mainStackView = setupMainStackView(templateOrientation: "top")
        let buttonStackView = setupButtonStackView(buttonArray: buttonArray )
        let imageView = setupImageView(templateOrientation: "top", imageURLs: imageURLs)
        let dismissButton = setupDismissButton()
        let labelStackView = setupLabelStackView()
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        labelStackView.addArrangedSubview(createTitle(title: title ?? ""))
        labelStackView.addArrangedSubview(createDescription(description: description ?? ""))
        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(labelStackView)
        
        view.addSubview(buttonStackView)
        view.addSubview(dismissButton)
        let mainStackViewTopConstraint = mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10)
        let labelStackViewLeadingConstraint = labelStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        labelStackViewLeadingConstraint.priority = .defaultHigh //
        
        
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
            
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),

            
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(greaterThanOrEqualTo: labelStackView.bottomAnchor, constant: 10),
            labelStackView.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            labelStackViewLeadingConstraint
        ])
        
        let subview2Width = imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3)
        NSLayoutConstraint.activate([subview2Width])
        if let imageURLs = imageURLs, !imageURLs.isEmpty {
                // If imageURLs is available, set the top constraint to 10
                mainStackViewTopConstraint.constant = 0
                labelStackViewLeadingConstraint.constant = 10
                labelStackViewLeadingConstraint.priority = .defaultLow
            } else {
                // If imageURLs is not available, set the top constraint to 0
                mainStackViewTopConstraint.constant = 0
                labelStackViewLeadingConstraint.constant = 25
                labelStackViewLeadingConstraint.priority = .required
            }
        
    }

    func setupMiddleTemplate(title: String?, description: String?, titleColor: String?, descriptionFontColor: String?, sizeForTitle: Int?, sizeForDescription: Int?, imageURLs: [String]?, buttonArray: [WigzoButton]?) {
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
        labelStackView.addArrangedSubview(createDescription(description: description ?? ""))

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
            
                               /* buttonStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 40),*/ // Align buttonStackView below labelStackView
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
    func setupFooterTemplate(title: String?, description: String?, titleColor: String?, descriptionFontColor: String?, sizeForTitle: Int?, sizeForDescription: Int?, imageURLs: [String]?, buttonArray: [WigzoButton]?) {
        let mainStackView = setupMainStackView(templateOrientation: "footer")
        let buttonStackView = setupButtonStackView(buttonArray: buttonArray)
        let imageView = setupImageView(templateOrientation: "footer", imageURLs: imageURLs)
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
    func setupFullScreen(title: String?, description: String?, titleColor: String?, descriptionFontColor: String?, sizeForTitle: Int?, sizeForDescription: Int?, imageURLs: [String]?, buttonArray: [WigzoButton]?){
        let mainStackView = setupMainStackView(templateOrientation: "fullScreen")
        let buttonStackView = setupButtonStackView(buttonArray: buttonArray)
        let imageView = setupImageView(templateOrientation: "fullScreen", imageURLs: imageURLs)
        let dismissButton = setupDismissButton()
        let labelStackView = setupLabelStackView()
        labelStackView.spacing = 10
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        labelStackView.addArrangedSubview(createTitle(title: title ?? "Hello Dude"))
        labelStackView.addArrangedSubview(createDescription(description: description ?? "What are you doing!"))
//        mainStackView.addArrangedSubview(imageView)
//        mainStackView.addArrangedSubview(labelStackView)
        
        view.addSubview(imageView)
        view.addSubview(labelStackView)
        view.addSubview(buttonStackView)
        view.addSubview(dismissButton)
        NSLayoutConstraint.activate([
        imageView.topAnchor.constraint(equalTo: view.topAnchor),
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        labelStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),  // Adjust the constant value
        labelStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
        labelStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
        
        // Button stack view constraints
        buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
        buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
        buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22),
        
        // Dismiss button constraints
        dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
        dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        dismissButton.heightAnchor.constraint(equalToConstant: 30),
        dismissButton.widthAnchor.constraint(equalToConstant: 30),
                                           ])
        
        
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
            case "fullScreen":
            mainStackView.axis = .horizontal
            mainStackView.distribution = .fillProportionally
            default:
                break
            }
        mainStackView.spacing = 10
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
        return mainStackView
    }

    func setupButtonStackView(buttonArray:[WigzoButton]?) -> UIStackView {
        // Setup button stack view
        let buttonStackView = UIStackView()
        buttonStackView.axis = payload?.notificationDetails?.buttonOrientation?.lowercased() == "horizontal".lowercased() ? .horizontal : .vertical
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 10
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStackView)

        guard let buttonArray = buttonArray else { return buttonStackView }
        // Add multiple buttons to the stack view
        for (buttonIndex, buttonObj) in buttonArray.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(buttonObj.buttonName, for: .normal)
           // button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

            button.translatesAutoresizingMaskIntoConstraints = false

            if buttonIndex == 0 {
                //let size = WigzoUtil.extractFontSize(from: buttonObj.buttonFontSize!)
                let size = WigzoUtil.extractFontSize(from: buttonObj.buttonFontSize ?? "14")
                button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)


                button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(size ?? 14))
                let fontColor = UIColor(hex: buttonObj.buttonFontColor ?? "#fff")
                button.setTitleColor(fontColor, for: .normal)
                button.layer.cornerRadius = 5
                button.backgroundColor = UIColor(hex: buttonObj.buttonColor ?? "#fff")
                button.layer.borderColor = UIColor.black.cgColor
                button.layer.borderWidth = 1.0
            } else {
                let fontColor = UIColor(hex: buttonObj.buttonFontColor ?? "fff")
                button.setTitleColor(fontColor, for: .normal)
                let size = WigzoUtil.extractFontSize(from: buttonObj.buttonFontSize ?? "14")
                button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(size ?? 14))
                button.layer.cornerRadius = 5
                button.backgroundColor = UIColor(hex: buttonObj.buttonColor ?? "#fff")
                button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

            }
            button.setContentCompressionResistancePriority(.required, for: .vertical)

            buttonStackView.addArrangedSubview(button)
        }

        return buttonStackView
    }
    func createTitle(title: String) -> UILabel {
        // Title label
      
        let titleLabel = UILabel()
        titleLabel.text = title
        //titleLabel.textColor = UIColor(hex: titleColor ?? "#fff")
        let titleColorString = payload?.notificationDetails?.titleColor ?? "#fff"
        titleLabel.textColor = UIColor(hex: titleColorString)

        titleLabel.numberOfLines = 0
        if let textAlignmentString = payload?.notificationDetails?.textAllignment {
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
      //  titleLabel.font = UIFont.systemFont(ofSize: CGFloat(sizeForTitle ?? 14))
           let sizeForTitle = WigzoUtil.extractFontSize(from: payload?.notificationDetails?.titleFontSize ?? "") ?? 14
           titleLabel.font = UIFont.systemFont(ofSize: CGFloat(sizeForTitle))
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
        descriptionLabel.text = description
        descriptionLabel.numberOfLines = 0
        if let textAlignmentString = payload?.notificationDetails?.textAllignment {
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
        //descriptionLabel.textColor = UIColor(hex: descriptionFontColor ?? "#fff")
        //descriptionLabel.font = UIFont.systemFont(ofSize: CGFloat(sizeForDescription ?? 14))
        let descriptionFontColorString = payload?.notificationDetails?.descriptionFontColor ?? "#fff"
            descriptionLabel.textColor = UIColor(hex: descriptionFontColorString)
        let sizeForDescription = WigzoUtil.extractFontSize(from: payload?.notificationDetails?.descriptionFontSize ?? "") ?? 14
           descriptionLabel.font = UIFont.systemFont(ofSize: CGFloat(sizeForDescription))

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
        guard let imageArray = imageURLs, imageArray.count > 0 else {
            return imageView
        }
        
        if let imageURLString = imageArray.first, !imageURLString.isEmpty {
            switch templateOrientation {
            case "top":
                imageView.contentMode = .scaleAspectFit
            case "middle":
                imageView.contentMode = .scaleAspectFill
            case "footer":
                imageView.contentMode = .scaleAspectFit 
            case "fullScreen":
                imageView.contentMode = .scaleAspectFill // You can adjust this mode as needed
            default:
                break
            }
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            if let imageURL = URL(string: imageURLString) {
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
        }
        return imageView
    }
    func dismissView() {
        // Implement the action to dismiss the view here
        self.view.removeFromSuperview()
    }

  
    @objc func buttonTapped(sender: UIButton) {
        guard let buttonArray = payload?.button, sender.tag < buttonArray.count else {
            return
        }

        let buttonObj = buttonArray[sender.tag]

        // Open the URL associated with the tapped button
        if let buttonURLString = buttonObj.buttonURL, let buttonURL = URL(string: buttonURLString) {
            if UIApplication.shared.canOpenURL(buttonURL) {
                UIApplication.shared.open(buttonURL, options: [:], completionHandler: nil)
            } else {
                // Handle the case where the URL cannot be opened
                print("Unable to open URL: \(buttonURLString)")
            }
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

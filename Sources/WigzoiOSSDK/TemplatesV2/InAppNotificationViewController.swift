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
        let Notificationtype = payload?.type
        
        let imageURLs = payload?.imageURL
        
        let templateOrientation = payload?.notificationDetails?.templateOrientation
        
        let description = payload?.description
        let templateBackground = payload?.notificationDetails?.templateBackground ?? ""
        
        let titleColorString = payload?.notificationDetails?.titleColor ?? ""
        
        let descriptionFontColorString = payload?.notificationDetails?.descriptionFontColor ?? ""
        
        let titleFontSizeString = payload?.notificationDetails?.titleFontSize ?? ""
        
        let descriptionFontSizeString = payload?.notificationDetails?.descriptionFontSize ?? ""
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
        let notificationType = payload.type
        let description = payload.description
        let buttonArray = payload.button
        let imageURLs = payload.imageURL
        
        let templateOrientation = payload.notificationDetails?.templateOrientation
        let templateBackground = payload.notificationDetails?.templateBackground ?? ""
        let titleColorString = payload.notificationDetails?.titleColor ?? ""
        
        let descriptionFontColorString = payload.notificationDetails?.descriptionFontColor ?? ""
        let titleFontSizeString = payload.notificationDetails?.titleFontSize ?? ""
        
        let descriptionFontSizeString = payload.notificationDetails?.descriptionFontSize ?? ""
        
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
            
        case "center":
            setupMiddleTemplate(title: title, description: description, titleColor: titleColor, descriptionFontColor: descriptionFontColor, sizeForTitle: sizeForTitle, sizeForDescription: sizeForDescription, imageURLs: imageURLs, buttonArray: buttonArray)
            
        case "bottom":
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
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -10),
            
            // Button stack view constraints
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(greaterThanOrEqualTo: labelStackView.bottomAnchor, constant: 10),
            labelStackView.topAnchor.constraint(equalTo: mainStackView.topAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            labelStackView.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
            labelStackViewLeadingConstraint
        ])
        
        let subview2Width = imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2)
        NSLayoutConstraint.activate([subview2Width])
        if let imageURLs = imageURLs, !imageURLs.isEmpty {
            // If imageURLs is available, set the top constraint to 10
            mainStackViewTopConstraint.constant = 0
            labelStackViewLeadingConstraint.constant = 10
            labelStackViewLeadingConstraint.priority = .defaultLow
        } else {
            // If imageURLs is not available, set the top constraint to 0
            mainStackViewTopConstraint.constant = 0
            labelStackViewLeadingConstraint.constant = 0
            labelStackViewLeadingConstraint.priority = .required
        }
        
    }
    
    func setupMiddleTemplate(title: String?, description: String?, titleColor: String?, descriptionFontColor: String?, sizeForTitle: Int?, sizeForDescription: Int?, imageURLs: [String]?, buttonArray: [WigzoButton]?) {
        // Setup UI elements for "middle" template orientation
        let mainStackView = setupMainStackView(templateOrientation: "center")
        
        let buttonStackView = setupButtonStackView(buttonArray: buttonArray)
        let dismissButton = setupDismissButton()
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        
        let imageView = setupImageView(templateOrientation: "center", imageURLs: imageURLs)
        
        if payload?.type?.type?.lowercased() == "Image Only".lowercased(){
            dismissButton.tintColor = .darkGray
            imageView.contentMode = .scaleAspectFit
            view.addSubview(imageView)
            view.addSubview(dismissButton)
            view.addSubview(buttonStackView)
           
            NSLayoutConstraint.activate([
                // Main stack view constraints
                imageView.topAnchor.constraint(equalTo: view.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo:view.trailingAnchor ),
                imageView.bottomAnchor.constraint(equalTo:buttonStackView.bottomAnchor ),
                dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
                dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                dismissButton.widthAnchor.constraint(equalToConstant: 30),
                dismissButton.heightAnchor.constraint(equalToConstant: 30),
                buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
                buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
              
            ])
        }
       
        else {
            
            let labelStackView = setupLabelStackView()
            let labelView = UIView()
            labelView.translatesAutoresizingMaskIntoConstraints = false
            labelView.addSubview(labelStackView)
            
            labelStackView.addArrangedSubview(createTitle(title: title ?? ""))
            labelStackView.addArrangedSubview(createDescription(description: description ?? ""))
            
            
            
            if let imageURLs = imageURLs, !imageURLs.isEmpty {
                mainStackView.addArrangedSubview(imageView)
            }
            mainStackView.addArrangedSubview(labelView)
            
            view.addSubview(mainStackView)
            if let buttonArray = buttonArray, !buttonArray.isEmpty {
                view.addSubview(buttonStackView)
            }
            view.addSubview(dismissButton)
            
            NSLayoutConstraint.activate([
                // Main stack view constraints
                labelStackView.topAnchor.constraint(equalTo: labelView.topAnchor, constant: 20),
                labelStackView.leadingAnchor.constraint(equalTo: labelView.leadingAnchor, constant: 10),
                labelStackView.trailingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: -10),
                labelStackView.bottomAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 20),
                
                mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
                mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                
                
                
            ])
            
            if let buttonArray = buttonArray, !buttonArray.isEmpty {
                NSLayoutConstraint.activate([
                    buttonStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 40),
                    buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                    buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                    buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                ])
            } else {
                NSLayoutConstraint.activate([
                    mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
                ])
            }
        }
        
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            dismissButton.widthAnchor.constraint(equalToConstant: 30),
            dismissButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    func setupFooterTemplate(title: String?, description: String?, titleColor: String?, descriptionFontColor: String?, sizeForTitle: Int?, sizeForDescription: Int?, imageURLs: [String]?, buttonArray: [WigzoButton]?) {
        let mainStackView = setupMainStackView(templateOrientation: "bottom")
        let buttonStackView = setupButtonStackView(buttonArray: buttonArray)
        let imageView = setupImageView(templateOrientation: "bottom", imageURLs: imageURLs)
        let dismissButton = setupDismissButton()
        let labelStackView = setupLabelStackView()
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        labelStackView.addArrangedSubview(createTitle(title: title ?? ""))
        labelStackView.addArrangedSubview(createDescription(description: description ?? ""))
        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(labelStackView)
        
        view.addSubview(buttonStackView)
        view.addSubview(dismissButton)
        
        NSLayoutConstraint.activate([
            // Main stack view constraints
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            mainStackView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -10),
            
            // Button stack view constraints
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            // buttonStackView.heightAnchor.constraint(equalToConstant: 30),
            
            dismissButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainStackView.bottomAnchor.constraint(greaterThanOrEqualTo: labelStackView.bottomAnchor, constant: 10)
        ])
      
        let subview2Width = imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2)
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
        labelStackView.addArrangedSubview(createTitle(title: title ?? ""))
        labelStackView.addArrangedSubview(createDescription(description: description ?? ""))
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
        case "center":
            mainStackView.axis = .vertical
            mainStackView.distribution = .fill
        case "bottom":
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
        view.addSubview(buttonStackView)
        
        guard let buttonArray = buttonArray else { return buttonStackView }
        
        buttonStackView.axis = payload?.notificationDetails?.buttonOrientation?.lowercased() == "horizontal".lowercased() ? .horizontal : .vertical
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 10
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        // Add multiple buttons to the stack view
        
        for case let (buttonIndex, buttonObj) in buttonArray.enumerated() where !(buttonObj.buttonName?.isEmpty ?? false) {
            let button = UIButton(type: .system)
            button.setTitle(buttonObj.buttonName, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = buttonIndex
            
            if buttonIndex == 0 {
                //let size = WigzoUtil.extractFontSize(from: buttonObj.buttonFontSize!)
                let size = WigzoUtil.extractFontSize(from: buttonObj.buttonFontSize ?? "14")
                button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
               
                button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(size ?? 14))
                let fontColor = UIColor(hex: buttonObj.buttonFontColor ?? "")
                button.setTitleColor(fontColor, for: .normal)
                button.layer.cornerRadius = 5
                button.backgroundColor = UIColor(hex: buttonObj.buttonColor ?? "")
                button.layer.borderColor = UIColor.black.cgColor
                button.layer.borderWidth = 1.0
            } else {
                let fontColor = UIColor(hex: buttonObj.buttonFontColor ?? "")
                button.setTitleColor(fontColor, for: .normal)
                let size = WigzoUtil.extractFontSize(from: buttonObj.buttonFontSize ?? "14")
                button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(size ?? 14))
                button.layer.cornerRadius = 5
                button.backgroundColor = UIColor(hex: buttonObj.buttonColor ?? "")
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
        let titleColorString = payload?.notificationDetails?.titleColor ?? ""
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
            titleLabel.textAlignment = .left
        }
        let sizeForTitle = WigzoUtil.extractFontSize(from: payload?.notificationDetails?.titleFontSize ?? "") ?? 14
        titleLabel.font = UIFont.systemFont(ofSize: CGFloat(sizeForTitle))
        
        
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
        let descriptionFontColorString = payload?.notificationDetails?.descriptionFontColor ?? ""
        descriptionLabel.textColor = UIColor(hex: descriptionFontColorString)
        let sizeForDescription = WigzoUtil.extractFontSize(from: payload?.notificationDetails?.descriptionFontSize ?? "") ?? 14
        descriptionLabel.font = UIFont.systemFont(ofSize: CGFloat(sizeForDescription))
        return descriptionLabel
    }
    
    func setupLabelStackView() -> UIStackView {
        // Setup label stack view
        let labelStackView = UIStackView()
        labelStackView.axis = .vertical
        labelStackView.distribution = .fillProportionally
        labelStackView.spacing = 10
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        return labelStackView
    }
    func setupDismissButton() -> UIButton {
        let dismissButton = UIButton(type: .custom)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        
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
        return dismissButton
    }
    func setupImageView(templateOrientation: String, imageURLs: [String]?) -> UIImageView {
        let imageView = UIImageView()
        if let notificationType = payload?.type?.type, notificationType.lowercased() == "Text Only" {
            imageView.isHidden = true
            
        } else {
            imageView.isHidden = false
        }
        guard let imageArray = imageURLs, imageArray.count > 0 else {
            return imageView
        }
       
        if let imageURLString = imageArray.first, !imageURLString.isEmpty {
            switch templateOrientation {
            case "top":
                imageView.contentMode = .scaleAspectFit
            case "center":
                imageView.contentMode = .scaleAspectFit
            case "bottom":
                imageView.contentMode = .scaleAspectFit
            case "fullScreen":
                imageView.contentMode = .scaleAspectFit // You can adjust this mode as needed
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
        
        if sender.tag == 0{
            let buttonObj1 = buttonArray[sender.tag]
            // Open the URL associated with the tapped button
            if let buttonURLString = buttonObj1.buttonURL, let buttonURL = URL(string: buttonURLString) {
                if UIApplication.shared.canOpenURL(buttonURL) {
                    UIApplication.shared.open(buttonURL, options: [:], completionHandler: nil)
                } else {
                    // Handle the case where the URL cannot be opened
                    print("Unable to open URL: \(buttonURLString)")
                }
            }
        }
        if sender.tag == 1{
            let buttonObj2 = buttonArray[sender.tag]
            
            if let buttonURLString = buttonObj2.buttonURL, let buttonURL = URL(string: buttonURLString) {
                if UIApplication.shared.canOpenURL(buttonURL) {
                    UIApplication.shared.open(buttonURL, options: [:], completionHandler: nil)
                } else {
                    // Handle the case where the URL cannot be opened
                    print("Unable to open URL: \(buttonURLString)")
                }
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

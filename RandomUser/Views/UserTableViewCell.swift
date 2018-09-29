//
//  UserTableViewCell.swift
//  RandomUser
//
//  Created by Lluis Gomez Hernando on 28/09/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import UIKit
import SDWebImage

struct UserCellViewModel {
    let name: String
    let email: String
    let pictureURL: URL?
    let phone: String
    let route: Route
    let deleteAction: Action
    
    init(name: String, email: String, pictureURL: URL?, phone: String,
         route: Route, deleteAction: Action) {
        
        self.name = name
        self.email = email
        self.pictureURL = pictureURL
        self.phone = phone
        self.route = route
        self.deleteAction = deleteAction
    }
}

class UserTableViewCell: UITableViewCell {

    private let pictureImageView = UIImageView()
    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()
    private let emailLabel = UILabel()

    private struct Constants {
        static let titleFontSize: CGFloat = 20
        static let infoFontSize: CGFloat = 15
        static let pictureSide: CGFloat =  70
        static let padding: CGFloat =  15
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUpView()
        setUpConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        pictureImageView.contentMode = .scaleAspectFit
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        pictureImageView.layer.cornerRadius = Constants.pictureSide/2
        pictureImageView.clipsToBounds = true
        contentView.addSubview(pictureImageView)

        nameLabel.numberOfLines = 1
        nameLabel.font = UIFont.systemFont(ofSize: Constants.titleFontSize, weight: .semibold)
        nameLabel.textColor = UIColor.darkText
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)

        phoneLabel.numberOfLines = 1
        phoneLabel.font = UIFont.systemFont(ofSize: Constants.infoFontSize, weight: .regular)
        phoneLabel.textColor = UIColor.darkText
        phoneLabel.adjustsFontSizeToFitWidth = true
        phoneLabel.minimumScaleFactor = 0.5
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(phoneLabel)

        emailLabel.numberOfLines = 1
        emailLabel.font = UIFont.systemFont(ofSize: Constants.infoFontSize, weight: .regular)
        emailLabel.textColor = UIColor.darkText
        emailLabel.adjustsFontSizeToFitWidth = true
        emailLabel.minimumScaleFactor = 0.5
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emailLabel)
    }

    private func setUpConstraints() {
        pictureImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.padding).isActive = true
        pictureImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        pictureImageView.heightAnchor.constraint(equalToConstant: Constants.pictureSide).isActive = true
        pictureImageView.widthAnchor.constraint(equalToConstant: Constants.pictureSide).isActive = true
        pictureImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding).isActive = true

        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: pictureImageView.rightAnchor, constant: Constants.padding).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.padding).isActive = true

        phoneLabel.leftAnchor.constraint(equalTo: pictureImageView.rightAnchor, constant: Constants.padding).isActive = true
        phoneLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.padding).isActive = true
        phoneLabel.bottomAnchor.constraint(equalTo: emailLabel.topAnchor, constant: -3).isActive = true

        emailLabel.leftAnchor.constraint(equalTo: pictureImageView.rightAnchor, constant: Constants.padding).isActive = true
        emailLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.padding).isActive = true
        emailLabel.bottomAnchor.constraint(equalTo: pictureImageView.bottomAnchor).isActive = true
    }

    func configure(with viewModel: UserCellViewModel) {
        pictureImageView.sd_setImage(with: viewModel.pictureURL)
        nameLabel.text = viewModel.name.capitalized
        phoneLabel.text = viewModel.phone
        emailLabel.text = viewModel.email
    }
}

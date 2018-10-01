//
//  UserHeaderView.swift
//  RandomUser
//
//  Created by Lluis Gomez Hernando on 01/10/2018.
//  Copyright © 2018 RandomUser Inc. All rights reserved.
//

import UIKit
import SDWebImage

struct UserHeaderViewModel {
    let pictureURL: URL?
    let name: String
}

class UserHeaderView: UITableViewHeaderFooterView {

    private let pictureImageView = UIImageView()
    private let nameLabel = UILabel()

    private struct Constants {
        static let nameFontSize: CGFloat = 20
        static let pictureSide: CGFloat =  100
        static let padding: CGFloat =  15
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

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
        nameLabel.font = UIFont.systemFont(ofSize: Constants.nameFontSize, weight: .semibold)
        nameLabel.textColor = UIColor.darkText
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
    }

    private func setUpConstraints() {
        pictureImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.padding).isActive = true
        pictureImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        pictureImageView.heightAnchor.constraint(equalToConstant: Constants.pictureSide).isActive = true
        pictureImageView.widthAnchor.constraint(equalToConstant: Constants.pictureSide).isActive = true
        pictureImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.padding).isActive = true

        nameLabel.centerYAnchor.constraint(equalTo: pictureImageView.centerYAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: pictureImageView.rightAnchor, constant: Constants.padding).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.padding).isActive = true
    }

    func configure(with viewModel: UserHeaderViewModel) {
        pictureImageView.sd_setImage(with: viewModel.pictureURL)
        nameLabel.text = viewModel.name.capitalized
    }
}

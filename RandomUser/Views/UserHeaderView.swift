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

    init(pictureURL: URL?, name: String) {
        self.pictureURL = pictureURL
        self.name = name
    }
}

class UserHeaderView: UIView {

    private let pictureImageView = UIImageView()
    private let nameLabel = UILabel()

    private struct Constants {
        static let nameFontSize: CGFloat = 40
        static let pictureSide: CGFloat =  100
        static let padding: CGFloat =  15
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpView()
        setUpConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpView() {
        backgroundColor = UIColor.white
        
        pictureImageView.contentMode = .scaleAspectFit
        pictureImageView.layer.cornerRadius = Constants.pictureSide/2
        pictureImageView.clipsToBounds = true
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(pictureImageView)

        nameLabel.numberOfLines = 1
        nameLabel.font = UIFont.systemFont(ofSize: Constants.nameFontSize, weight: .semibold)
        nameLabel.textColor = UIColor.darkText
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.5
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameLabel)
    }

    private func setUpConstraints() {
        pictureImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.padding).isActive = true
        pictureImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding).isActive = true
        pictureImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.padding).isActive = true
        pictureImageView.heightAnchor.constraint(equalToConstant: Constants.pictureSide).isActive = true
        pictureImageView.widthAnchor.constraint(equalToConstant: Constants.pictureSide).isActive = true

        nameLabel.centerYAnchor.constraint(equalTo: pictureImageView.centerYAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: pictureImageView.rightAnchor, constant: Constants.padding).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.padding).isActive = true
    }

    func configure(with viewModel: UserHeaderViewModel) {
        pictureImageView.sd_setImage(with: viewModel.pictureURL)
        nameLabel.text = viewModel.name.capitalized
    }
}

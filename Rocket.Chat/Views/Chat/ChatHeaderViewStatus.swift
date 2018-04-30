//
//  ChatHeaderViewStatus.swift
//  Rocket.Chat
//
//  Created by Rafael Kellermann Streit on 05/12/16.
//  Copyright © 2016 Rocket.Chat. All rights reserved.
//

import UIKit

protocol ChatHeaderViewStatusDelegate: NSObjectProtocol {
    func viewStatusButtonRefreshDidPressed(_ view: ChatHeaderViewStatus)
}

final class ChatHeaderViewStatus: UIView {

    static let defaultHeight = CGFloat(44)

    weak var delegate: ChatHeaderViewStatusDelegate?

    @IBOutlet weak var labelTitle: UILabel! {
        didSet {
            labelTitle.lineBreakMode = .byTruncatingMiddle
        }
    }

    @IBOutlet weak var buttonRefresh: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    func setTextColor(_ color: UIColor) {
        labelTitle.textColor = color
        activityIndicator.color = color

        let refreshImage = buttonRefresh.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
        buttonRefresh.setImage(refreshImage, for: .normal)
        buttonRefresh.tintColor = color
    }

    // MARK: IBAction

    @IBAction func buttonRefreshDidPressed(_ sender: Any) {
        delegate?.viewStatusButtonRefreshDidPressed(self)
    }

}

extension ChatHeaderViewStatus {
    override func applyTheme() {
        super.applyTheme()
        guard let theme = theme else { return }
        if theme == .light {
            backgroundColor = .RCLightGray()
            setTextColor(.RCDarkBlue())
        } else {
            backgroundColor = UIColor.RCDarkGray()
            setTextColor(theme.bodyText)
        }
    }
}

//
//  MusicTableViewCell.swift
//  iOSRxDemo
//
//  Created by YukiOkudera on 2019/03/24.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import UIKit

final class MusicTableViewCell: UITableViewCell {
    
    typealias Element = Track
    
    // MARK: - Properties
    @IBOutlet private weak var thumbnailView: UIImageView!
    @IBOutlet private weak var trackNameLabel: UILabel!
    @IBOutlet private weak var artistNameLabel: UILabel!
    
    var element: Element? {
        didSet {
            setElement(element)
        }
    }
    
    private func setElement(_ element: Element?) {
        guard let element = self.element else {
            return
        }
        trackNameLabel.text = element.trackName
        artistNameLabel.text = element.artistName
        
        guard let imageUrl = URL(string: element.artworkUrl100) else {
            return
        }
        
        DispatchQueue.global(qos: .default).async {
            
            do {
                let data = try Data(contentsOf: imageUrl)
                let image = UIImage(data: data)
                DispatchQueue.main.async { [weak self] in
                    self?.thumbnailView.image = image
                }
            } catch {
                print("artwork fetch failure: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - override
extension MusicTableViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailView.image = nil
    }
}

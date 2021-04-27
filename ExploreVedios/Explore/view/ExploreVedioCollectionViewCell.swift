//
//  ExploreVedioCollectionViewCell.swift
//  ExploreVedios
//
//  Created by iOS Developer on 26/04/21.
//

import UIKit
import AVKit
import MaterialComponents.MaterialCards

class ExploreVedioCollectionViewCell: UICollectionViewCell {
    static var identifier : String = {
        String(describing: self)
    }()
    
     lazy var cellView : MDCCard = {
        let cellView = MDCCard(frame: .zero)
        cellView.backgroundColor = .white
        cellView.layer.cornerRadius = 10.0
        cellView.setBorderWidth(1, for: .normal)
        cellView.setBorderColor(.lightGray, for: .normal)
        return cellView
    }()
    
    
     lazy var backgroundImageView:UIImageView =  {
        let activityIV = UIImageView()
        activityIV.scalesLargeContentImage = true
        activityIV.contentMode = .scaleAspectFit
        activityIV.image = UIImage.init(named: "gallery")
        return activityIV
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(cellView)
        cellView.addSubview(backgroundImageView)
       
        
        collectionviewcellConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
        
    func collectionviewcellConstraints(){
        
        cellView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            cellView.heightAnchor.constraint(equalToConstant: 250),
            cellView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width/3) )
        ])
        
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.cornerRadius = 10
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: cellView.topAnchor,constant: 0),
            backgroundImageView.leadingAnchor.constraint(equalTo: cellView.leadingAnchor,constant: 0),
            backgroundImageView.trailingAnchor.constraint(equalTo: cellView.trailingAnchor,constant: 0),
            backgroundImageView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor,constant: 0)
        ])
        
                
    }

}

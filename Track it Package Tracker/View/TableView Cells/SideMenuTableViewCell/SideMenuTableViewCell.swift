//
//  SideMenuTableViewCell.swift
//  Track it Package Tracker
//
//  Created by Adebayo Sotannde on 8/9/22.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell
{
    
    static let classIdentifier = String(describing: SideMenuTableViewCell.self)
    static let cellIdentifier = String(describing: SideMenuTableViewCell.self)
    
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
}

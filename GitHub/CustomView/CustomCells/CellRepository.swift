//
//  CellRepository.swift
//  GitHub
//
//  Created by Alexei Karas on 24.06.2018.
//  Copyright © 2018 TestOrg. All rights reserved.
//

import UIKit

class CellRepository: UITableViewCell {

    @IBOutlet weak var labelCaption   : UILabel!
    @IBOutlet weak var labelDateRepos : UILabel!
    @IBOutlet weak var labelLanguage  : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

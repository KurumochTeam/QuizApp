//
//  StringExtension.swift
//  QuizApp
//
//  Created by Aleksandr on 14/10/2019.
//  Copyright © 2019 Kurumoch Team LLC. All rights reserved.
//

import Foundation

extension String {
    // TODO: Remove when R.swift is available
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}

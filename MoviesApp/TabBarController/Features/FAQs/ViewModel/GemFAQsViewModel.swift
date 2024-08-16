//
//  GemFAQsViewModel.swift
//  MoviesApp
//
//  Created by Asif Hussain on 16/08/2024.
//

import UIKit

class GemsFAQViewModel {
    
    private(set) var faqsContent: [GemFAQContent]
    
    init(faqsContent: [GemFAQContent] = MockData.defaultFAQContent()) {
        self.faqsContent = faqsContent
    }
    
    func getAttributedText() -> NSAttributedString {
        let attributedText = NSMutableAttributedString()
        
        for content in faqsContent {
            let title = AttributedStringHelper.attributedTitle(from: content.title)
            let description = AttributedStringHelper.attributedDescription(from: content.description)
            let details = AttributedStringHelper.attributedDetails(from: content.details, boldTextRange: content.boldTextRange)
            
            attributedText.append(title)
            attributedText.append(description)
            attributedText.append(details)
            
            if !content.subDetails.isEmpty {
                for subDetail in content.subDetails {
                    // Assuming each subDetail has its own boldTextRanges
                    let subDetailText = AttributedStringHelper.attributedSubDetail(from: subDetail.text, boldTextRanges: subDetail.boldTextRanges)
                    attributedText.append(subDetailText)
                }
            }
            
            attributedText.append(NSAttributedString(string: "\n"))
        }
        
        return attributedText
    }
}


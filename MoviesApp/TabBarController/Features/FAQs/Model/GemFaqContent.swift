//
//  GemFaqContent.swift
//  MoviesApp
//
//  Created by Asif Hussain on 17/08/2024.
//

import Foundation
import UIKit

struct GemFAQContent {
    let title: String
    let description: String
    let details: String
    let subDetails: [SubDetail]
    let boldTextRange: [NSRange]?
    
    func getAttributedTitle() -> NSAttributedString {
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold),
            .foregroundColor: UIColor.black,
        ]
        var finalAttributes = titleAttributes
        if !title.isEmpty {
            let paragraphStyle = paragraphStyleWithLineSpacing(5)
            finalAttributes[.paragraphStyle] = paragraphStyle
        }
        guard !title.isEmpty else { return NSAttributedString() }
        return NSAttributedString(string: title + "\n", attributes: finalAttributes)
    }
    
    func getAttributedDescription() -> NSAttributedString {
        let descriptionAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .regular),
            .foregroundColor: UIColor.black,
        ]
        
        var finalAttributes = descriptionAttributes
        if !description.isEmpty {
            finalAttributes[.paragraphStyle] = paragraphStyleWithLineSpacing(5)
        }
        
        guard !description.isEmpty else { return NSAttributedString() }
        
        let attributedText = NSMutableAttributedString(string: description + "\n", attributes: finalAttributes)
        
        // Define the range for "Confidant Club members"
        let tapableText = "Confidant Club members"
        if let range = description.range(of: tapableText) {
            let nsRange = NSRange(range, in: description)
            attributedText.addAttributes([
                .foregroundColor: UIColor.systemPink,
                .link: NSURL(string: "https://www.google.com/")!
            ], range: nsRange)
        }
        
        return attributedText
    }
    
    
    func getAttributedDetails() -> NSAttributedString {
        guard !details.isEmpty else { return NSAttributedString() }
        
        let bulletPrefix = "•  "
        let fullText = bulletPrefix + details + "\n"
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = (bulletPrefix as NSString).size(withAttributes: [.font: UIFont.systemFont(ofSize: 15)]).width
        
        let defaultAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .bold),
            .foregroundColor: UIColor.black,
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedText = NSMutableAttributedString(string: fullText, attributes: defaultAttributes)
        
        if let boldTextRanges = boldTextRange {
            let regularAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 15, weight: .regular)
            ]
            
            attributedText.addAttributes(regularAttributes, range: NSRange(location: bulletPrefix.count, length: fullText.count - bulletPrefix.count))
            
            let boldAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 15, weight: .bold)
            ]
            
            for range in boldTextRanges {
                let adjustedRange = NSRange(location: range.location + bulletPrefix.count, length: range.length)
                if adjustedRange.location + adjustedRange.length <= fullText.count {
                    attributedText.addAttributes(boldAttributes, range: adjustedRange)
                }
            }
        }
        
        return attributedText
    }
    
    
    
    func getAttributedSubDetail(subDetail: String, boldTextRanges: [NSRange]?) -> NSAttributedString {
        guard !subDetail.isEmpty else { return NSAttributedString() }
        
        let bulletPrefix = "•  "
        let fullText = bulletPrefix + subDetail + "\n"
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.headIndent = 32
        paragraphStyle.firstLineHeadIndent = 16
        paragraphStyle.lineSpacing = 5
        
        let defaultAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .regular),
            .foregroundColor: UIColor.black,
            .paragraphStyle: paragraphStyle
        ]
        
        let attributedText = NSMutableAttributedString(string: fullText, attributes: defaultAttributes)
        
        if let boldTextRanges = boldTextRanges {
            let boldAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 15, weight: .bold)
            ]
            
            for range in boldTextRanges {
                let adjustedRange = NSRange(location: range.location + bulletPrefix.count, length: range.length)
                if adjustedRange.location + adjustedRange.length <= fullText.count {
                    attributedText.addAttributes(boldAttributes, range: adjustedRange)
                }
            }
        } else {
            // If no ranges are specified, make the entire text bold
            attributedText.addAttributes([
                .font: UIFont.systemFont(ofSize: 15, weight: .regular)
            ], range: NSRange(location: 0, length: fullText.count))
        }
        
        return attributedText
    }
    
    private func paragraphStyleWithLineSpacing(_ lineSpacing: CGFloat) -> NSMutableParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        return paragraphStyle
    }
}



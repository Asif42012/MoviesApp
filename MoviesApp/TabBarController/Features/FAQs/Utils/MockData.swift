//
//  MockData.swift
//  MoviesApp
//
//  Created by Asif Hussain on 17/08/2024.
//

import Foundation

struct MockData {
    
    static func defaultFAQContent() -> [GemFAQContent] {
        return [
            GemFAQContent(
                title: "What are Gems",
                description: "Gems are Iris points which you can collect by engaging in the community.",
                details: "",
                subDetails: [],
                boldTextRange: nil
            ),
            GemFAQContent(
                title: "How do I earn Gems?",
                description: "You can earn the most Gems by:",
                details: "Writing thoughtful Reviews: 15-110 Gems",
                subDetails: [
                    SubDetail(text: "15-20 Gems for creating (depends on length)", boldTextRanges: nil),
                    SubDetail(text: "Up to 50 Gems for getting comments from other members", boldTextRanges: nil),
                    SubDetail(text: "Extra 10 for adding an image (must be your own image/image you have the rights to use)", boldTextRanges: nil),
                    SubDetail(text: "Extra 30 if attached receipt is approved", boldTextRanges: nil),
                    SubDetail(text: "Extra 50 for Review Update", boldTextRanges: nil)
                ],
                boldTextRange: nil
            ),
            GemFAQContent(
                title: "",
                description: "",
                details: "Creating Q&A, Routine or List: 5-15 Gems –",
                subDetails: [
                    SubDetail(text: "5 Gems for creating these posts", boldTextRanges: nil),
                    SubDetail(text: "Up to 10 Gems for comments received from others", boldTextRanges: nil)
                ],
                boldTextRange: nil
            ),
            GemFAQContent(
                title: "",
                description: "",
                details: "Refer a friend: 50-1050 Gems",
                subDetails: [
                    SubDetail(text: "50 Gems when they write their first review", boldTextRanges: nil),
                    SubDetail(text: "1000 Gems if they become a Beauty Icon", boldTextRanges: nil)
                ],
                boldTextRange: nil
            ),
            GemFAQContent(
                title: "",
                description: "",
                details: "Gain Followers: 1 Gem each",
                subDetails: [],
                boldTextRange: nil
            ),
            GemFAQContent(
                title: "",
                description: "",
                details: "Nominations: 200 Gems when your nomination is approved (available only to Beauty Icons and Enthusiasts)",
                subDetails: [],
                boldTextRange: [NSRange(location: 0, length: 21)]
            ),
            GemFAQContent(
                title: "",
                description: "",
                details: "Other ways",
                subDetails: [
                    SubDetail(text: "Gems Challenges: Each one specifies the reward value", boldTextRanges: [NSRange(location: 0, length: 15)]),
                    SubDetail(text: "Gems Multipliers: Random opportunities", boldTextRanges: [NSRange(location: 0, length: 17)]),
                    SubDetail(text: "Gems Gifts from other members.", boldTextRanges: [NSRange(location: 0, length: 10)])
                ],
                boldTextRange: [NSRange(location: 0, length: 0)]
            ),
            GemFAQContent(
                title: "",
                description: "",
                details: "Beauty Icons only",
                subDetails: [
                    SubDetail(text: "Likes on your comments (up to 50 Gems per comment)", boldTextRanges: [NSRange(location: 0, length: 23)]),
                    SubDetail(text: "50 Gems for replying first on unanswered Q&A, if your answer gets 5 likes (your answer and your likes don't count)", boldTextRanges: [NSRange(location: 0, length: 44)]),
                    SubDetail(text: "100 Gems when you create Q&A and get 20 comments (not including your comments)", boldTextRanges: [NSRange(location: 0, length: 49)])
                ],
                boldTextRange: nil
            ),
            GemFAQContent(
                title: "How do I spend Gems",
                description: "Only the Confidant Club members can spend Gems. They can be spent on Drops, to share with others, and more.",
                details: "",
                subDetails: [],
                boldTextRange: nil
            ),
            GemFAQContent(
                title: "Can I lose Gems?",
                description: "Yes, in the following ways:",
                details: "",
                subDetails: [
                    SubDetail(text: "You delete the post that originally rewarded you Gems.", boldTextRanges: nil),
                    SubDetail(text: "If your post is moderated.", boldTextRanges: nil)
                ], boldTextRange: nil
            ),
        ]
    }
}


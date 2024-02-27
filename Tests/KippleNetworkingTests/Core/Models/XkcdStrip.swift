// Copyright © 2024 Brian Drelling. All rights reserved.

public struct XkcdStrip: Decodable, Equatable {
    let month: String
    let num: Int
    let link: String
    let year: String
    let news: String
    let safe_title: String
    let transcript: String
    let alt: String
    let img: String
    let title: String
    let day: String
}

// MARK: - Convenience

extension XkcdStrip {
    static let exploitsOfAMom: Self = .init(
        month: "10",
        num: 327,
        link: "",
        year: "2007",
        news: "",
        safe_title: #"Exploits of a Mom"#,
        transcript: "[[A woman is talking on the phone, holding a cup]]\nPhone: Hi, this is your son\'s school. We\'re having some computer trouble.\nMom: Oh dearâdid he break something?\nPhone: In a wayâ\nPhone: Did you really name your son \"Robert\'); DROP TABLE Students;--\" ?\nMom: Oh, yes. Little Bobby Tables, we call him.\nPhone: Well, we\'ve lost this year\'s student records. I hope you\'re happy.\nMom: And I hope you\'ve learned to sanitize your database inputs.\n{{title-text: Her daughter is named Help I\'m trapped in a driver\'s license factory.}}",
        alt: #"Her daughter is named Help I'm trapped in a driver's license factory."#,
        img: "https://imgs.xkcd.com/comics/exploits_of_a_mom.png",
        title: "Exploits of a Mom",
        day: "10"
    )
}

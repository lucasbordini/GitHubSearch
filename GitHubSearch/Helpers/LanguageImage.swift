//
//  LanguageImage.swift
//  GitHubSearch
//
//  Created by mazzatech on 22/07/19.
//  Copyright © 2019 lucasbordini. All rights reserved.
//

import UIKit

class LanguageImage {
    
    static func get(for language: String?) -> UIImage{
        switch  language {
        case "JavaScript":
            return UIImage(named: "ic_javascript") ?? UIImage()
        case "HTML":
            return UIImage(named: "ic_html") ?? UIImage()
        case "CSS":
            return UIImage(named: "ic_css") ?? UIImage()
        case "SQL":
            return UIImage(named: "ic_sql") ?? UIImage()
        case "Java":
            return UIImage(named: "ic_java") ?? UIImage()
        case "Shell":
            return UIImage(named: "ic_shell") ?? UIImage()
        case "Python":
            return UIImage(named: "ic_python") ?? UIImage()
        case "C#":
            return UIImage(named: "ic_sharp") ?? UIImage()
        case "PHP":
            return UIImage(named: "ic_php") ?? UIImage()
        case "C++":
            return UIImage(named: "ic_plus") ?? UIImage()
        case "C":
            return UIImage(named: "ic_c") ?? UIImage()
        case "TypeScript":
            return UIImage(named: "ic_typescript") ?? UIImage()
        case "Ruby":
            return UIImage(named: "ic_ruby") ?? UIImage()
        case "Swift":
            return UIImage(named: "ic_swift") ?? UIImage()
        case "Objective-C":
            return UIImage(named: "ic_objc") ?? UIImage()
        case "Go":
            return UIImage(named: "ic_go") ?? UIImage()
        case "R":
            return UIImage(named: "ic_r") ?? UIImage()
        case "MATLAB":
            return UIImage(named: "ic_matlab") ?? UIImage()
        case "Kotlin":
            return UIImage(named: "ic_kotlin") ?? UIImage()
        default:
            return UIImage()
        }
        
    }
}

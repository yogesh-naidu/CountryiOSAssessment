//
//  String.swift
//  Assignment
//


import Foundation

extension String{
    func removeWhiteSpace() -> String {
        return self.components(separatedBy: CharacterSet.whitespacesAndNewlines)
            .filter { !$0.isEmpty }
            .joined(separator: " ")
    }
}

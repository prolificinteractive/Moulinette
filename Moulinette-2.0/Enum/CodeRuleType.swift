//
//  CodeRuleType.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

enum CodeRuleType {
    case appDelegate
    case requiredSelf
    case semiColon
    case finalClasses
    case weakIBOutlet
    case singlePublicInternal
    case forceUnwrap
    case markUsage
    case singleEnum
    case internalModifier
    
    static func availableRules(projectData: ProjectData) -> [SwiftRule] {
        return [AppDelegateSwiftRule(projectData: projectData),
                RequiredSelfSwiftRule(projectData: projectData),
                SemiColonSwiftRule(projectData: projectData),
                FinalClassesSwiftRule(projectData: projectData),
                WeakIBOutletSwiftRule(projectData: projectData),
                SinglePublicInternalSwiftRule(projectData: projectData),
                ForceUnwrapSwiftRule(projectData: projectData),
                MarkUsageSwiftRule(projectData: projectData),
                SingleEnumCaseSwiftRule(projectData: projectData),
                InternalModifierSwiftRule(projectData: projectData)]
    }
}

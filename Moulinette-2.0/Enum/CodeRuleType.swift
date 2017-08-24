//
//  CodeRuleType.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

struct CodeConventionRuleCollection: RuleCollection {
    
    func rules(projectData: ProjectData) -> [SwiftRule] {
        return [
                AppDelegateSwiftRule(projectData: projectData),
                SemiColonSwiftRule(projectData: projectData),
                FinalClassesSwiftRule(projectData: projectData),
                WeakIBOutletSwiftRule(projectData: projectData),
                SinglePublicInternalSwiftRule(projectData: projectData),
                ForceUnwrapSwiftRule(projectData: projectData),
                MarkUsageSwiftRule(projectData: projectData),
                SingleEnumCaseSwiftRule(projectData: projectData),
                InternalModifierSwiftRule(projectData: projectData),
                TypeInferenceSwiftRule(projectData: projectData),
                FontEncapsulationSwiftRule(projectData: projectData),
                ColorEncapsulationSwiftRule(projectData: projectData),
                CompletionWeakSwiftRule(projectData: projectData),
                ToDoStorySwiftRule(projectData: projectData),
                ToDoCountSwiftRule(projectData: projectData),
                UsesLocalizationSwiftRule(projectData: projectData),
                RequiredSelfSwiftRule(projectData: projectData),
                LocalizedStringSwiftRule(projectData: projectData),
                ATSExceptionSwiftRule(projectData: projectData),
                ReadMeSwiftRule(projectData: projectData),
                LocalizedStringSwiftRule(projectData: projectData),
                PodVersionsPinnedSwiftRule(projectData: projectData),
                DefaultPodsSwiftRule(projectData: projectData),
                SwiftLintSwiftRule(projectData: projectData),
                ProjectOrganizationSwiftRule(projectData: projectData),
                CocoapodsKeysSwiftRule(projectData: projectData)
        ]
    }
}

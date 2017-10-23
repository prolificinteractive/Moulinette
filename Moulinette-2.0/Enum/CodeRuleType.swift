//
//  CodeRuleType.swift
//  Moulinette-2.0
//
//  Created by Jonathan Samudio on 5/31/17.
//  Copyright © 2017 Prolific Interactive. All rights reserved.
//

import Foundation

/// Project convention rule collection.
struct ProjectConventionRuleCollection: RuleCollection {
    
    let description: String = "Project convention rules"
    
    func rules(projectData: ProjectData) -> [SwiftRule] {
        return [
            ProjectOrganizationSwiftRule(projectData: projectData),
            AppIconSwiftRule(projectData: projectData),
            EmptyAppIconSwiftRule(projectData: projectData)
        ]
    }
    
}

/// Code convention rule collection.
struct CodeConventionRuleCollection: RuleCollection {
    
    let description: String = "Code convention rules"

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
            RequiredSelfSwiftRule(projectData: projectData),
        ]
    }
    
}

/// Localization rule collection.
struct LocalizationRuleCollection: RuleCollection {
    
    let description: String = "Localization rules"

    func rules(projectData: ProjectData) -> [SwiftRule] {
        return [
            UsesLocalizationSwiftRule(projectData: projectData),
            LocalizedStringSwiftRule(projectData: projectData)
        ]
    }
    
}

/// API integration rule collection.
struct APIIntegrationRuleCollection: RuleCollection {
    
    let description: String = "API Integration rules"

    func rules(projectData: ProjectData) -> [SwiftRule] {
        return []
    }
    
}

/// Documentation rule collection.
struct DocumentationRuleCollection: RuleCollection {
    
    let description: String = "Documentation rules"

    func rules(projectData: ProjectData) -> [SwiftRule] {
        return [
            ReadMeSwiftRule(projectData: projectData)
        ]
    }
    
}

/// Compiler rule collection.
struct CompilerRuleCollection: RuleCollection {
    
    let description: String = "Compiler rules"

    func rules(projectData: ProjectData) -> [SwiftRule] {
        return []
    }
    
}

/// Tests coverage rule collection.
struct TestsCoverageRuleCollection: RuleCollection {
    
    let description: String = "Tests coverage rules"

    func rules(projectData: ProjectData) -> [SwiftRule] {
        return []
    }
    
}

/// Tools rule collection.
struct ToolsRuleCollection: RuleCollection {
    
    let description: String = "Tools rules"

    func rules(projectData: ProjectData) -> [SwiftRule] {
        return []
    }
    
}

/// Dependencies rule collection.
struct DependenciesRuleCollection: RuleCollection {
    
    let description: String = "Dependencies rules"

    func rules(projectData: ProjectData) -> [SwiftRule] {
        return [
            CocoapodsKeysSwiftRule(projectData: projectData),
            DefaultPodsSwiftRule(projectData: projectData),
            PodVersionsPinnedSwiftRule(projectData: projectData)
        ]
    }
    
}

/// CI rule collection.
struct CIRuleCollection: RuleCollection {
    
    let description: String = "CI rules"

    func rules(projectData: ProjectData) -> [SwiftRule] {
        return [
            SwiftLintSwiftRule(projectData: projectData)
        ]
    }
    
}

/// Git rule collection.
struct GitRuleCollection: RuleCollection {
    
    let description: String = "Git rules"

    func rules(projectData: ProjectData) -> [SwiftRule] {
        return [
            GitCheckMergedBranchSwiftRule(projectData: projectData)
        ]
    }
    
}

/// App store rule collection.
struct AppstoreRuleCollection: RuleCollection {
    
    let description: String = "Appstore rules"

    func rules(projectData: ProjectData) -> [SwiftRule] {
        return []
    }
    
}

/// Security rule collection.
struct SecurityRuleCollection: RuleCollection {
    
    let description: String = "Security rules"

    func rules(projectData: ProjectData) -> [SwiftRule] {
        return [
            ATSExceptionSwiftRule(projectData: projectData)
        ]
    }
    
}

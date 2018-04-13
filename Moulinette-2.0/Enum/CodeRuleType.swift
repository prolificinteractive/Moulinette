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
    
    func rules() -> [SwiftRule] {
        return [
            ProjectOrganizationSwiftRule(),
            AppIconSwiftRule(),
            EmptyAppIconSwiftRule()
        ]
    }
    
}

/// Code convention rule collection.
struct CodeConventionRuleCollection: RuleCollection {
    
    let description: String = "Code convention rules"

    func rules() -> [SwiftRule] {
        return [
            AppDelegateSwiftRule(),
            SemiColonSwiftRule(),
            FinalClassesSwiftRule(),
            WeakIBOutletSwiftRule(),
            SinglePublicInternalSwiftRule(),
            ForceUnwrapSwiftRule(),
            MarkUsageSwiftRule(),
            SingleEnumCaseSwiftRule(),
            InternalModifierSwiftRule(),
            TypeInferenceSwiftRule(),
            FontEncapsulationSwiftRule(),
            ColorEncapsulationSwiftRule(),
            CompletionWeakSwiftRule(),
            ToDoStorySwiftRule(),
            ToDoCountSwiftRule(),
            RequiredSelfSwiftRule(),
            EndContextBracketSwiftRule(),
            PublicPropertyMarkSectionSwiftRule(),
            PrivatePropertyMarkSectionSwiftRule(),
            InitializationyMarkSectionSwiftRule(),
            PublicFunctionMarkSectionSwiftRule(),
            PrivateFunctionsMarkSectionSwiftRule(),
            ProtocolExtensionMarkSectionSwiftRule()
        ]
    }
    
}

/// Localization rule collection.
struct LocalizationRuleCollection: RuleCollection {
    
    let description: String = "Localization rules"

    func rules() -> [SwiftRule] {
        return [
            UsesLocalizationSwiftRule(),
            LocalizedStringSwiftRule()
        ]
    }
    
}

/// API integration rule collection.
struct APIIntegrationRuleCollection: RuleCollection {
    
    let description: String = "API Integration rules"

    func rules() -> [SwiftRule] {
        return []
    }
    
}

/// Documentation rule collection.
struct DocumentationRuleCollection: RuleCollection {
    
    let description: String = "Documentation rules"

    func rules() -> [SwiftRule] {
        return [
            ReadMeSwiftRule()
        ]
    }
    
}

/// Compiler rule collection.
struct CompilerRuleCollection: RuleCollection {
    
    let description: String = "Compiler rules"

    func rules() -> [SwiftRule] {
        return []
    }
    
}

/// Tests coverage rule collection.
struct TestsCoverageRuleCollection: RuleCollection {
    
    let description: String = "Tests coverage rules"

    func rules() -> [SwiftRule] {
        return []
    }
    
}

/// Tools rule collection.
struct ToolsRuleCollection: RuleCollection {
    
    let description: String = "Tools rules"

    func rules() -> [SwiftRule] {
        return []
    }
    
}

/// Dependencies rule collection.
struct DependenciesRuleCollection: RuleCollection {
    
    let description: String = "Dependencies rules"

    func rules() -> [SwiftRule] {
        return [
            CocoapodsKeysSwiftRule(),
            DefaultPodsSwiftRule(),
            PodVersionsPinnedSwiftRule()
        ]
    }
    
}

/// CI rule collection.
struct CIRuleCollection: RuleCollection {
    
    let description: String = "CI rules"

    func rules() -> [SwiftRule] {
        return [
            SwiftLintSwiftRule()
        ]
    }
    
}

/// Git rule collection.
struct GitRuleCollection: RuleCollection {
    
    let description: String = "Git rules"

    func rules() -> [SwiftRule] {
        return [
            GitCheckMergedBranchSwiftRule(),
            GitCheckCommitQualitySwiftRule(),
            GitCheckConfigurationSwiftRule(),
            GitCheckBranchNameSwiftRule()
        ]
    }
    
}

/// App store rule collection.
struct AppstoreRuleCollection: RuleCollection {
    
    let description: String = "Appstore rules"

    func rules() -> [SwiftRule] {
        return []
    }
    
}

/// Security rule collection.
struct SecurityRuleCollection: RuleCollection {
    
    let description: String = "Security rules"

    func rules() -> [SwiftRule] {
        return [
            ATSExceptionSwiftRule()
        ]
    }
    
}

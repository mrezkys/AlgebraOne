//
//  TutorialContent.swift
//  AlgebraOne
//
//  Created by Muhammad Rezky on 05/04/25.
//

import Foundation

class TutorialContent {
    static func getContent(for section: TutorialSection) -> [TutorialStep] {
        switch section {
        case .introduction:
            return introductionSteps()
        case .coreConceptsBasics:
            return coreConceptsSteps()
        case .simpleEquations:
            return simpleEquationsSteps()
        case .twoSidedEquations:
            return twoSidedEquationsSteps()
        case .distributiveEquations:
            return distributiveEquationsSteps()
        case .fractionEquations:
            return fractionEquationsSteps()
        case .summary:
            return summarySteps()
        }
    }
    
    // MARK: - Tutorial Content
    
    private static func introductionSteps() -> [TutorialStep] {
        return [
            TutorialStep(
                title: "What are Linear Equations?",
                description: "Linear equations are equations where the variable has a power of 1. They are called 'linear' because when graphed, they form a straight line. In algebra, we use these equations to find unknown values in many real-world situations.",
                image: nil,
                equation: nil,
                steps: nil
            ),
            TutorialStep(
                title: "Why are Linear Equations Important?",
                description: "Linear equations are used to model many real-world situations, from calculating costs and profits to determining distances, speeds, and times. They are foundational for more advanced mathematics and appear in fields like economics, engineering, and science.",
                image: nil,
                equation: nil,
                steps: nil
            ),
            TutorialStep(
                title: "What You'll Learn",
                description: "In this tutorial, you'll learn how to identify and solve different types of linear equations step by step. We'll cover the systematic approach to isolating variables and finding exact solutions through careful algebraic manipulations.",
                image: nil,
                equation: nil,
                steps: nil
            )
        ]
    }
    
    private static func coreConceptsSteps() -> [TutorialStep] {
        return [
            TutorialStep(
                title: "Variables",
                description: "Variables are symbols (usually letters like x, y, z) that represent unknown values we want to find. In linear equations, these variables appear with a power of 1, such as x (not x², x³, etc.).",
                image: nil,
                equation: "3x + 5 = 20",
                steps: [
                    StepModel(text: "In this equation:", type: .header),
                    StepModel(text: "x is the variable we need to solve for", type: .explanation),
                    StepModel(text: "The solution will tell us what number x represents", type: .explanation)
                ]
            ),
            TutorialStep(
                title: "Coefficients", 
                description: "Coefficients are numbers that multiply variables. They indicate how many of each variable is present in the equation. For example, in 3x + 2y, 3 is the coefficient of x and 2 is the coefficient of y.",
                image: nil,
                equation: "5x - 2 = 8",
                steps: [
                    StepModel(text: "Looking at the equation:", type: .header),
                    StepModel(text: "5 multiplies x, so it's the coefficient", type: .explanation),
                    StepModel(text: "The negative sign can also be part of the coefficient", type: .explanation)
                ]
            ),
            TutorialStep(
                title: "Constants",
                description: "Constants are fixed numbers that stand alone without variables. They represent known quantities in the equation. In the equation 2x + 5 = 9, both 5 and 9 are constants.",
                image: nil,
                equation: "x + 7 = 12",
                steps: [
                    StepModel(text: "In this example:", type: .header),
                    StepModel(text: "7 and 12 are the constants", type: .explanation),
                    StepModel(text: "They're the known values in our equation", type: .explanation)
                ]
            ),
            TutorialStep(
                title: "Equality",
                description: "The equals sign (=) shows that the expressions on both sides have the same value. It represents a balance between the left and right sides. Any operation we perform must be done to both sides to maintain this balance.",
                image: nil,
                equation: "4x - 3 = 9",
                steps: [
                    StepModel(text: "Remember:", type: .header),
                    StepModel(text: "Left side (4x - 3) equals right side (9)", type: .explanation),
                    StepModel(text: "This balance helps us solve for x", type: .explanation)
                ]
            )
        ]
    }
    
    private static func simpleEquationsSteps() -> [TutorialStep] {
        return [
            TutorialStep(
                title: "Simple Linear Equations",
                description: "These have the form ax + b = c, where a, b, and c are constants and x is the variable. To solve these equations, we need to isolate the variable (x) through a series of operations that maintain the balance of the equation.",
                image: nil,
                equation: "2x + 3 = 7",
                steps: nil
            ),
            TutorialStep(
                title: "Solving Process",
                description: "Let's solve the equation 2x + 3 = 7 step by step:",
                image: nil,
                equation: "2x + 3 = 7",
                steps: [
                    StepModel(text: "Step 1: Identify the terms in the equation", type: .header),
                    StepModel(text: "Coefficient of x: 2", type: .explanation),
                    StepModel(text: "Constant on left side: +3", type: .explanation),
                    StepModel(text: "Constant on right side: 7", type: .explanation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Step 2: Subtract 3 from both sides to isolate the term with x", type: .header),
                    StepModel(text: "2x + 3 - 3 = 7 - 3", type: .equation),
                    StepModel(text: "2x = 4", type: .equation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Step 3: Divide both sides by 2 to isolate x", type: .header),
                    StepModel(text: "2x ÷ 2 = 4 ÷ 2", type: .equation),
                    StepModel(text: "x = 2", type: .equation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Step 4: Verify the solution by substituting back", type: .header),
                    StepModel(text: "2(2) + 3 = 7", type: .equation),
                    StepModel(text: "4 + 3 = 7", type: .equation),
                    StepModel(text: "7 = 7 ✓", type: .verification),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Final Step: The value of x is 2", type: .header)
                ]
            ),
            TutorialStep(
                title: "Key Principle",
                description: "Whatever you do to one side of the equation, you must do to the other side to maintain equality. This is the fundamental principle of equation solving.",
                image: nil,
                equation: nil,
                steps: nil
            )
        ]
    }
    
    private static func twoSidedEquationsSteps() -> [TutorialStep] {
        return [
            TutorialStep(
                title: "Two-sided Linear Equations",
                description: "These have the form ax + b = dx + e, where variables appear on both sides. These equations require an additional step to move all variable terms to one side and all constant terms to the other side.",
                image: nil,
                equation: "3x + 2 = x + 8",
                steps: nil
            ),
            TutorialStep(
                title: "Solving Process",
                description: "Let's solve the equation 3x + 2 = x + 8 step by step:",
                image: nil,
                equation: "3x + 2 = x + 8",
                steps: [
                    StepModel(text: "Step 1: Identify the terms in the equation", type: .header),
                    StepModel(text: "Left side: 3x + 2 (coefficient of x is 3, constant is 2)", type: .explanation),
                    StepModel(text: "Right side: x + 8 (coefficient of x is 1, constant is 8)", type: .explanation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Step 2: Move all variable terms to one side by subtracting x from both sides", type: .header),
                    StepModel(text: "3x - x + 2 = x - x + 8", type: .equation),
                    StepModel(text: "2x + 2 = 8", type: .equation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Step 3: Move all constant terms to the other side by subtracting 2 from both sides", type: .header),
                    StepModel(text: "2x + 2 - 2 = 8 - 2", type: .equation),
                    StepModel(text: "2x = 6", type: .equation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Step 4: Divide both sides by 2 to isolate x", type: .header),
                    StepModel(text: "2x ÷ 2 = 6 ÷ 2", type: .equation),
                    StepModel(text: "x = 3", type: .equation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Step 5: Verify the solution by substituting back", type: .header),
                    StepModel(text: "3(3) + 2 = (3) + 8", type: .equation),
                    StepModel(text: "9 + 2 = 3 + 8", type: .equation),
                    StepModel(text: "11 = 11 ✓", type: .verification),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Final Step: The value of x is 3", type: .header)
                ]
            ),
            TutorialStep(
                title: "Key Principle",
                description: "Group like terms (variables with variables, constants with constants) to simplify the equation. This makes it easier to isolate the variable and find the solution.",
                image: nil,
                equation: nil,
                steps: nil
            )
        ]
    }
    
    private static func distributiveEquationsSteps() -> [TutorialStep] {
        return [
            TutorialStep(
                title: "Distributive Property Equations",
                description: "These have the form a(x + b) = c, where the variable is inside parentheses. The distributive property states that a(x + b) = ax + ab, but we can also solve these directly.",
                image: nil,
                equation: "3(x + 2) = 15",
                steps: nil
            ),
            TutorialStep(
                title: "Solving Process - Method 1",
                description: "Let's solve the equation 3(x + 2) = 15 directly without expanding the parentheses:",
                image: nil,
                equation: "3(x + 2) = 15",
                steps: [
                    StepModel(text: "Step 1: Identify the expression inside parentheses and its coefficient", type: .header),
                    StepModel(text: "Expression in parentheses: (x + 2)", type: .explanation),
                    StepModel(text: "Coefficient: 3", type: .explanation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Step 2: Divide both sides by the coefficient (3) to isolate the parentheses", type: .header),
                    StepModel(text: "3(x + 2) ÷ 3 = 15 ÷ 3", type: .equation),
                    StepModel(text: "(x + 2) = 5", type: .equation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Step 3: Subtract the constant inside the parentheses from both sides", type: .header),
                    StepModel(text: "x + 2 - 2 = 5 - 2", type: .equation),
                    StepModel(text: "x = 3", type: .equation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Step 4: Verify the solution by substituting back", type: .header),
                    StepModel(text: "3(3 + 2) = 15", type: .equation),
                    StepModel(text: "3(5) = 15", type: .equation),
                    StepModel(text: "15 = 15 ✓", type: .verification),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Final Step: The value of x is 3", type: .header)
                ]
            ),
            TutorialStep(
                title: "Solving Process - Method 2",
                description: "Let's solve the same equation 3(x + 2) = 15 by first expanding the parentheses:",
                image: nil,
                equation: "3(x + 2) = 15",
                steps: [
                    StepModel(text: "Step 1: Apply the distributive property to expand the left side", type: .header),
                    StepModel(text: "3(x + 2) = 3x + 3(2)", type: .equation),
                    StepModel(text: "3x + 6 = 15", type: .equation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Step 2: Subtract 6 from both sides to isolate the term with x", type: .header),
                    StepModel(text: "3x + 6 - 6 = 15 - 6", type: .equation),
                    StepModel(text: "3x = 9", type: .equation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Step 3: Divide both sides by 3 to isolate x", type: .header),
                    StepModel(text: "3x ÷ 3 = 9 ÷ 3", type: .equation),
                    StepModel(text: "x = 3", type: .equation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Step 4: Verify the solution by substituting back", type: .header),
                    StepModel(text: "3(3 + 2) = 15", type: .equation),
                    StepModel(text: "3(5) = 15", type: .equation),
                    StepModel(text: "15 = 15 ✓", type: .verification),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Final Step: The value of x is 3", type: .header)
                ]
            )
        ]
    }
    
    private static func fractionEquationsSteps() -> [TutorialStep] {
        return [
            TutorialStep(
                title: "Fraction Equations",
                description: "These have the form (x + b)/a = c, where the variable is in a fraction. The key to solving these is to eliminate the fraction by multiplying both sides by the denominator.",
                image: nil,
                equation: "(x + 3)/2 = 4",
                steps: nil
            ),
            TutorialStep(
                title: "Solving Process",
                description: "Let's solve the equation (x + 3)/2 = 4 step by step:",
                image: nil,
                equation: "(x + 3)/2 = 4",
                steps: [
                    StepModel(text: "Step 1: Identify the parts of the fraction", type: .header),
                    StepModel(text: "Numerator: (x + 3)", type: .explanation),
                    StepModel(text: "Denominator: 2", type: .explanation),
                    StepModel(text: "Right side: 4", type: .explanation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Step 2: Multiply both sides by the denominator (2) to eliminate the fraction", type: .header),
                    StepModel(text: "2 × (x + 3)/2 = 2 × 4", type: .equation),
                    StepModel(text: "x + 3 = 8", type: .equation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Step 3: Subtract 3 from both sides to isolate x", type: .header),
                    StepModel(text: "x + 3 - 3 = 8 - 3", type: .equation),
                    StepModel(text: "x = 5", type: .equation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Step 4: Verify the solution by substituting back", type: .header),
                    StepModel(text: "(5 + 3)/2 = 4", type: .equation),
                    StepModel(text: "8/2 = 4", type: .equation),
                    StepModel(text: "4 = 4 ✓", type: .verification),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Step 5: Check for extraneous solutions", type: .header),
                    StepModel(text: "No extraneous solutions found as the denominators don't become zero with x = 5", type: .explanation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Final Step: The value of x is 5", type: .header)
                ]
            ),
            TutorialStep(
                title: "Key Principle",
                description: "Multiplying both sides by the denominator helps clear fractions, making the equation easier to solve. However, always check for extraneous solutions that might arise from this process.",
                image: nil,
                equation: nil,
                steps: nil
            )
        ]
    }
    
    private static func summarySteps() -> [TutorialStep] {
        return [
            TutorialStep(
                title: "Key Solving Principles",
                description: "Remember these fundamental principles when solving any linear equation:",
                image: nil,
                equation: nil,
                steps: [
                    StepModel(text: "1. Keep the equation balanced by doing the same operation to both sides", type: .header),
                    StepModel(text: "This is the golden rule of equation solving. If you add, subtract, multiply, or divide on one side, you must do the same to the other side.", type: .explanation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "2. Isolate the variable by undoing operations in reverse order", type: .header),
                    StepModel(text: "Work backward from the final form to isolate the variable. If the variable is multiplied, divide. If it has something added, subtract.", type: .explanation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "3. Check your answer by substituting back into the original equation", type: .header),
                    StepModel(text: "Always verify your solution by plugging it back into the original equation to make sure both sides are equal.", type: .explanation)
                ]
            ),
            TutorialStep(
                title: "Tips for Success",
                description: "Follow these practical guidelines to improve your equation-solving skills:",
                image: nil,
                equation: nil,
                steps: [
                    StepModel(text: "Write out each step clearly and neatly", type: .header),
                    StepModel(text: "Clear work helps you avoid mistakes and allows you to track your process.", type: .explanation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Pay careful attention to positive and negative signs", type: .header),
                    StepModel(text: "Sign errors are among the most common mistakes in algebra.", type: .explanation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "When working with fractions or decimals, consider converting to whole numbers", type: .header),
                    StepModel(text: "Multiplying both sides by the denominator can eliminate fractions.", type: .explanation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Check for extraneous solutions", type: .header),
                    StepModel(text: "Especially when working with fractions or square roots, verify that your answer doesn't make any denominator zero.", type: .explanation),
                    StepModel(text: "", type: .spacer),
                    StepModel(text: "Practice regularly with different types of equations", type: .header),
                    StepModel(text: "The more you practice, the more comfortable you'll become with the process.", type: .explanation)
                ]
            ),
            TutorialStep(
                title: "Ready to Practice!",
                description: "Now that you understand the basics of linear equations and the step-by-step process for solving them, you're ready to test your knowledge with practice problems. Click 'Start Practice' to begin solving equations on your own!",
                image: nil,
                equation: nil,
                steps: nil
            )
        ]
    }
} 

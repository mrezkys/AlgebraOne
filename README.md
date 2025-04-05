# AlgebraOne

AlgebraOne is an iOS application designed to teach users how to solve 1-variable linear equations step-by-step in a fun and engaging way.

## Features

- Step-by-step equation solving for different linear equation patterns
- Clean, modern UI following Apple's Human Interface Guidelines
- Multiple-choice questions with feedback
- Detailed solution explanations
- Progress tracking and encouragement
- Tutorial for beginners

## Architecture

The app is built using the VIPER architecture pattern for clean separation of concerns:

- **View**: Responsible for displaying the UI and forwarding user interactions to the Presenter
- **Interactor**: Contains the business logic and communicates with data services
- **Presenter**: Acts as the middleman between View and Interactor, formats data for the View
- **Entity**: Represents the data models used in the application
- **Router**: Handles navigation between screens

## Project Structure

The project is organized by feature modules:

- **Models**: Contains the core data models (EquationModel, LinearEquationPattern)
- **Utils**: Shared utilities and styles
- **WelcomeModule**: Initial welcome screen
- **QuestionModule**: Question presentation and answer validation
- **SolutionModule**: Step-by-step solution presentation
- **SummaryModule**: Session summary and progress feedback
- **TutorialModule**: Interactive tutorial for learning basics

## Requirements

- iOS 14.0+
- Xcode 13.0+
- Swift 5.5+

## Getting Started

1. Clone the repository
2. Open the project in Xcode
3. Build and run on a simulator or device

## Technical Implementation

This app is built using:

- **UIKit**: Programmatic UI (no storyboards)
- **Swift Package Manager**: Dependency management
- **VIPER Architecture**: For clean separation of concerns
- **Standard UIKit Components**: UILabel, UIButton, UIStackView, UITableView, UICollectionView, etc.

## Usage Flow

1. Welcome screen introduces the app
2. User can choose to go to Play or Tutorial
3. Tutorial screen provides an interactive learning experience
4. From Tutorial completion, user can proceed to Play/Question
5. Question screen presents a linear equation to solve
6. User selects from multiple-choice answers
7. If correct, move to the next question
8. If incorrect, offer to see the step-by-step solution
9. Solution screen shows detailed solving steps
10. Summary screen after completing a session

## Incident Tracker

### General Description
IncidentTracker is an iOS app for reporting and tracking incidents, with a clean and modular SwiftUI architecture.  

### Features
- Authentication flow (Login & Verification)
- Incident management (Add Incident, Home feed)
- Shared reusable UI components
- Centralized routing & networking
- Clean separation of layers (Core, Data, Domain, Presentation)

### Installation
1. Prerequisites
   - Xcode 16 or newer
   - iOS 17.0+ deployment target recommended
   - Swift Package Manager (bundled with Xcode)

2. Clone the repository
   ```bash
   git clone https://github.com/fareselsokary/IncidentTracker.git
   cd IncidentTracker
   ```

3. Open the project
   - Open `IncidentTracker.xcodeproj` in Xcode.
   - Xcode will resolve Swift Package dependencies automatically (e.g., Kingfisher).

4. Build & Run
   - Select the `IncidentTracker` scheme and run on a simulator or device.

### Project Structure
```
IncidentTracker/
├── IncidentTracker/
│   ├── Core/
│   │   ├── Extension/
│   │   ├── Networking/
│   │   ├── Routing/
│   │   └── Services/
│   │
│   ├── Data/
│   │   ├── DTOs/
│   │   │   ├── Requests/
│   │   │   └── Responses/
│   │   ├── Mappers/
│   │   ├── Preview/
│   │   ├── Remote/
│   │   │   └── Endpoints/
│   │   └── RepositoriesImpl/
│   │
│   ├── Domain/
│   │   ├── Entities/
│   │   ├── Protocols/
│   │   ├── Repositories/
│   │   └── UseCases/
│   │
│   ├── Presentation/
│   │   ├── Features/
│   │   │   ├── Authentication/
│   │   │   │   ├── Login/
│   │   │   │   └── Verification/
│   │   │   └── Incident/
│   │   │       ├── AddIncident/
│   │   │       └── Home/
│   │   ├── SharedUI/
│   │   └── ViewModifier/
│   │
│   ├── Resources/
│   ├── ContentView.swift
│   └── IncidentTrackerApp.swift
│
├── IncidentTrackerTests/
└── IncidentTrackerUITests/
```

### Architecture
- Layered design separating UI, business logic, data access, and core utilities
- Protocol-oriented abstractions for easy substitution and testing
- Asynchronous workflows for network-bound features


### Technologies Used
- Swift 5, SwiftUI, Combine  
- KeychainSwift → secure storage  
- Kingfisher → async image loading & caching  
- XCTest / XCUITest → unit & UI testing  
- Swift Package Manager → dependency management  

### License
This project is licensed under the MIT License. You are free to use, copy, modify, merge, publish, and distribute the software with proper attribution and without warranty of any kind.

 

# CharacterListTask

## Overview
CharacterListTask is an iOS application that fetches and displays a list of characters. The app retrieves data from an API and presents character details, including the name, species, gender, status, and location. It follows modern software architecture principles such as Clean Architecture and uses Combine for reactive programming.

### Features
- Display a list of characters with relevant details.
- View detailed information for each character.
- Fetch character data filtered by status ("unknown", "alive", "dead").
- Robust error handling for network requests.

### Technologies Used
- Swift: Programming language.
- SwiftUI: Framework for building the user interface.
- Combine: Framework for reactive programming.
- URLSession: For network requests.
- JSONDecoder: For decoding API responses.

### Architecture
The project is structured using Clean Architecture:

- Presentation Layer: Includes CharacterListView and CharacterDetailsView.
- Domain Layer: Contains the core business logic, such as FetchCharactersUseCase.
- Data Layer: Handles API requests and mapping responses to domain models.
- Network Layer: handle request using URLSession.

### Installation

#### Steps to Install
- Clone the repository to your local machine: git clone https://github.com/yourusername/CharacterListTask.git
- open CharacterListTask.xcodeproj

### Unit Testing
#### Tests Included (Service Layer)
- testFetchCharacters_Success: Tests the successful retrieval of character data.
- testFetchCharacters_Failure: Tests the handling of a failed network request due to connectivity issues.

  


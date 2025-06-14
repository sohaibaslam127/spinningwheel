## Game Overview

This interactive number selection game is engineered using Flutter with the GetX state management system to ensure a responsive, scalable, and maintainable architecture. The application is designed with performance, modularity, and reusability in mind, making it easy to expand or adapt for larger-scale use cases.

## Architecture & Technology Stack

* ### State Management:
  Leveraging GetX for reactive programming and seamless state updates, ensuring smooth gameplay and efficient data flow across the app.

* ### Controllers & Models:
  Organized with a clear separation of concerns using dedicated controllers and data models. This allows for easy extension, debugging, and reuse of logic.

* ### Services Layer:
  Performance optimization and real-time logic handling are managed through service classes, ensuring the core logic remains clean and scalable.

* ### Custom Widgets:
  Reusable widget components are implemented throughout the app, promoting consistency in UI/UX and simplifying future modifications.


## Key Features

* ### Splash Screen Initialization:
    - Displays a splash screen during the initialization of the local database and required controllers, offering a seamless user experience.

* ### Interactive Number Wheel:
  - A spinning wheel randomly selects numbers.
  - After each spin, the wheel stops and requires user interaction to spin again.
  - Each number is visually categorized by color (e.g., red or blue) to differentiate selections.

* ### Smart Selection Logic:
  * A maximum of five numbers can be selected.
  * When a new number is selected after reaching the limit, the oldest number is automatically removed, and the new one is added.

* ### Persistent Local History:
  * User selections are stored locally.
  * Previously selected numbers are restored and displayed in the "Recent Numbers" section upon app restart.

* ### History Management:
  * Users can clear their selection history with a single tap using the Clear History button.

* ### Wheel Speed Adjustment:
  * The speed of wheel rotation can be configured dynamically to suit the user’s preference or platform needs.


## Platform Support
The app is fully cross-platform, with support for:
* iOS
* Android
* Web
* macOS
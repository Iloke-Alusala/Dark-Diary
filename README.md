# Noted-Flutter-App-
<p align="center">
  <img src="https://img.icons8.com/external-tal-revivo-regular-tal-revivo/96/external-readme-is-a-easy-to-build-a-developer-hub-that-adapts-to-the-user-logo-regular-tal-revivo.png" width="100" alt="project-logo">
</p>
<p align="center">
    <h1 align="center">DARK-DIARY</h1>
</p>
<p align="center">
    <em><code>► INSERT-TEXT-HERE</code></em>
</p>
<p align="center">
	<!-- Shields.io badges not used with skill icons. --><p>
<p align="center">
		<em>Developed with the software and tools below.</em>
</p>
<p align="center">
	<a href="https://skillicons.dev">
		<img src="https://skillicons.dev/icons?i=dart,md&theme=light">
	</a></p>

<br><!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary><br>

- [ Overview](#-overview)
- [ Features](#-features)
- [ Repository Structure](#-repository-structure)
- [ Modules](#-modules)
- [ Getting Started](#-getting-started)
  - [ Installation](#-installation)
  - [ Usage](#-usage)
  - [ Tests](#-tests)
- [ Project Roadmap](#-project-roadmap)
- [ Contributing](#-contributing)
- [ License](#-license)
- [ Acknowledgments](#-acknowledgments)
</details>
<hr>

##  Overview

<p>DiaryDark provides a seamless experience for users to create, edit, and organize their notes within customizable folders. Whether you're capturing fleeting moments, brainstorming new concepts, or keeping track of your to-do lists, DiaryDark offers the tools you need to stay productive and organized on the go.</p>

---

##  Features

<p>### Note Management
- **Create Notes**: Easily create new notes with customizable titles and descriptions.
- **Edit Notes**: Modify existing notes to update their content or metadata.
- **Delete Notes**: Remove unwanted notes from the application.

### Folder Organization
- **Create Folders**: Organize notes into folders to categorize them based on topics or themes.
- **Edit Folder Names**: Rename folders to better reflect their contents or purpose.
- **Delete Folders**: Remove folders along with their associated notes.

### User Interface
- **Dark Mode**: Enjoy a sleek and stylish dark mode interface for comfortable usage in low-light environments.
- **Responsive Design**: Experience a user-friendly interface optimized for various screen sizes and orientations.

### Note Viewing and Editing
- **View Notes**: Access and read notes with ease using the note viewing interface.
- **Edit Notes**: Make changes to note content and metadata directly from the note viewing screen.
- **Long Note Support**: Seamlessly handle long notes with scrollable viewing and editing capabilities.

### Customization
- **Color Themes**: Choose from a variety of color themes to personalize the app's appearance to suit your preferences.
- **Font Options**: Select different font styles and sizes for an enhanced reading and writing experience.

### Data Persistence
- **Local Storage**: Store notes and folders locally on the device for offline access and data security.
- **Database Integration**: Utilize SQLite database for efficient data management and retrieval.

### Share and Export
- **Share Notes**: Share notes with others via various communication channels, such as email or messaging apps.
- **Export Notes**: Export notes in different formats for backup or sharing purposes.</p>

---

##  Repository Structure

```sh
└── Dark-Diary/
    ├── Colors
    │   └── Colors.dart
    ├── DB
    │   ├── folderDB.dart
    │   └── notesDB.dart
    ├── Main
    │   └── main.dart
    ├── Models
    │   ├── Folder.dart
    │   └── Note.dart
    ├── Pages
    │   ├── folder_display.dart
    │   ├── folder_view.dart
    │   ├── note_page.dart
    │   ├── note_view.dart
    │   └── panelWidget.dart
    ├── README.md
    ├── Services
    │   ├── HeroDialogRoute.dart
    │   ├── SlideupPageRoute.dart
    │   ├── customPageRoute.dart
    │   ├── customRectTween.dart
    │   └── quickPageRoute.dart
    ├── Widgets
    │   ├── addFolderButton.dart
    │   ├── addNoteButton.dart
    │   ├── editFolderName.dart
    │   ├── folderCard.dart
    │   ├── longNote.dart
    │   ├── smallNote.dart
    │   └── wideNote.dart
    ├── dots.png
    ├── kebab.png
    └── pubspec.yaml
```

---

##  Modules

<details closed><summary>.</summary>

| File                                                                                 | Summary                         |
| ---                                                                                  | ---                             |
| [pubspec.yaml](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/pubspec.yaml) | <code>## Description

The `pubspec.yaml` file defines the dependencies, assets, and configuration for the "diarydark" Flutter project.

### Features

- **Dependencies**: Lists the packages required for the project to function properly.
- **Assets**: Includes fonts and image assets used in the project.
- **Configuration**: Provides metadata about the project, such as name, description, version, and supported platforms.

## Usage

To use the `pubspec.yaml` file in your Flutter project, follow these steps:

1. Copy the contents of the `pubspec.yaml` file into your project's `pubspec.yaml`.
2. Update the dependencies and assets sections according to your project's needs.
3. Run `flutter pub get` in your project directory to install the dependencies listed in the `pubspec.yaml` file.</code> |

</details>

<details closed><summary>Models</summary>

| File                                                                                      | Summary                         |
| ---                                                                                       | ---                             |
| [Note.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Models/Note.dart)     | <code>## Description

The `Note.dart` file provides a `Note` class, which represents a note entity with properties such as id, importance, number, title, description, creation time, and folder id. It also includes constants for database table and field names.

### Features

- **Note Properties**: Defines properties for id, importance, number, title, description, creation time, and folder id of notes.
- **JSON Serialization**: Supports converting note objects to and from JSON format.
- **Copy Method**: Provides a method for creating a copy of a note object with optional modifications.

## Usage

To use the `Note` class in your Flutter application, follow these steps:

1. Import the `Note.dart` file into your project.
2. Create instances of the `Note` class to represent notes in your application.
3. Utilize the provided methods for JSON serialization and copying note objects.</code> |
| [Folder.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Models/Folder.dart) | <code>## Description

The `Folder.dart` file provides a `Folder` class, which represents a folder entity with properties such as id, name, creation time, and size. It also includes constants for database table and field names.

### Features

- **Folder Properties**: Defines properties for id, name, creation time, and size of folders.
- **JSON Serialization**: Supports converting folder objects to and from JSON format.
- **Copy Method**: Provides a method for creating a copy of a folder object with optional modifications.

## Usage

To use the `Folder` class in your Flutter application, follow these steps:

1. Import the `Folder.dart` file into your project.
2. Create instances of the `Folder` class to represent folders in your application.
3. Utilize the provided methods for JSON serialization and copying folder objects./code> |

</details>

<details closed><summary>Colors</summary>

| File                                                                                      | Summary                         |
| ---                                                                                       | ---                             |
| [Colors.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Colors/Colors.dart) | <code>## Usage

The `Colors.dart` file provides a `AppColors` class with several color constants:

- `black0`: A dark black color.
- `black1`: A slightly lighter black color.
- `black2`: A grayish black color.
- `red`: A vibrant red color.
- `grey0`: A dark gray color.
- `grey1`: A lighter gray color.
- `grey2`: An even lighter gray color.
- `white`: A pure white color.</code> |

</details>

<details closed><summary>DB</summary>

| File                                                                                      | Summary                         |
| ---                                                                                       | ---                             |
| [folderDB.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/DB/folderDB.dart) | <code>## Description

The `FolderDB.dart` file provides a `folderDB` class, which serves as a database provider for managing folders in the application. It utilizes the `sqflite` package for SQLite database operations.

### Features

- **Database Initialization**: Initializes the SQLite database and creates the necessary tables for storing folder data.
- **CRUD Operations**: Supports create, read, update, and delete (CRUD) operations for folders.
- **Folder Size Update**: Automatically updates the size of folders based on the number of notes they contain.
- **Folder Time Update**: Updates the creation time of folders when they are modified.

## Usage

To use the `folderDB` class in your Flutter application, follow these steps:

1. Import the `FolderDB.dart` file into your project.
2. Create an instance of the `folderDB` class to access database operations.
3. Use the provided methods to interact with folders in your application.</code> |
| [notesDB.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/DB/notesDB.dart)   | <code>## Description

The `notesDB.dart` file provides a `notesDB` class, which serves as a database provider for managing notes in the application. It utilizes the `sqflite` package for SQLite database operations.

### Features

- **Database Initialization**: Initializes the SQLite database and creates the necessary tables for storing note data.
- **CRUD Operations**: Supports create, read, update, and delete (CRUD) operations for notes.
- **Folder Association**: Allows associating notes with specific folders for organization.
- **Uncategorized Notes Handling**: Provides methods for managing uncategorized notes separately.

## Usage

To use the `notesDB` class in your Flutter application, follow these steps:

1. Import the `notesDB.dart` file into your project.
2. Create an instance of the `notesDB` class to access database operations.
3. Use the provided methods to interact with notes in your application.</code> |

</details>

<details closed><summary>Main</summary>

| File                                                                                | Summary                         |
| ---                                                                                 | ---                             |
| [main.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Main/main.dart) | <code>## Description

The `main.dart` file initializes the Flutter application and sets up the initial configuration, including themes and routes.

### Features

- **Material Design Theme**: Sets up the material design theme for the application.
- **Route Configuration**: Defines routes for navigating between different pages.
- **Debug Mode Banner**: Controls the display of the debug mode banner.

## Usage

To use the `main.dart` file in your Flutter application, follow these steps:

1. Import the `main.dart` file into your project.
2. Modify the `MyApp` class and `build` method to customize the application's theme and routes.
3. Run the application using `flutter run`.</code> |

</details>

<details closed><summary>Pages</summary>

| File                                                                                                     | Summary                         |
| ---                                                                                                      | ---                             |
| [note_view.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Pages/note_view.dart)           | <code>## Description

The `note_view.dart` file provides a StatefulWidget called `note_view`, which allows users to view and edit individual notes. It provides functionalities for updating note details such as title, description, and folder. Additionally, users can share notes via the Share functionality provided by the Share plugin.

### Features

- **Note Editing**: Allows users to edit note details such as title and description.
- **Folder Selection**: Enables users to change the folder of a note.
- **Share Note**: Provides functionality to share notes via the Share plugin.

## Usage

To use the `note_view.dart` file in your Flutter application, follow these steps:

1. Import the `note_view.dart` file into your project.
2. Create an instance of the `note_view` widget and pass the necessary parameters (note, folder, isNewNote) to it.</code> |
| [folder_display.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Pages/folder_display.dart) | <code>## Description

The `folder_display.dart` file provides a StatefulWidget called `folder_display`, which displays folders along with their sizes and allows users to manage them. It also includes functionalities for adding, editing, and deleting folders.

### Features

- **Folder Display**: Displays folders with their sizes in a scrollable list.
- **Manage Mode**: Allows users to enter manage mode to edit or delete folders.
- **Add Folder Button**: Provides a button for adding new folders.
- **Edit Folder Name**: Allows users to edit folder names.
- **Delete Folder**: Allows users to delete folders along with their contents.

## Usage

To use the `folder_display.dart` file in your Flutter application, follow these steps:

1. Import the `folder_display.dart` file into your project.
2. Create an instance of the `folder_display` widget and pass the necessary parameters.
3. Utilize the folder display page in your application's navigation flow.</code> |
| [panelWidget.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Pages/panelWidget.dart)       | <code>## Description

The `panelWidget.dart` file provides a StatelessWidget called `panelWidget`, which is used to display a panel widget within a SlidingUpPanel in a Flutter application. This panel widget can be customized and extended to suit various needs, such as displaying a list of folders or any other content.

### Features

- **Customizable Design**: The panel widget can be customized with different colors, sizes, and shapes to match the application's design.
- **Flexible Height**: The height of the panel widget is flexible and can be adjusted based on the screen size or content.

## Usage

To use the `panelWidget.dart` file in your Flutter application, follow these steps:

1. Import the `panelWidget.dart` file into your project.
2. Create an instance of the `panelWidget` widget and pass the necessary parameters (e.g., `panelController`) to it.
</code> |
| [folder_view.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Pages/folder_view.dart)       | <code>## Description

The `folder_view.dart` file provides a StatefulWidget called `folder_view`, which displays folders in a staggered grid view layout. It allows users to view folders and their contents in a visually appealing manner. The file also includes functionalities for refreshing folders and adding new folders.

### Features

- **Folder Display**: Displays folders in a staggered grid view layout.
- **Refresh Folders**: Allows users to refresh the folder view to display the latest folders.
- **Add Folder Button**: Provides a button for adding new folders.

## Usage

To use the `folder_view.dart` file in your Flutter application, follow these steps:

1. Import the `folder_view.dart` file into your project.
2. Create an instance of the `folder_view` widget and include it in your application's navigation flow.
</code> |
| [note_page.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Pages/note_page.dart)           | <code>## Description

The `note_page.dart` file provides a StatefulWidget called `note_page`, which displays notes in a staggered grid view layout. It allows users to view notes and their contents in a visually appealing manner. The file also includes functionalities for refreshing notes and adding new notes.

### Features

- **Note Display**: Displays notes in a staggered grid view layout.
- **Refresh Notes**: Allows users to refresh the note view to display the latest notes.
- **Add Note Button**: Provides a button for adding new notes.

## Usage

To use the `note_page.dart` file in your Flutter application, follow these steps:

1. Import the `note_page.dart` file into your project.
2. Create an instance of the `note_page` widget and include it in your application's navigation flow.</code> |

</details>

<details closed><summary>Services</summary>

| File                                                                                                            | Summary                         |
| ---                                                                                                             | ---                             |
| [quickPageRoute.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Services/quickPageRoute.dart)     | <code>## Description

The `quickPageRoute.dart` file provides a class called `quickPageRoute`, which extends the [PageRouteBuilder] class. This custom page route builder allows for instant navigation between screens without any transition animation, making it suitable for scenarios where immediate navigation is desired.

### Features

- **Instant Navigation**: The page route builder instantly navigates to the specified screen without any transition animation.
- **Customizable**: The builder can be customized with additional parameters and options if needed.

## Usage

To use the `quickPageRoute.dart` file in your Flutter application, follow these steps:

1. Import the `quickPageRoute.dart` file into your project.
2. Create an instance of the `quickPageRoute` class and provide the child widget.
3. Use the `Navigator.of(context).push()` method to push the quick page route.</code> |
| [SlideupPageRoute.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Services/SlideupPageRoute.dart) | <code>## Description

The `SlideupPageRoute.dart` file provides a class called `SlideupPageRoute<T>`, which extends the [PageRoute] class. This custom route creates an overlay dialog with a slide-up animation effect, making it suitable for displaying modal bottom sheets or other content that needs to slide into view from the bottom of the screen. It supports features such as barrier dismissal, transition duration, maintaining state, and customizable barrier color.

### Features

- **Slide-up Animation**: The page route creates an overlay dialog with a slide-up animation effect, adding a visually appealing transition when displaying content.
- **Barrier Dismissal**: The dialog can be dismissed by tapping on the barrier outside the dialog area.
- **Transition Duration**: Customizable transition durations to control the speed of the animation when the dialog slides into view and when it slides out.
- **Maintain State**: Option to maintain the state of the dialog when navigating back and forth.
- **Custom Barrier Color**: Ability to customize the color of the barrier behind the dialog.

## Usage

To use the `SlideupPageRoute.dart` file in your Flutter application, follow these steps:

1. Import the `SlideupPageRoute.dart` file into your project.
2. Create an instance of the `SlideupPageRoute<T>` class and provide a `builder` function to build the content of the dialog.
3. Use the `Navigator` class to push the page route onto the navigation stack.</code> |
| [customPageRoute.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Services/customPageRoute.dart)   | <code>## Description

The `customPageRoute.dart` file provides a class called `customPageRoute`, which extends the [PageRouteBuilder] class. This custom page route allows for creating custom page transitions with a specified duration and animation.

### Features

- **Custom Page Transition**: The page route provides a slide transition effect from right to left when navigating to a new page.
- **Transition Duration**: Customizable transition durations to control the speed of the animation.
- **Barriers Dismissible**: Option to dismiss the page route by tapping on the barrier outside the page area.

## Usage

To use the `customPageRoute.dart` file in your Flutter application, follow these steps:

1. Import the `customPageRoute.dart` file into your project.
2. Create an instance of the `customPageRoute` class and provide the child widget to be displayed.
3. Use the `Navigator` class to push the custom page route onto the navigation stack.</code> |
| [customRectTween.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Services/customRectTween.dart)   | <code>## Description

The `customRectTween.dart` file provides a class called `CustomRectTween`, which extends the [RectTween] class. This custom rectangle tween applies a [Curves.easeOut] curve to the transition, resulting in a smoother animation.

### Features

- **Linear Transition**: The rectangle tween provides a linear transition effect with an ease-out curve.
- **Customizable Curves**: The tween applies the ease-out curve to control the animation's speed and acceleration.

## Usage

To use the `customRectTween.dart` file in your Flutter application, follow these steps:

1. Import the `customRectTween.dart` file into your project.
2. Create an instance of the `CustomRectTween` class and provide the begin and end rectangles.
3. Use the `lerp` method to interpolate the rectangle at a specific fraction along the curve.E</code> |
| [HeroDialogRoute.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Services/HeroDialogRoute.dart)   | <code>## Description

The `HeroDialogueRoute.dart` file provides a class called `HeroDialogRoute<T>`, which extends the [PageRoute] class. This custom route creates an overlay dialog with a popup effect, making it suitable for displaying dialogs or popup windows in Flutter applications. It supports features such as barrier dismissal, transition duration, maintaining state, and customizable barrier color.

### Features

- **Popup Effect**: The dialog route creates an overlay dialog with a popup effect, adding a visually appealing transition when displaying dialogs.
- **Barrier Dismissal**: The dialog can be dismissed by tapping on the barrier outside the dialog area.
- **Transition Duration**: Customizable transition duration to control the speed of the dialog animation.
- **Maintain State**: Option to maintain the state of the dialog when navigating back and forth.
- **Custom Barrier Color**: Ability to customize the color of the barrier behind the dialog.

## Usage

To use the `HeroDialogueRoute.dart` file in your Flutter application, follow these steps:

1. Import the `HeroDialogueRoute.dart` file into your project.
2. Create an instance of the `HeroDialogRoute<T>` class and provide a `builder` function to build the content of the dialog.
3. Use the `Navigator` class to push the dialog route onto the navigation stack.</code> |

</details>

<details closed><summary>Widgets</summary>

| File                                                                                                         | Summary                         |
| ---                                                                                                          | ---                             |
| [editFolderName.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Widgets/editFolderName.dart)   | <code>## Description

The `editFolderName.dart` file provides an `editFolderName` class, which is a stateful widget representing the edit folder name screen. This screen allows users to change the name of a folder.

### Features

- **Edit Folder Name Screen**: Displays a form for editing the name of a folder.
- **Validation**: Validates the folder name and ensures it is not empty or already exists.
- **Database Interaction**: Updates the folder name in the database upon submission.
- **Custom Page Route**: Uses standard `Navigator.of(context).pop()` to close the screen after editing.

## Usage

To use the `editFolderName.dart` file in your Flutter application, follow these steps:

1. Import the `editFolderName.dart` file into your project.
2. Use the `editFolderName` widget in your navigation stack to allow users to edit folder names.</code> |
| [smallNote.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Widgets/smallNote.dart)             | <code>## Description

The `smallNote.dart` file provides a widget called `smallNote`, which represents a small note with a title and description. It allows users to tap on the note to view its details and provides a delete option through a popup menu button.

### Features

- **Small Note Display**: Displays the title and description of a note.
- **Interaction**: Allows tapping on the note to view its details.
- **Delete Option**: Provides a delete option through a popup menu button.

## Usage

To use the `smallNote.dart` file in your Flutter application, follow these steps:

1. Import the `smallNote.dart` file into your project.
2. Use the `smallNote` widget to display small notes in your UI.</code> |
| [folderCard.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Widgets/folderCard.dart)           | <code>## Description

The `folderCard.dart` file provides two widgets:
1. **folderCard**: Represents a card displaying folder information, including name, creation date, and note count.
2. **folderOptions**: Displays options for interacting with the folder, such as deleting it.

### Features

- **Folder Card**: Displays folder name, creation date, and note count.
- **Interaction**: Allows tapping on the folder card to perform actions.
- **Options**: Provides options for deleting the folder.

## Usage

To use the `folderCard.dart` file in your Flutter application, follow these steps:

1. Import the `folderCard.dart` file into your project.
2. Use the `folderCard` widget to display folder information in your UI.
3. Optionally, use the `folderOptions` widget to provide interaction options for the folder.</code> |
| [addNoteButton.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Widgets/addNoteButton.dart)     | <code>## Description

The `addNoteButton.dart` file provides a `addNoteButton` class, which is a stateless widget representing the add note button. This button allows users to create a new note within a specified folder.

### Features

- **Add Note Button**: Displays an icon button for adding notes.
- **Navigate to Note View**: Opens the note view page when tapped, allowing users to create a new note.
- **Custom Page Route**: Uses a custom page route (`customPageRoute`) for navigating to the note view page.

## Usage

To use the `addNoteButton.dart` file in your Flutter application, follow these steps:

1. Import the `addNoteButton.dart` file into your project.
2. Add the `addNoteButton` widget to your UI where you want the add note button to appear.
3. Pass the required folder to the `addNoteButton` widget.
4. Customize the appearance of the button as needed.</code> |
| [longNote.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Widgets/longNote.dart)               | <code>## Description

The `longNote.dart` file provides a widget called `longNote`, which represents a long note with a title and description. It allows users to tap on the note to view its details and provides a delete option through a popup menu button.

### Features

- **Long Note Display**: Displays the title and description of a note.
- **Interaction**: Allows tapping on the note to view its details.
- **Delete Option**: Provides a delete option through a popup menu button.

## Usage

To use the `longNote.dart` file in your Flutter application, follow these steps:

1. Import the `longNote.dart` file into your project.
2. Use the `longNote` widget to display long notes in your UI.</code> |
| [wideNote.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Widgets/wideNote.dart)               | <code>## Description

The `wideNote.dart` file provides a widget called `wideNote`, which represents a wide note with a title and description. It allows users to tap on the note to view its details and provides a delete option through a popup menu button.

### Features

- **Wide Note Display**: Displays the title and description of a note.
- **Interaction**: Allows tapping on the note to view its details.
- **Delete Option**: Provides a delete option through a popup menu button.

## Usage

To use the `wideNote.dart` file in your Flutter application, follow these steps:

1. Import the `wideNote.dart` file into your project.
2. Use the `wideNote` widget to display wide notes in your UI.</code> |
| [addFolderButton.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Widgets/addFolderButton.dart) | <code>## Description

The `addFolderButton.dart` file provides two classes:
1. `addFolderButton`: A stateful widget representing the add folder button.
2. `addFolder`: A stateful widget representing the dialog for adding a new folder.

The `addFolderButton` widget displays an icon button that, when tapped, opens a dialog for creating a new folder. The `addFolder` dialog allows users to input a folder name and create a new folder.

### Features

- **Add Folder Button**: Displays an icon button for adding folders.
- **Dialog for Adding Folders**: Opens a dialog for creating a new folder with a name input field.
- **Validation**: Validates the folder name input to ensure uniqueness and non-emptiness.
- **Create Folder**: Creates a new folder when the user inputs a valid folder name and taps the "Create" button.

## Usage

To use the `addFolderButton.dart` file in your Flutter application, follow these steps:

1. Import the `addFolderButton.dart` file into your project.
2. Add the `addFolderButton` widget to your UI where you want the add folder button to appear.
3. Customize the appearance of the button as needed.
4. Implement the logic to handle folder creation in the `addFolder` dialog.</code> |

</details>

---

##  Getting Started

**System Requirements:**

* **Dart**: `version x.y.z`

###  Installation

<h4>From <code>source</code></h4>

> 1. Clone the Dark-Diary repository:
>
> ```console
> $ git clone https://github.com/Iloke-Alusala/Dark-Diary
> ```
>
> 2. Change to the project directory:
> ```console
> $ cd Dark-Diary
> ```
>
> 3. Install the dependencies:
> ```console
> $ pub get
> ```

###  Usage

<h4>From <code>source</code></h4>

> Run Dark-Diary using the command below:
> ```console
> $ dart main.dart
> ```

###  Tests

> Run the test suite using the command below:
> ```console
> $ dart test
> ```

---

##  Project Roadmap

- [X] `► INSERT-TASK-1`
- [ ] `► INSERT-TASK-2`
- [ ] `► ...`

---

##  Contributing

Contributions are welcome! Here are several ways you can contribute:

- **[Report Issues](https://github.com/Iloke-Alusala/Dark-Diary/issues)**: Submit bugs found or log feature requests for the `Dark-Diary` project.
- **[Submit Pull Requests](https://github.com/Iloke-Alusala/Dark-Diary/blob/main/CONTRIBUTING.md)**: Review open PRs, and submit your own PRs.
- **[Join the Discussions](https://github.com/Iloke-Alusala/Dark-Diary/discussions)**: Share your insights, provide feedback, or ask questions.

<details closed>
<summary>Contributing Guidelines</summary>

1. **Fork the Repository**: Start by forking the project repository to your github account.
2. **Clone Locally**: Clone the forked repository to your local machine using a git client.
   ```sh
   git clone https://github.com/Iloke-Alusala/Dark-Diary
   ```
3. **Create a New Branch**: Always work on a new branch, giving it a descriptive name.
   ```sh
   git checkout -b new-feature-x
   ```
4. **Make Your Changes**: Develop and test your changes locally.
5. **Commit Your Changes**: Commit with a clear message describing your updates.
   ```sh
   git commit -m 'Implemented new feature x.'
   ```
6. **Push to github**: Push the changes to your forked repository.
   ```sh
   git push origin new-feature-x
   ```
7. **Submit a Pull Request**: Create a PR against the original project repository. Clearly describe the changes and their motivations.
8. **Review**: Once your PR is reviewed and approved, it will be merged into the main branch. Congratulations on your contribution!
</details>

<details closed>
<summary>Contributor Graph</summary>
<br>
<p align="center">
   <a href="https://github.com{/Iloke-Alusala/Dark-Diary/}graphs/contributors">
      <img src="https://contrib.rocks/image?repo=Iloke-Alusala/Dark-Diary">
   </a>
</p>
</details>

---

##  License

This project is protected under the [SELECT-A-LICENSE](https://choosealicense.com/licenses) License. For more details, refer to the [LICENSE](https://choosealicense.com/licenses/) file.

---

##  Acknowledgments

- List any resources, contributors, inspiration, etc. here.

[**Return**](#-overview)

---

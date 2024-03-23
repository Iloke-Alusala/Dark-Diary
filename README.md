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

<code>► INSERT-TEXT-HERE</code>

---

##  Features

<code>► INSERT-TEXT-HERE</code>

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
| [pubspec.yaml](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/pubspec.yaml) | <code>► INSERT-TEXT-HERE</code> |

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
| [editFolderName.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Widgets/editFolderName.dart)   | <code>► INSERT-TEXT-HERE</code> |
| [smallNote.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Widgets/smallNote.dart)             | <code>► INSERT-TEXT-HERE</code> |
| [folderCard.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Widgets/folderCard.dart)           | <code>► INSERT-TEXT-HERE</code> |
| [addNoteButton.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Widgets/addNoteButton.dart)     | <code>► INSERT-TEXT-HERE</code> |
| [longNote.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Widgets/longNote.dart)               | <code>► INSERT-TEXT-HERE</code> |
| [wideNote.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Widgets/wideNote.dart)               | <code>► INSERT-TEXT-HERE</code> |
| [addFolderButton.dart](https://github.com/Iloke-Alusala/Dark-Diary/blob/master/Widgets/addFolderButton.dart) | <code>► INSERT-TEXT-HERE</code> |

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

## Translation

### Description
This Flutter project includes an extension for the `Map` class called `translateJson`, which allows you to translate an entire JSON object using a machine learning model. The extension accepts a language name as a parameter in the form of a string.

### Prerequisites
To use the `translateJson` extension, you will need to install the `google-mlkit-translation` package. Make sure to include it in your project dependencies.

### Usage
1. Import the necessary dependencies and the `translateJson` extension:
    ```dart
    google_mlkit_translation:;
    ```

2. Use the `translateJson` extension on a `Map` object:
    ```dart
    Map<String, dynamic> json = // Your JSON object here;
    String language = // Target language name;

    Map<String, dynamic> translatedJson = json.translateJson(translateLanguage: language);
    ```


## Session Tracker of Form

### Description
Inside the "session_tracker" folder, you will find a widget called `FocusWrapper`. This widget acts as a wrapper for another widget and emits a callback function named `sessionDuration`. The `sessionDuration` callback provides the duration after focus is lost from the wrapped widget.

### Usage
1. Locate the `FocusWrapper` widget in your Flutter project:
    ```dart
    import 'package:../focus_wraper.dart';
    ```

2. Wrap the desired widget with the `FocusWrapper` widget and handle the `sessionDuration` callback:
    ```dart
    FocusWrapper(
      child: // Your widget here,
      sessionDuration: (Duration duration) {
        // Handle the session duration here.
      },
    );
    ```

Make sure to adapt the code to your specific use case and modify it as needed.

Feel free to explore the project further and make any necessary adjustments or improvements.

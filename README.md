# popular_disney

This is a README file for the Popular Disney App. It provides information on the architecture, how to install the project, and the current state of the UI, error handling, accessibility, and localization.

## Architecture

The project uses the MVVM (Model-View-ViewModel) architecture pattern with Tuist as the project generation tool. MVVM helps separate the user interface logic from the business logic and makes it easier to maintain the codebase. Tuist simplifies project generation, making it easier to manage dependencies, generate the project, and integrate with continuous integration and deployment.

Information on how to install Tuist can be found here:
https://docs.tuist.io/tutorial/get-started

## How to install the project

To install the project, follow these steps:

- Clone the repository to your local machine.
- Open Terminal and navigate to the project directory.
- Run the following commands in the Terminal:

```
tuist fetch
tuist generate
```
This will fetch the dependencies and generate the project.

### NOTE
### To build or run this project, Tuist installation is necessary.

### Testing
#### UI Tests
The project currently only houses Unit tests. Given more time UITests would have been added.
#### Unit Tests
- Cache
  The cache could be mocked to prevent writing to the disk. In its current state it could result in flakey tests.
- HomeDataProvider
  Given more time the HomeDataProvider should include cache tests. This task is dependent on the MockCache menioned above
- CharactersResponse
  Tests should be added to check for edge cases such as invalid URLS
- CharactersRequest
  To include tests to ensure the method, path and response are correctly set
  
### Previews
Inject usable data in the MockURLSession (Home)

### UI

The user interface of the project is very basic and is only there to fulfill the project requirements. There is room for improvement in terms of design and usability.

### Error Handling

The project currently does not handle errors or retries. Adding error handling would improve the user experience and make the app more robust.

### Accessibility

The project currently does not support accessibility. Adding accessibility features would make the app more inclusive and usable for a wider range of users.

### Localization

The project currently does not support localization. Adding localization would make the app accessible to users in different regions and languages.

### Other Improvements
The list view should support pagination.
Analytics
Crashlytics

### Conclusion

This README provides an overview of the popular disney project. It covers the architecture, how to install the project, and the current state of the UI, error handling, accessibility, localization & testing. There is room for improvement in these areas and i would workd on this in the following priority:-

1. Unit Tests
2. UI Tests
3. Error Handling
4. Accessibility
5. Localization


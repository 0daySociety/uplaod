
Getting Started
1. Clone the Repository
First, clone the repository to your local machine:

bash
Copy code
git clone https://github.com/your-username/flutter-file-upload.git
cd flutter-file-upload
2. Install Dependencies
Before running the project, you need to install the necessary Flutter packages. Run the following command in the terminal:

bash
Copy code
flutter pub get
This will fetch all the required dependencies specified in the pubspec.yaml file.

3. Run the Project
To run the Flutter project on the web (e.g., in Chrome), use the following command:

bash
Copy code
flutter run -d chrome -v
-d chrome: Specifies that the project should run on Chrome.
-v: Provides verbose logging output in the terminal.
4. View Output
Once the app is running, you can click the "Upload File" button to select files from your local system. The metadata for each selected file (including file name, type, size, and bytes) will be printed in the terminal.

5. Adding More Metadata
The current implementation extracts and prints the following metadata for each selected file:

File Name: The name of the selected file.
File Type: The MIME type of the file.
File Size: The size of the file in bytes.
File Bytes: The actual byte content of the file (printed as a byte array).
If you need to extract more metadata, you can extend the _uploadDocument function in uploadPage.dart by utilizing additional properties provided by the FilePickerResult class or by integrating additional libraries.



Troubleshooting
File Picking Issues: If the file picker does not open or files are not being uploaded, make sure the Flutter SDK is up to date, and that you have the necessary permissions set up on your machine.

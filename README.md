# Notes App  

A feature-rich Notes app built with Flutter. The app allows users to create, read, update, and delete (CRUD) notes using both text and voice input. The app supports Arabic and English languages, and it provides a dynamic experience where speech input is localized based on the language, with text direction and fonts adjusted accordingly.

The app uses Provider for state management, Hive for local storage, and the speech_to_text plugin for converting speech to text. It also features localization for Arabic speakers with right-to-left text direction and special fonts for Arabic text.

---

## Features  

- Create Notes: Add notes using text or voice input with the help of the speech_to_text plugin. Voice input is localized for both Arabic and English.

- Manage Notes: Update and delete notes effortlessly.

- Local Storage: All notes are securely stored locally using Hive for fast, offline access.

- Offline Access: Access notes anytime, without the need for internet connectivity.

- Localization: The app supports Arabic and English with language-specific text direction (RTL for Arabic) and styling (Arabic-specific fonts).

- Dynamic Speech Input: Arabic and English speech-to-text functionality with language-based styling applied to recognized text

---

## Tech Stack  

- Flutter: Framework for building the app.

- Dart: Programming language used.

- Provider: State management solution for reactive UI.

- Hive: Lightweight and fast NoSQL database for local storage.

- speech_to_text: Plugin to enable voice-to-text functionality.

- Localization: Supports Arabic and English languages with language-specific UI adjustments. 

---

## video Demo 



https://github.com/user-attachments/assets/34cbd952-5193-41ab-9a11-cd354c28b037



## Installation  

1. Clone the repository:  
  
   git clone https://github.com/Alimortada22/Notes_App.git  
   
 

2. Navigate to the project directory:  
  
   cd notes-app  
   
 

3. Install dependencies:  
  
   flutter pub get  
   
 

4. Run the app:  
  
   flutter run  
   

# 🌟 Flutter Internship Management App

A beautiful and modern Flutter application designed to manage internship programs, profiles, and progress tracking.

---

## 🚀 Features
- 🔐 **User Login & Signup** (with Firebase Authentication)
- 📚 **Internship Programs List** (connected with mock JSON API)
- 👤 **Interactive Profile Page**
- 📝 **Form Validation** (email & password validation on Signup/Login)
- ⚙️ **Error Handling & Loading Indicators**
- 📈 **Progress Tracking**
- 🎨 **Gradient AppBars and Smooth UI**

---

## 🆕 Week 3 Updates

### 🔗 API Integration
- Connected **Program Listing Screen** and **Home Screen** to mock JSON data.
- Replaced hardcoded program data with **dynamic API-fetched content**.

### 🔐 Firebase Authentication
- Integrated Firebase Email/Password Authentication.
- Implemented **Signup** and **Login** with real-time validation.
- Added input validation for email format and password strength.

### 🧾 Form Validation & Feedback
- Enhanced Signup & Login forms with validators.
- Added proper error messages for invalid credentials.
- Loading indicators show during sign-in/sign-up for better UX.

### 💾 GitHub Repository Updates
- Code pushed with clear commit messages:
    - `Added API integration for Program Listing`
    - `Connected Firebase Authentication`
    - `Added Signup & Login form validation`
- Updated README file to reflect Week 3 progress.

---

## 📘 Changelog Summary

| Feature | Description |
|----------|--------------|
| Program Listing | Now fetches live data from mock JSON API |
| Home Screen | Displays dynamic program info |
| Firebase Auth | Added email/password authentication |
| Forms | Validation added for email and password |
| UI/UX | Improved loading & error handling |

---

## 📱 Screenshots

| Login Screen | Programs Screen |
|---------------|----------------|
| <img src="assets/Screenshots/Login.jpeg" width="250"> | <img src="assets/Screenshots/home.jpeg" width="250"> |

| Profile Screen | Program Details Screen |
|----------------|------------------------|
| <img src="assets/Screenshots/profile.jpeg" width="250"> | <img src="assets/Screenshots/details.jpeg" width="250"> |

---

## 🛠 Tech Stack
- Flutter (Dart)
- Firebase Authentication
- Mock JSON / API
- Material Design
- Responsive UI

---

## 💻 Setup
```bash
git clone https://github.com/hammad89170/Edutrack.git
cd Edutrack
flutter pub get
flutter run

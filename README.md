# 🔥 Hot Note

Hot Note is a Flutter ToDo app built with **Clean Architecture**, which allows users to:
- Create notes
- Store them locally using Hive
- Upload them to Firebase Firestore **with a delayed background queue**
- Manage sync status (`Queued` → `Uploaded`)
- Login via Firebase Auth

---

## 📱 Features

- ✅ Firebase Email/Password Login
- ✅ Add Note with Title & Description
- ✅ Notes saved locally first (Hive)
- ✅ Automatically uploaded to Firestore after 5 seconds
- ✅ Queue retry logic if upload fails
- ✅ Status indicators (Queued / Uploaded)
- ✅ State management using `flutter_bloc`
- ✅ Routing via `go_router`
- ✅ Clean code structure with separation of concerns

---

## 🧠 Architecture (Clean Architecture)
lib/    
│   
├── bloc/ → Business logic (BLoC)   
│ ├── auth/     
│ └── home/     
│   
├── core/ → Theme, constants, routes    
│   
├── data/   
│ ├── models/ → Note model  
│ └── services/ → Firebase, Hive, Queue logic       
│   
└── main.dart → App initialization


---

## 🔁 Queue Logic Explained

> Notes are first stored locally and then pushed to Firestore using a custom in-memory queue.

- Notes are marked `isUploaded = false` initially
- A Dart `Timer.periodic()` checks the queue every 5 seconds
- If internet is available and user is logged in, notes are pushed to Firestore
- After upload, `isUploaded` is marked `true` locally
- BLoC is triggered to refresh UI (`GetNotesEvent`)

---

## 🔐 Authentication

- Firebase Auth Email/Password Login
- Logged-in user’s email is shown in Dashboard
- Notes are synced user-wise (based on UID/email)

---

## 🧪 Tech Stack

| Technology        | Purpose                         |
|------------------|----------------------------------|
| Flutter 3.x       | App Development                 |
| Firebase Auth     | User Login                      |
| Cloud Firestore   | Remote Note Storage             |
| Hive              | Local Note Storage              |
| flutter_bloc      | State Management                |
| go_router         | Navigation                      |

---

## 🖼️ Screenshots


![single photo](https://github.com/user-attachments/assets/c39a97ef-6127-4283-bb8e-b281230f71d8)

https://github.com/user-attachments/assets/509493f1-9221-421f-bb99-8c002d2620e7

---
## 📲 Download App (APK)

> Click below to download the Android APK and try the app:

**[⬇️ Download Hot Note APK](https://docs.google.com/uc?export=download&id=1x15Yp5gNNEjV51C37MgppF9dBPO3Ufsy)**

# 🏠 Housify - Home Service App  

### 📱 Overview  
**Housify** is a modern Flutter application designed to provide all home-related services in one place — from packing and moving to expert home assistance.  
It features a clean and responsive UI, smooth navigation, and API integration for real-time data handling.  

---

## 🚀 Features  
✅ **Onboarding Screens** – Interactive introduction screens with smooth transitions.  
✅ **HTTP API Integration** – Fetch and send data using the `http` package.  
✅ **State Management** – Managed app state efficiently using `Provider` / `Bloc`.  
✅ **Navigation** – Implemented structured routing between screens.  
✅ **Responsive UI** – Works seamlessly across all devices and screen sizes.  
✅ **Animations & Indicators** – Smooth onboarding indicators and button animations.  
✅ **Skip & Next Flow** – Users can skip or go step-by-step during onboarding.  

---

## 🧱 Tech Stack  
- **Framework:** Flutter  
- **Language:** Dart  
- **API Handling:** HTTP package  
- **State Management:** Provider / Bloc  
- **Navigation:** Flutter Navigator / GoRouter  
- **UI Design:** Figma + Custom Widgets  
- **Responsive Design:** MediaQuery & LayoutBuilder  

---

## 📸 Screenshots  
| Onboarding 1 | Onboarding 2 | Onboarding 3 |
|:-------------:|:-------------:|:-------------:|
| ![Screen1](<img width="750" height="1624" alt="image" src="https://github.com/user-attachments/assets/56e5cccf-6497-40f2-b76d-a7b0cd96c4f3" />| ![Screen2](<img width="750" height="1624" alt="image" src="https://github.com/user-attachments/assets/11f22978-3c9e-4103-a02e-ca65cd6f1c87" /> | ![Screen3](<img width="750" height="1624" alt="image" src="https://github.com/user-attachments/assets/1b12a33a-ac57-4063-9fda-120e8469e07a" />
) |

---

## ⚙️ Installation  
1. Clone this repository  
   ```bash
   git clone https://github.com/yourusername/housify.git
   ```
2. Navigate to the project directory  
   ```bash
   cd housify
   ```
3. Install dependencies  
   ```bash
   flutter pub get
   ```
4. Run the application  
   ```bash
   flutter run
   ```

---

## 📡 API Integration  
- Used `http` package for API communication.  
- Example:
   ```dart
   final response = await http.get(Uri.parse('https://api.example.com/services'));
   if (response.statusCode == 200) {
     final data = jsonDecode(response.body);
     print(data);
   }
   ```



## 🌐 Responsive Design  
- Implemented using:
   ```dart
   MediaQuery.of(context).size.width
   LayoutBuilder(builder: (context, constraints) => ...)
   ```
- Works on **Mobile**, **Tablet**, and **Web**.

---

## 🤝 Contributing  
Contributions are welcome!  
1. Fork the repo  
2. Create a new branch  
3. Commit your changes  
4. Push and create a Pull Request  

---

## 📩 Contact  
👨‍💻 **Developer:** Akhand Singh  
📧 **Email:** akhandsingh0707@gmail.com  
🌐 **GitHub:** [yourusername](https://github.com/yourusername)
[README.md](https://github.com/user-attachments/files/22776077/README.md)
.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

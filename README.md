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
| ![Screen1](6e9b5606-8ce5-43df-b306-a50f6eac7fdf.png) | ![Screen2](dddf5817-88bb-4971-9ba7-7a04517be601.png) | ![Screen3](087278a8-ae85-4b61-9134-db13cbc547e1.png) |

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

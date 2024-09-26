
# Emart - Ecommerce Mobile Application

**Emart** is a comprehensive ecommerce mobile application designed to simplify the shopping experience. It allows users to easily browse and purchase a wide range of products, including men’s clothing, women’s dresses, kids’ toys, jewelry, cellphones, furniture, laptops, sports equipment, and more.

The app is built with **Flutter** for the frontend, utilizing **Firebase REST APIs** for backend operations, and employs **VelocityX** to keep the code clean, modular, and concise.

## Features

- **Product Categories**: Shop across categories such as men's and women's clothing, kids' toys, electronics, furniture, and more.
- **Firebase Integration**: Secure backend integration using Firebase for real-time database and authentication.
- **REST API Integration**: Efficient interaction with Firebase APIs for product management and user activities.
- **Smooth User Experience**: A fast, responsive UI built with Flutter.
- **VelocityX**: Used for a concise and modular codebase, ensuring maintainability and readability.

## Technologies Used

- **Flutter**: Cross-platform mobile app development framework.
- **Dart**: Programming language for Flutter.
- **Firebase REST APIs**: Backend services for authentication and real-time database.
- **VelocityX**: Utility package for fast and clean UI development.

## Getting Started

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/emart-ecommerce.git
   cd emart-ecommerce
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Set up Firebase**:
   - Follow the Firebase setup guide for Android and iOS.
   - Add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) to your project.

4. **Run the app**:
   ```bash
   flutter run
   ```

## Code Structure

- **lib/controllers/**: Contains GetX controllers for managing product, cart, and user states.
- **lib/screens/**: UI for browsing products, viewing categories, and checkout.
- **lib/services/**: Handles API requests and interactions with Firebase.
- **lib/models/**: Data models for product and user information.
  
## Key Components

- **Product Browsing**: Allows users to browse through a wide variety of product categories.
- **Cart Management**: Users can add products to their cart and proceed to checkout.
- **User Authentication**: Secure login and registration using Firebase authentication.
- **Responsive Design**: Optimized for different screen sizes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

For any questions or issues, feel free to reach out at [arbabhussain414@gmail.com](arbabhussain414@gmail.com).

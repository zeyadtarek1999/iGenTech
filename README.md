# iGenTech
iGenTech App
Overview
The iGenTech app is a fully-featured mobile application designed with a clean and modern UI, aligning with the iGenTech brand colors and design guidelines. It offers a smooth user experience with essential features such as user authentication, location-based services, and secure data handling. The app focuses on both functionality and security, ensuring that users can interact with it confidently and seamlessly.

Features
1. Figma Design
   The app's design was created using Figma, adhering to the iGenTech logo colors and overall brand aesthetic. The user interface is clean and intuitive, ensuring a positive user experience.

2. Splash Screen & Onboarding
   Upon launching the app, users are greeted with a branded splash screen followed by an onboarding experience that introduces the mission, vision, and who we are sections of iGenTech. This allows users to understand the company's core values before diving into the app.

3. Sign-In & Sign-Up
   The app features both sign-in and sign-up screens with advanced functionality:

Custom Dropdown: For fields like gender selection.
Custom Date Picker: For date of birth input.
Email Check: Validates if the email has already been used for registration.
Password Validation: Enforces specific password requirements and includes a confirm password field for enhanced security.
Biometric Authentication: Users can opt to authenticate using their device's biometric features (such as fingerprint or face ID) during sign-in or registration, ensuring a faster and secure login process.
Encrypted Data: All sensitive user data is encrypted using flutter_secure_storage, ensuring the highest level of security for stored information.
4. Profile Screen
   After logging in or registering, users are navigated to their profile screen. The profile screen includes:

Location Services: The app captures the user's location upon registration and displays the location in the profile. Users can view their location on a map.
Code Section: A section in the profile provides links to the app's Figma design and GitHub repository, giving users or developers easy access to these resources.
Special Thanks: A custom popup with a "Special Thanks" message, acknowledging contributions or collaborators.
5. Secure Storage & Biometric Authentication
   Security is at the heart of the app:

Secure Storage: User data is stored securely using encrypted storage to protect against unauthorized access.
Biometric Authentication: For added security, users can authenticate with their fingerprint or face ID after signing in or registering, providing an extra layer of protection for sensitive data.
6. Location-Based Services
   When users register, the app requests location permission and retrieves their current location. This data is stored securely and can be displayed on the profile screen via an interactive map.

## Generating assets / fonts 
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Generating language keys
```bash
flutter pub run easy_localization:generate -S assets/languages -f keys -o locale_keys.g.dart      
```



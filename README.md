# ReWear ♻️

ReWear is a sustainable fashion exchange platform built using **Flutter** and **Firebase**, where users can list, browse, and swap second-hand clothes. The app encourages eco-conscious shopping through a point-based reward system.

## 🌟 Features

- 🔐 **Authentication**

  - Email/password login & registration
  - Google Sign-In via Firebase Auth

- 🧑‍💼 **User Profiles**

  - Profile section with tabs: My Closet, Activity, Requests, Reviews
  - User stats, achievements, and eco points wallet

- 🛍️ **Product Listings**

  - Add/view clothing items
  - Tag-based filtering (e.g., "Like New", "Vintage")
  - Staggered GridView for dynamic UI
  - Like system for items

- 💰 **Wallet System**

  - Earn and spend "eco points"
  - Each item has a points value
  - Future support for transactions & swaps

- 🧭 **Routing**

  - GoRouter integration with route guards
  - Protected routes for authenticated users
  - Redirects based on login state

- 🔥 **Firebase Integration**
  - Firebase Authentication
  - Firestore for product and user data
  - Firebase Storage for images (planned)

## 🧱 Tech Stack

| Layer            | Technology                            |
| ---------------- | ------------------------------------- |
| **Frontend**     | Flutter                               |
| **State Mgmt**   | Getx                                  |
| **Routing**      | GoRouter                              |
| **Backend**      | Firebase (Firestore, Auth, Storage)   |
| **Auth**         | Firebase Auth (Email & Google)        |
| **UI Styling**   | Custom widgets with responsive design |
| **Image Upload** | Firebase Storage (planned)            |

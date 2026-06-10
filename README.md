# 📱 QuickSlot Flutter App

A **production-ready Flutter application** for booking sports venue slots in real-time.  
Built to work with a concurrency-safe backend ensuring **no double booking**.

---

## 🚀 Features

- 🏟️ Browse venues
- 📅 Select date & view slots
- 🟢 Real-time slot availability (auto refresh)
- ⚡ Book slot instantly
- ❌ Graceful failure if slot already booked
- 📖 View "My Bookings"
- 🗑️ Cancel bookings
- 🔄 Live updates using polling

---

## 🧠 Tech Stack

| Layer        | Technology |
|-------------|------------|
| Framework   | Flutter |
| State Mgmt  | Basic Stateful Widgets (can be upgraded to Riverpod) |
| Networking  | Dio |
| Backend API | Django REST API (Render) |

---

## 📱 App Flow

``` id="8mxu9s"
User → Venue List → Slot Screen → Book → Success/Fail → My Bookings → Cancel
```

---

## 🔌 API Integration

Base URL:

``` id="6yk7mp"
https://quickslot-backend-vyk1.onrender.com/api
```

---

### 🏟️ Get Venues
```http id="7q2y9x"
GET /venues/
```

---

### 📅 Get Slots
```http id="1u8o6p"
GET /venues/{id}/slots/?date=YYYY-MM-DD
```

---

### 🎟️ Book Slot
```http id="v9c6m1"
POST /bookings/
```

Body:
```json id="0g6qlg"
{
  "slot_id": 1
}
```

---

### 👤 My Bookings
```http id="8w63sn"
GET /users/{id}/bookings/
```

---

### ❌ Cancel Booking
```http id="4r7n5t"
DELETE /bookings/{id}/
```

---

## ⚠️ Key Feature: Concurrency Handling

If two users try to book the same slot:

- ✅ One succeeds  
- ❌ One gets failure message  
- 🔄 UI refreshes automatically  

---

## 🛠️ Setup (Local)

### 1. Clone repo
```bash id="s3m0kn"
git clone <repo-url>
cd quickslot_app
```

---

### 2. Install dependencies
```bash id="x4mp7v"
flutter pub get
```

---

### 3. Run app
```bash id="cnr6zq"
flutter run
```

---

## 🌐 Backend Configuration

Update API base URL in:

```dart id="zlgq5g"
lib/core/api_client.dart
```

```dart id="qgq7c9"
baseUrl: "https://quickslot-backend-vyk1.onrender.com/api"
```

---

## ⚠️ Notes

- Render free tier may cause **cold start delays (~30 sec)**
- Uses polling every 5 seconds for real-time updates
- Requires internet connection

---

## 🧪 Testing

To test concurrency:

1. Open app on 2 devices  
2. Select same slot  
3. Tap "Book" simultaneously  

👉 Expected:
- One success  
- One failure message  

---

## 📈 Future Improvements

- 🔄 WebSocket-based real-time updates
- 🎨 Modern UI (Material 3)
- 🌙 Dark mode support
- 📦 Offline caching
- 🔐 Authentication system

---

## 🤖 AI Usage Note

AI tools were used for:
- UI scaffolding
- API integration
- Debugging

Manual improvements:
- UX flow design
- Concurrency handling UI
- Error handling logic

---

## 🏆 Hackathon Focus

This app prioritizes:
- Real-world API integration  
- Clean user flow  
- Handling edge cases (race conditions)  

---

## 👨‍💻 Author

Chetan Singh Rajput

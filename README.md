# 📚 Edu Care — Course Learning App (Flutter)

Ứng dụng học tập offline-first xây dựng bằng Flutter, sử dụng **BLoC** cho state management và **Isar** làm local database. Không phụ thuộc backend — toàn bộ dữ liệu được mock và lưu trữ cục bộ.

---

## ✨ Tính năng chính

- **20 khóa học**, mỗi khóa 100–200 bài học (~3.000 bài học tổng cộng)
- Bài học đa định dạng: **Video, Audio, PDF, Hình ảnh, Quiz**
- Xem video/audio và **tự động lưu vị trí xem**, khôi phục chính xác khi mở lại
- Quản lý `VideoPlayerController` theo cơ chế **LRU Pool** — không tăng RAM khi chuyển nhiều video liên tục
- Danh sách bài học **phân trang**, scroll mượt, không rebuild dư thừa dù có hàng nghìn item
- **Tìm kiếm realtime** trên toàn bộ dữ liệu, debounce + không giật UI
- **Quiz 750 câu** (5 ngân hàng đề, random mỗi lượt), hỗ trợ ảnh/audio trong câu hỏi, chuyển câu tức thì, chấm điểm cuối bài
- Toàn bộ tác vụ nặng (seed dữ liệu, parse JSON) chạy qua **isolate**, không block UI
- Tự động **pause video/audio khi app vào background**, khôi phục đúng trạng thái khi quay lại
- Audio hỗ trợ phát nền với **notification media control** (`audio_service`)
- Lưu **lịch sử xem, bookmark, đáp án quiz** vào local database (Isar)

---

## 🛠 Tech Stack

| Thành phần | Công nghệ |
|---|---|
| Framework | Flutter (Dart) |
| State Management | `flutter_bloc` + `bloc_concurrency` |
| Local Database | `isar` |
| Dependency Injection | `get_it` |
| Video | `video_player` |
| Audio | `just_audio` + `audio_service` |
| PDF | `syncfusion_flutter_pdfviewer` |
| Ảnh | `cached_network_image` |

---

## 📁 Cấu trúc thư mục

```
lib/
├── main.dart                      # Entry point, khởi tạo DI + AudioService
├── injection.dart                 # get_it dependency injection setup
├── data/
│   ├── models/                    # Isar collections (Course, Lesson, Bookmark...)
│   ├── repositories/               # Tầng truy vấn Isar cho từng domain
│   └── services/
│       ├── database_service.dart          # Seed mock data qua isolate
│       ├── video_controller_pool.dart     # LRU pool quản lý VideoPlayerController
│       └── audio_handler_service.dart     # AudioHandler cho audio_service
├── blocs/
│   ├── lesson_list/                # Phân trang danh sách bài học
│   ├── search/                     # Search realtime (restartable transformer)
│   ├── video_player/               # VideoPlayerCubit
│   ├── audio_player/                # AudioPlayerCubit
│   ├── quiz/                       # QuizBloc (chuyển câu, chấm điểm)
│   └── app_lifecycle/              # Theo dõi lifecycle toàn app
└── ui/
    ├── screens/                    # Home, Explore, LessonList, Video/Audio/Pdf/Image Viewer, Quiz, Search, History, Bookmark
    ├── widgets/                    # BookmarkButton và các widget dùng chung
    └── models/                    # Model UI thuần (SectionType, SubjectItem...)

tool/
└── generate_mock.dart              # Script sinh dữ liệu mock (courses.json, quiz_bank_1-5.json)

assets/
├── mock/                          # Dữ liệu JSON được sinh ra
├── videos/ audios/ pdfs/ images/   # Asset media local (nếu dùng)
```

---

## 🚀 Cài đặt & Chạy project

### Yêu cầu môi trường

- Flutter SDK ≥ 3.24.0
- Dart SDK ≥ 3.5.0
- Android Gradle Plugin `8.9.1` (khai báo sẵn trong `android/settings.gradle`)
- Gradle `8.11.1`
- Kotlin `2.1.0`
- JDK 17

### Các bước cài đặt

```bash
# 1. Cài dependencies
flutter pub get

# 2. Sinh dữ liệu mock (course, lesson, 5 ngân hàng quiz)
dart run tool/generate_mock.dart

# 3. Chạy codegen cho Isar + json_serializable
dart run build_runner build --delete-conflicting-outputs

# 4. Chạy app
flutter run
```

> ⚠️ **Lưu ý quan trọng:** Dữ liệu chỉ được seed vào Isar **một lần duy nhất** khi database rỗng. Nếu bạn thay đổi cấu trúc mock data hoặc model Isar sau khi đã chạy app, cần **gỡ cài đặt app khỏi thiết bị/emulator** trước khi `flutter run` lại để buộc seed lại dữ liệu mới.

---

## 🧩 Các quyết định kiến trúc quan trọng

### Vì sao dùng Isar thay vì sqflite/Drift?
Isar chạy query ở tầng native (Rust binding), không block Dart UI isolate — phù hợp cho yêu cầu search/filter realtime trên hàng nghìn bản ghi mà không cần tự quản lý isolate riêng cho từng query.

### Vì sao có `VideoControllerPool` thay vì tạo controller trực tiếp trong widget?
`VideoPlayerController` giữ tài nguyên native (texture, decoder) khá nặng. Nếu người dùng lướt qua nhiều video liên tục mà mỗi lần đều tạo controller mới không dispose đúng cách, RAM sẽ tăng tuyến tính. Pool áp dụng thuật toán **LRU (Least Recently Used)**, giới hạn tối đa `maxAlive` controller sống cùng lúc (mặc định 2).

### Vì sao Quiz dùng 5 file JSON riêng thay vì 1 file chung?
Ban đầu dùng 1 file chung với 700 câu chia đều theo `quizId = i % 20`, gây hiện tượng dữ liệu "lẫn" giữa các môn học không rõ ràng. Giải pháp: tách thành 5 "ngân hàng đề" độc lập (`quiz_bank_1.json` → `quiz_bank_5.json`), mỗi lượt vào Exam Section sẽ **random chọn 1 ngân hàng**, với ID câu hỏi duy nhất toàn cục (dùng offset `(bank-1) * 10000`) để đáp án không bao giờ đụng nhau giữa các bank.

### Xử lý race condition khi pop/push màn hình nhanh
Mọi Bloc/Cubit trong project đều có guard `if (isClosed) return;` **ngay sau mỗi `await`** trước khi gọi `emit()`. Điều này ngăn lỗi `StateError: Cannot emit new states after calling close` khi người dùng thao tác pop màn hình trong lúc tác vụ async (load video, query DB...) chưa hoàn tất.

### Vì sao Audio dùng `audio_service` thay vì `just_audio` trực tiếp?
Để hỗ trợ phát nhạc nền kèm notification media control (play/pause/seek từ thanh thông báo, khóa màn hình) theo đúng UX chuẩn của app học tập — yêu cầu `MainActivity` kế thừa `AudioServiceActivity` thay vì `FlutterActivity` mặc định.

---

## 🐛 Các lỗi thường gặp khi build & cách xử lý

| Lỗi | Nguyên nhân | Cách xử lý |
|---|---|---|
| `Namespace not specified` (isar_flutter_libs) | Package cũ chưa khai báo `namespace` cho AGP mới | Copy package vào `packages/`, patch thêm dòng `namespace` vào `android/build.gradle` của package, dùng `dependency_overrides` trỏ tới bản local |
| `AGP version too low` / `Kotlin version too low` | Flutter yêu cầu version tối thiểu cao hơn cấu hình hiện tại | Nâng `com.android.application` và `org.jetbrains.kotlin.android` trong `android/settings.gradle`, đồng bộ Gradle wrapper tương ứng |
| `Unable to delete directory .../apk/debug` | File APK bị khóa bởi process cũ (app đang chạy, Gradle daemon treo) | Tắt app trên thiết bị, chạy `gradlew --stop`, `taskkill /F /IM java.exe`, xóa thủ công thư mục `build/` |
| `PlatformException: The Activity class ... is wrong` | `MainActivity` chưa kế thừa `AudioServiceActivity` khi dùng `audio_service` | Sửa `MainActivity.kt` extends `AudioServiceActivity` thay vì `FlutterActivity` |
| `StateError: Cannot emit new states after calling close` | Race condition khi pop màn hình trong lúc Bloc đang xử lý async | Thêm `if (isClosed) return;` sau mỗi `await` trước `emit()` |

---

## 📌 Roadmap / Có thể mở rộng thêm

- [ ] Tạo thumbnail thật cho video local bằng `video_thumbnail` (hiện dùng icon đại diện vì mock data dùng video URL)
- [ ] Đồng bộ dữ liệu lên backend thật (hiện tại 100% local/offline)
- [ ] Thêm chế độ tải xuống bài học để xem offline hoàn toàn
- [ ] Thống kê tiến độ học tập theo biểu đồ

---

## 📄 License

Đây là project học tập/demo, không phục vụ mục đích thương mại.

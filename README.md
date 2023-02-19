![](https://i.imgur.com/Yc5Pw9v.png)
<p align="center">
   <a href="">
    <img src="https://img.shields.io/badge/awesome-Flutter-1da1f2.svg?style=plastic" alt="Awesome Flutter" />
  </a>
  <a href="https://github.com/rrousselGit/riverpod">
    <img src="https://img.shields.io/badge/maintained%20with-Riverpod-f700ff.svg?style=plastic" alt="Maintained with Riverpod" />
  </a>
</p>
# Student booking mobile app
Flutter Application with Riverpod & Freezed + Dio for API REST for YouthBit Hackaton 2023.
## Stack 
- DI - Riverpod & GetIT
- State managment - Riverpod
- CodeGen - Freezed & easy_localization

## Setup 
```
➜  folder ✗ https://github.com/youthbit/student_booking_app.git
➜  student_booking_app git:(master) ✗ flutter pub get

# in case there are conflicts in generatet files
➜  student_booking_app git:(master) ✗ flutter pub run build_runner build --delete-conflicting-outputs
➜  student_booking_app git:(master) ✗ flutter pub run easy_localization:generate --source-dir ./assets/translations -f keys -o locale_keys.g.dart


➜  student_booking_app git:(master) ✗ flutter run --no-sound-null-safety
```

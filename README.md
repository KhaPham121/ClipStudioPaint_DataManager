# ClipStudio Paint Data Manager

**Phiên bản:** 1.0.0  
**Tác giả:** [KhaPham121](https://github.com/KhaPham121)  
**Ngôn ngữ:** Windows Batch Script (.bat)

---

## 📌 Giới thiệu

`ClipStudio Paint Data Manager` là một công cụ dòng lệnh được phát triển để hỗ trợ người dùng quản lý dữ liệu người dùng (UserData) của phần mềm **Clip Studio Paint** một cách dễ dàng và an toàn. Công cụ này cho phép bạn sao lưu, khôi phục hoặc xóa hoàn toàn dữ liệu người dùng của CSP chỉ với vài thao tác đơn giản.

---

## ⚙️ Công dụng

- ✅ **Sao lưu dữ liệu người dùng CSP**: Lưu lại toàn bộ cấu hình người dùng dưới dạng `.bak` để dự phòng hoặc di chuyển sang máy khác.
- ✅ **Khôi phục dữ liệu từ bản sao lưu `.bak`**: Giải nén và phục hồi dữ liệu đã sao lưu trước đó.
- ✅ **Xóa sạch toàn bộ dữ liệu người dùng**: Dành cho người muốn reset hoàn toàn CSP về mặc định.
- ✅ **Kiểm tra & xác minh bản sao lưu**: Đảm bảo tính toàn vẹn dữ liệu thông qua file `backup.point`.
- ✅ **Hỗ trợ giao diện chọn file bằng cửa sổ Windows GUI** (nhờ PowerShell).
- ✅ **Ghi log chi tiết mọi hành động** vào `log.txt` để hỗ trợ xử lý lỗi.

---

## 🚀 Hướng dẫn sử dụng

### 1. **Yêu cầu:**
- Chạy file `ClipStudioPaintDataManager.exe` **với quyền Administrator**

### 2. **Menu chính**

Sau khi khởi chạy, chương trình hiển thị menu:

[1] Backup my CLIPStudioPaint UserData
[2] Restore my CLIPStudioPaint UserData
[3] Wipe all my current CLIPStudioPaint UserData
[4] Get help
[0] Open log


### 3. **Sao lưu dữ liệu**

- Chọn `1` để bắt đầu sao lưu.
- Hộp thoại lưu file sẽ xuất hiện. Nhập tên và chọn nơi lưu `.bak`.
- Sau khi hoàn tất, thông báo hiện lên: `Backup completed`.

### 4. **Khôi phục dữ liệu**

- Chọn `2` để khôi phục dữ liệu.
- Hộp thoại chọn file `.bak` sẽ xuất hiện.
- Nếu bản sao lưu hợp lệ, chương trình sẽ giải nén và khôi phục dữ liệu.

### 5. **Xóa dữ liệu**

- Chọn `3` để xóa toàn bộ dữ liệu người dùng CSP.
- Cảnh báo sẽ hiện ra, chọn `[Y]` để tiếp tục hoặc `[N]` để quay lại.

### 6. **Trợ giúp**

- Chọn `4` để xem hướng dẫn nhanh, thông tin về định dạng backup, bảo mật...

### 7. **Xem log**

- Chọn `0` để mở `log.txt` trong Notepad.

---

## ❗ Xử lý lỗi

| Vấn đề | Nguyên nhân | Cách xử lý |
|-------|-------------|-------------|
| `Administrator privileges required` | Không chạy bằng quyền Admin | Nhấn chuột phải vào `.bat` và chọn **"Run as Administrator"** |
| `7z.exe` hoặc `7z.dll` not found | Thiếu file nén 7-Zip trong thư mục `module/` | Đảm bảo file `7z.exe` và `7z.dll` đúng phiên bản và đúng vị trí |
| `Hash mismatch` | Tệp 7-Zip bị thay đổi hoặc lỗi | Tải lại phiên bản chuẩn của `7z.exe` và `7z.dll` |
| `Invalid backup file: backup.point not found` | File `.bak` không phải do công cụ này tạo | Dùng đúng file sao lưu tạo từ công cụ này |
| Backup không thành công | Đường dẫn lỗi, thiếu quyền, hoặc tên file không hợp lệ | Đảm bảo đường dẫn không chứa ký tự đặc biệt và có quyền ghi |

---

## 📁 Thư mục & File được xử lý

- `%appdata%\CELSYSUserData`
- `%appdata%\CELSYS`
- `%appdata%\CELSYS_*` (thư mục phụ, nếu có)

---

## 🛡️ Bảo mật & riêng tư

- File backup không được mã hóa. Bạn có thể dùng WinRAR hoặc 7-Zip để mở nội dung.
- Nếu cần bảo mật, hãy **tự mã hóa** file `.bak` bằng công cụ bên thứ ba như **VeraCrypt**, **7-Zip AES**, v.v.

---

## 📜 Bản quyền

Copyright (c) 2025 KhaPham121

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, and distribute copies of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.


---

## 💬 Liên hệ

Nếu bạn gặp lỗi hoặc cần hỗ trợ:
- Gửi email kèm theo `log.txt` cho kỹ thuật viên
- Hoặc mở issue trên GitHub: [github.com/KhaPham121](https://github.com/KhaPham121)

---

===== ENGLISH =====

# ClipStudio Paint Data Manager

**Version:** 1.0.0
**Author:** [KhaPham121](https://github.com/KhaPham121)
**Language:** Windows Batch Script (.bat)

---

## 📌 Introduction

`ClipStudio Paint Data Manager` is a command-line tool developed to help users manage user data (UserData) of **Clip Studio Paint** software easily and safely. This tool allows you to backup, restore or completely delete CSP user data with just a few simple steps.

---

## ⚙️ Uses

- ✅ **Backup CSP user data**: Save all user configurations as `.bak` for backup or migration to another machine.
- ✅ **Restore data from `.bak` backup**: Extract and restore previously backed up data.

- ✅ **Clear all user data**: For those who want to completely reset CSP to default.

- ✅ **Check & verify backup**: Ensure data integrity via `backup.point` file.

- ✅ **Support file selection interface using Windows GUI window** (thanks to PowerShell).

- ✅ **Write detailed log of all actions** to `log.txt` to support error handling.

---

## 🚀 Instructions

### 1. **Requirements:**

- Run the file `ClipStudioPaintDataManager.exe` **with Administrator rights**


### 2. **Main Menu**

After launching, the program displays the menu:

[1] Backup my CLIPStudioPaint UserData
[2] Restore my CLIPStudioPaint UserData
[3] Wipe all my current CLIPStudioPaint UserData
[4] Get help
[0] Open log

### 3. **Backup data**

- Select `1` to start the backup.

- The save file dialog box will appear. Enter a name and select the location to save `.bak`.

- Once completed, the message appears: `Backup completed`.

### 4. **Restore Data**

- Select `2` to restore data.

- The `.bak` file selection dialog box will appear.

- If the backup is valid, the program will extract and restore the data.

### 5. **Delete Data**

- Select `3` to delete all CSP user data.

- A warning will appear, select `[Y]` to continue or `[N]` to go back.

### 6. **Help**

- Select `4` to see quick instructions, information about backup formats, security, etc.

### 7. **View log**

- Select `0` to open `log.txt` in Notepad.

---

## ❗ Troubleshooting

| Problem | Cause | Solution |
|-------|-------------|-------------|
| `Administrator privileges required` | Do not run as Administrator | Right-click `.bat` and select **"Run as Administrator"** |
| `7z.exe` or `7z.dll` not found | Missing 7-Zip archive in `module/` folder | Make sure `7z.exe` and `7z.dll` are the correct version and location |
| `Hash mismatch` | 7-Zip file is modified or corrupted | Reload the correct version of `7z.exe` and `7z.dll` |
| `Invalid backup file: backup.point not found` | `.bak` file was not created by this tool | Use correct backup file created by this tool |
| Backup failed | Path is broken, permissions are missing, or file name is invalid | Make sure path does not contain special characters and has writable permissions |

---

## 📁 Folders & Files Processed

- `%appdata%\CELSYSUserData`
- `%appdata%\CELSYS`
- `%appdata%\CELSYS_*` (subfolders, if any)

---

## 🛡️ Security & Privacy

- The backup file is not encrypted. You can use WinRAR or 7-Zip to open the contents.

- If security is needed, **self-encrypt** the `.bak` file using a third-party tool like **VeraCrypt**, **7-Zip AES**, etc.

---

## 📜 Copyright

Copyright (c) 2025 KhaPham121

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, and distribute copies of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND.

---

## 💬 Contact

If you encounter an error or need support:
- Send an email with `log.txt` to a technician
- Or open an issue on GitHub: [github.com/KhaPham121](https://github.com/KhaPham121)

---

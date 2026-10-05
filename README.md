# Camouflage - Ai là kẻ ngoại đạo?

Chào mừng đến với Camouflage! Đây là một tựa game party "hack não" cực kỳ thích hợp để mang ra chơi mỗi khi đi nhậu, đi cafe nhóm hoặc đơn giản là muốn làm sứt mẻ tình anh em. 

Game được lấy cảm hứng từ trò Undercover kinh điển nhưng được khoác lên mình một bộ giao diện Neo-Brutalism siêu ngầu, viền đen dày cộp và màu sắc chói lọi.

Chơi thử ngay tại: https://anhlv0495.github.io/camouflage/

---

## Cách chơi

Sẽ có 3 phe trong trò chơi này:
- Dân thường (Civilian): Chiếm số đông. Mọi người đều nhận được cùng 1 từ khóa bí mật. Nhiệm vụ là tìm ra những kẻ không cùng phe.
- Nội gián (Undercover): Nhận được 1 từ khóa na ná với từ của Dân thường (VD: Dân thường nhận "Bóng đá" thì Nội gián nhận "Bóng chuyền"). Nhiệm vụ là chém gió để không ai biết mình bị lạc quẻ.
- Mr. White: Kẻ tay không bắt giặc. Không nhận được bất kỳ từ khóa nào cả. Nhiệm vụ là hóng hớt xem dân tình đang nói về cái gì và đoán từ.

Luật chơi:
1. Khai báo số lượng người chơi và truyền tay nhau điện thoại để nhận từ khóa.
2. Mỗi vòng, từng người đưa ra 1 từ duy nhất để miêu tả từ khóa của mình (đừng lộ liễu quá kẻo Mr. White đoán được, nhưng cũng đừng mập mờ quá kẻo bị đồng đội vote out).
3. Thảo luận và Vote! Ai bị vote nhiều nhất sẽ lên bảng đếm số.
4. Nếu Mr. White bị loại, hắn có 1 cơ hội lật ngược thế cờ bằng cách nhập lại từ khóa của Dân thường. Nếu đúng -> Mr. White thắng đậm!

## Tính năng nổi bật
- Kho tàng từ khóa siêu to khổng lồ: Hơn 300 cặp từ (tổng 600 từ) cho mỗi ngôn ngữ. Chơi cháy máy cũng không hết từ.
- Giao diện Neo-Brutalism nảy tưng tưng bao mượt, bao cháy.
- Hỗ trợ song ngữ (Tiếng Việt & Tiếng Anh).

## Dành cho anh em Dev (Cách chạy source code)

Code được viết bằng Flutter. Nếu bạn muốn lôi về vọc vạch:

1. Clone repo này về máy.
2. Cài đặt Flutter SDK (nếu chưa có).
3. Mở Terminal và chạy:
   ```bash
   flutter pub get
   flutter run -d chrome
   ```

Cách Build lên Web (như Github Pages):
Nhớ thêm cái cờ --no-tree-shake-icons để không bị bay màu mấy cái icon FontAwesome nhé!
```bash
flutter build web --release --base-href "/camouflage/" --no-tree-shake-icons
```
Sau đó cứ bế cả cụm thư mục build/web/ lên nhánh main là xong!

---
Làm ra game này chủ yếu để giải trí cuối tuần. Chúc các bạn có những trận cãi nhau nảy lửa và vui vẻ!

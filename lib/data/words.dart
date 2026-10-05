import 'dart:math';

class WordPair {
  final String civilianWord;
  final String undercoverWord;

  WordPair({required this.civilianWord, required this.undercoverWord});
}

class WordsData {
  static final Map<String, List<List<String>>> _rawPairs = {
    'vi': [
      // Đồ vật / Công nghệ
      ["Xe đạp", "Xe máy"], ["Bàn phím", "Con chuột"], ["Đồng hồ đeo tay", "Đồng hồ treo tường"], ["Máy giặt", "Tủ lạnh"], ["Quạt trần", "Quạt cây"],
      ["Laptop", "Máy tính để bàn"], ["Sách", "Báo"], ["Bút bi", "Bút chì"], ["Gương", "Kính râm"], ["Chổi", "Máy hút bụi"],
      ["Điện thoại thông minh", "Máy tính bảng"], ["Máy ảnh", "Máy quay phim"], ["Tai nghe có dây", "Tai nghe bluetooth"], ["Ti vi", "Máy chiếu"], ["Ví tiền", "Balo"],
      // Đồ ăn / Thức uống
      ["Trà sữa", "Cà phê"], ["Phở", "Bún bò"], ["Bia", "Rượu vang"], ["Nước lọc", "Nước khoáng"], ["Kẹo mút", "Kẹo cao su"],
      ["Bánh mì", "Bánh bao"], ["Pizza", "Hamburger"], ["Sữa tươi", "Sữa đặc"], ["Dưa hấu", "Dưa lưới"], ["Sầu riêng", "Mít"],
      ["Bún chả", "Nem nướng"], ["Trà chanh", "Trà đào"], ["Sữa chua", "Kem"], ["Xúc xích", "Lạp xưởng"], ["Khoai tây chiên", "Gà rán"],
      // Nghề nghiệp
      ["Bác sĩ", "Y tá"], ["Cảnh sát", "Bảo vệ"], ["Giáo viên", "Giảng viên"], ["Ca sĩ", "Diễn viên"], ["Phi công", "Tiếp viên hàng không"],
      ["Đầu bếp", "Phục vụ bàn"], ["Nhà văn", "Nhà báo"], ["Thợ cắt tóc", "Thợ trang điểm"], ["Lập trình viên", "Thiết kế đồ họa"], ["Kiến trúc sư", "Kỹ sư xây dựng"],
      ["Nông dân", "Ngư dân"], ["Thợ mộc", "Thợ hàn"], ["Kế toán", "Kiểm toán"], ["Luật sư", "Thẩm phán"], ["Người mẫu", "Hoa hậu"],
      // Địa điểm
      ["Biển", "Hồ"], ["Núi", "Đồi"], ["Chợ", "Siêu thị"], ["Bệnh viện", "Phòng khám"], ["Trường học", "Trung tâm gia sư"],
      ["Rạp chiếu phim", "Nhà hát"], ["Quán cà phê", "Quán nhậu"], ["Khách sạn", "Nhà nghỉ"], ["Công viên", "Sở thú"], ["Sân bay", "Bến xe"],
      ["Thư viện", "Nhà sách"], ["Bảo tàng", "Phòng tranh"], ["Khu vui chơi", "Sân vận động"], ["Chùa", "Nhà thờ"], ["Bưu điện", "Ngân hàng"],
      // Khái niệm / Động từ
      ["Chạy", "Đi bộ"], ["Ngủ", "Thức"], ["Khóc", "Cười"], ["Hát", "Nói"], ["Bơi", "Lặn"],
      ["Nóng", "Ấm"], ["Lạnh", "Mát"], ["Mưa", "Tuyết"], ["Sáng", "Tối"], ["Yêu", "Thích"],
      ["Mua", "Bán"], ["Học", "Làm"], ["Đọc", "Viết"], ["Nhớ", "Quên"], ["Sống", "Tồn tại"],
      // Động vật
      ["Chó", "Mèo"], ["Gà", "Vịt"], ["Sư tử", "Hổ"], ["Cá mập", "Cá heo"], ["Chuột", "Sóc"],
      ["Khỉ", "Vượn"], ["Chim sẻ", "Chim bồ câu"], ["Rắn", "Giun"], ["Ngựa", "Lừa"], ["Bò", "Trâu"],
      ["Kiến", "Ong"], ["Muỗi", "Ruồi"], ["Gấu trúc", "Gấu bắc cực"], ["Chim cánh cụt", "Hải cẩu"], ["Sứa", "Mực"],
      // Tự nhiên
      ["Mặt trời", "Mặt trăng"], ["Ngôi sao", "Hành tinh"], ["Mây", "Sương mù"], ["Gió", "Bão"], ["Lốc xoáy", "Động đất"],
      ["Rừng", "Sa mạc"], ["Đảo", "Bán đảo"], ["Sông", "Suối"], ["Thác nước", "Biển"], ["Đất", "Cát"],
      // Thể thao
      ["Bóng đá", "Futsal"], ["Bóng rổ", "Bóng chuyền"], ["Cầu lông", "Quần vợt"], ["Bơi lội", "Lặn"], ["Cờ vua", "Cờ tướng"],
      ["Điền kinh", "Marathon"], ["Võ thuật", "Boxing"], ["Trượt tuyết", "Trượt băng"], ["Đua xe đạp", "Đua xe máy"], ["Bóng bàn", "Bi-a"],
      // Đồ dùng học tập / Văn phòng
      ["Tẩy", "Bút xóa"], ["Thước kẻ", "Compa"], ["Balo", "Cặp xách"], ["Bàn học", "Ghế xoay"], ["Bảng đen", "Bảng trắng"],
      ["Giấy note", "Sổ tay"], ["Máy tính cầm tay", "Bàn tính"], ["Bút dạ", "Bút sáp màu"], ["Ghim giấy", "Kẹp giấy"], ["Mực in", "Hộp mực"],
      // Phương tiện giao thông
      ["Tàu hỏa", "Tàu điện ngầm"], ["Máy bay", "Trực thăng"], ["Thuyền", "Cano"], ["Xe buýt", "Xe khách"], ["Xe tải", "Xe bán tải"],
      ["Xe đạp điện", "Xe máy điện"], ["Tàu thủy", "Du thuyền"], ["Khinh khí cầu", "Dù lượn"], ["Tàu ngầm", "Tàu chiến"], ["Xe cứu thương", "Xe cứu hỏa"],
      // Bộ phận cơ thể
      ["Mắt", "Mũi"], ["Tay", "Chân"], ["Răng", "Lưỡi"], ["Tóc", "Lông mày"], ["Tim", "Phổi"],
      ["Dạ dày", "Ruột"], ["Cổ", "Vai"], ["Ngón tay", "Ngón chân"], ["Móng tay", "Móng chân"], ["Tai", "Miệng"],
      // Giải trí / Nghệ thuật
      ["Phim điện ảnh", "Phim truyền hình"], ["Nhạc pop", "Nhạc rock"], ["Tranh sơn dầu", "Tranh màu nước"], ["Đàn piano", "Đàn organ"], ["Truyện tranh", "Tiểu thuyết"],
      ["Thơ", "Văn xuôi"], ["Xiếc", "Ảo thuật"], ["Đàn guitar", "Đàn ukulele"], ["Hát karaoke", "Nghe nhạc"], ["Chơi game", "Lướt web"],
      // Thời tiết / Hiện tượng
      ["Nắng", "Mưa"], ["Sương mù", "Mây"], ["Bão", "Áp thấp"], ["Cầu vồng", "Cực quang"], ["Sấm", "Sét"],
      // Tình cảm / Cảm xúc
      ["Vui", "Hạnh phúc"], ["Buồn", "Tuyệt vọng"], ["Giận dữ", "Tức tối"], ["Ngạc nhiên", "Bất ngờ"], ["Sợ hãi", "Lo lắng"],
      // Trái cây / Rau củ
      ["Táo", "Lê"], ["Cam", "Quýt"], ["Chuối", "Đu đủ"], ["Rau muống", "Rau cải"], ["Cà chua", "Cà rốt"],
      ["Khoai lang", "Khoai tây"], ["Hành tây", "Hành lá"], ["Tỏi", "Gừng"], ["Ớt", "Tiêu"], ["Bí ngô", "Bí đao"],
      // Màu sắc
      ["Đỏ", "Hồng"], ["Xanh dương", "Xanh lá"], ["Trắng", "Đen"], ["Vàng", "Cam"], ["Tím", "Nâu"],
      ["Xám", "Bạc"], ["Vàng kim", "Đồng"], ["Màu be", "Trắng ngà"], ["Xanh navy", "Đen nhánh"], ["Đỏ đô", "Tím than"],
      // Đồ gia dụng
      ["Chảo", "Nồi"], ["Bát", "Đĩa"], ["Đũa", "Thìa"], ["Dao", "Kéo"], ["Thớt", "Mâm"],
      ["Cốc", "Chén"], ["Phích nước", "Ấm đun nước"], ["Khăn tắm", "Khăn mặt"], ["Bàn chải", "Kem đánh răng"], ["Gối", "Chăn"],
      // Thời gian
      ["Sáng", "Trưa"], ["Chiều", "Tối"], ["Hôm qua", "Hôm nay"], ["Tuần này", "Tuần sau"], ["Tháng", "Năm"],
      ["Thế kỷ", "Thập kỷ"], ["Phút", "Giây"], ["Giờ", "Ngày"], ["Mùa xuân", "Mùa thu"], ["Mùa hè", "Mùa đông"],
      // Địa lý / Vũ trụ
      ["Châu Á", "Châu Âu"], ["Bắc Cực", "Nam Cực"], ["Quốc gia", "Thành phố"], ["Trái Đất", "Sao Hỏa"], ["Hố đen", "Thiên hà"],
      ["Đại dương", "Ao hồ"], ["Núi lửa", "Động đất"], ["Sóng thần", "Bão tố"], ["Mật độ", "Trọng lực"], ["Đường xích đạo", "Kinh tuyến"],
      // Động tác / Thói quen
      ["Nhảy", "Múa"], ["Nhai", "Nuốt"], ["Ngáp", "Hắt hơi"], ["Gãi", "Xoa"], ["Gật đầu", "Lắc đầu"],
      ["Nhảy", "Múa"], ["Nhai", "Nuốt"], ["Ngáp", "Hắt hơi"], ["Gãi", "Xoa"], ["Gật đầu", "Lắc đầu"],
      // Văn hóa / Xã hội
      ["Đám cưới", "Đám hỏi"], ["Sinh nhật", "Kỷ niệm"], ["Lễ hội", "Sự kiện"], ["Lịch sử", "Địa lý"], ["Tôn giáo", "Tín ngưỡng"],
      // Quần áo / Phụ kiện
      ["Áo sơ mi", "Áo thun"], ["Quần đùi", "Quần dài"], ["Váy", "Đầm"], ["Mũ lưỡi trai", "Nón lá"], ["Giày thể thao", "Giày da"],
      ["Găng tay", "Tất"], ["Dây nịt", "Cà vạt"], ["Kính cận", "Kính râm"], ["Áo khoác", "Áo len"], ["Đồng hồ", "Vòng tay"],
      // Âm nhạc / Nhạc cụ
      ["Đàn bầu", "Đàn nhị"], ["Trống", "Chiêng"], ["Sáo", "Tiêu"], ["Loa", "Tai nghe"], ["Micro", "Megaphone"],
      // Tòa nhà / Kiến trúc
      ["Lâu đài", "Cung điện"], ["Nhà cấp 4", "Biệt thự"], ["Chung cư", "Khách sạn"], ["Lều", "Nhà rông"], ["Cầu", "Hầm"],
      // Truyện cổ tích / Thần thoại
      ["Rồng", "Phượng hoàng"], ["Tiên nữ", "Phù thủy"], ["Yêu tinh", "Quỷ"], ["Người khổng lồ", "Người lùn"], ["Thần", "Ma"],
      // Động vật dưới nước
      ["Cá voi", "Cá heo"], ["Tôm", "Cua"], ["Bạch tuộc", "Mực"], ["Rùa biển", "Ba ba"], ["Cá sấu", "Hà mã"],
      // Thực vật / Hoa
      ["Hoa hồng", "Hoa cúc"], ["Hoa sen", "Hoa súng"], ["Cây thông", "Cây tùng"], ["Cây tre", "Cây trúc"], ["Cây đa", "Cây đề"],
      // Đồ ngọt / Tráng miệng
      ["Bánh kem", "Bánh cupcake"], ["Chè", "Trà sữa"], ["Kẹo dẻo", "Kẹo cứng"], ["Sô cô la", "Karamel"], ["Bánh quy", "Bánh quy xốp"],
      // Các môn khoa học
      ["Toán học", "Vật lý"], ["Hóa học", "Sinh học"], ["Ngữ văn", "Lịch sử"], ["Thiên văn học", "Địa chất học"], ["Triết học", "Tâm lý học"],
      // Vật liệu
      ["Gỗ", "Sắt"], ["Nhựa", "Thủy tinh"], ["Vàng", "Bạc"], ["Kim cương", "Pha lê"], ["Bông", "Lụa"],
      // Vũ khí
      ["Kiếm", "Đao"], ["Cung", "Nỏ"], ["Súng lục", "Súng trường"], ["Bom", "Lựu đạn"], ["Giáp", "Khiên"],
      // Giao tiếp
      ["Tin nhắn", "Gọi điện"], ["Email", "Thư tay"], ["Cãi nhau", "Tranh luận"], ["Khóc lóc", "Ăn vạ"], ["Cười mỉm", "Cười to"],
      // Địa danh nổi tiếng
      ["Tháp Eiffel", "Tượng Nữ thần Tự do"], ["Kim tự tháp", "Vạn Lý Trường Thành"], ["Núi Everest", "Núi Phú Sĩ"], ["Nhà hát Sydney", "Đấu trường La Mã"], ["Tháp nghiêng Pisa", "Đồng hồ Big Ben"],
      // Siêu anh hùng & Viễn tưởng
      ["Người dơi", "Siêu nhân"], ["Người nhện", "Đội trưởng Mỹ"], ["Người sắt", "Người kiến"], ["Thần sấm", "Khổng lồ xanh"], ["Người ngoài hành tinh", "Người máy"],
      // Công nghệ & Ứng dụng
      ["Facebook", "Instagram"], ["Tiktok", "Youtube"], ["Apple", "Samsung"], ["Google", "Microsoft"], ["Netflix", "Spotify"],
      // Khái niệm trừu tượng
      ["Thời gian", "Không gian"], ["Tự do", "Hòa bình"], ["Giấc mơ", "Thực tại"], ["Tình yêu", "Tình bạn"], ["May mắn", "Phép màu"]
    ],
    'en': [
      // Objects / Tech
      ["Bicycle", "Motorcycle"], ["Keyboard", "Mouse"], ["Wristwatch", "Wall clock"], ["Washing machine", "Refrigerator"], ["Ceiling fan", "Standing fan"],
      ["Laptop", "Desktop computer"], ["Book", "Newspaper"], ["Ballpoint pen", "Pencil"], ["Mirror", "Sunglasses"], ["Broom", "Vacuum cleaner"],
      ["Smartphone", "Tablet"], ["Camera", "Camcorder"], ["Wired earphones", "Bluetooth headphones"], ["Television", "Projector"], ["Wallet", "Backpack"],
      // Food / Drinks
      ["Milk tea", "Coffee"], ["Pho", "Beef noodle soup"], ["Beer", "Wine"], ["Filtered water", "Mineral water"], ["Lollipop", "Chewing gum"],
      ["Bread", "Steamed bun"], ["Pizza", "Hamburger"], ["Fresh milk", "Condensed milk"], ["Watermelon", "Cantaloupe"], ["Durian", "Jackfruit"],
      ["Grilled pork", "Grilled sausage"], ["Lemon tea", "Peach tea"], ["Yogurt", "Ice cream"], ["Sausage", "Hotdog"], ["French fries", "Fried chicken"],
      // Professions
      ["Doctor", "Nurse"], ["Police officer", "Security guard"], ["Teacher", "Professor"], ["Singer", "Actor"], ["Pilot", "Flight attendant"],
      ["Chef", "Waiter"], ["Writer", "Journalist"], ["Hairdresser", "Makeup artist"], ["Programmer", "Graphic designer"], ["Architect", "Civil engineer"],
      ["Farmer", "Fisherman"], ["Carpenter", "Welder"], ["Accountant", "Auditor"], ["Lawyer", "Judge"], ["Model", "Beauty queen"],
      // Places
      ["Sea", "Lake"], ["Mountain", "Hill"], ["Market", "Supermarket"], ["Hospital", "Clinic"], ["School", "Tutoring center"],
      ["Cinema", "Theater"], ["Coffee shop", "Pub"], ["Hotel", "Motel"], ["Park", "Zoo"], ["Airport", "Bus station"],
      ["Library", "Bookstore"], ["Museum", "Art gallery"], ["Amusement park", "Stadium"], ["Temple", "Church"], ["Post office", "Bank"],
      // Concepts / Verbs
      ["Run", "Walk"], ["Sleep", "Wake"], ["Cry", "Laugh"], ["Sing", "Speak"], ["Swim", "Dive"],
      ["Hot", "Warm"], ["Cold", "Cool"], ["Rain", "Snow"], ["Light", "Dark"], ["Love", "Like"],
      ["Buy", "Sell"], ["Study", "Work"], ["Read", "Write"], ["Remember", "Forget"], ["Live", "Exist"],
      // Animals
      ["Dog", "Cat"], ["Chicken", "Duck"], ["Lion", "Tiger"], ["Shark", "Dolphin"], ["Mouse", "Squirrel"],
      ["Monkey", "Ape"], ["Sparrow", "Pigeon"], ["Snake", "Earthworm"], ["Horse", "Donkey"], ["Cow", "Buffalo"],
      ["Ant", "Bee"], ["Mosquito", "Fly"], ["Panda", "Polar bear"], ["Penguin", "Seal"], ["Jellyfish", "Squid"],
      // Nature
      ["Sun", "Moon"], ["Star", "Planet"], ["Cloud", "Fog"], ["Wind", "Storm"], ["Tornado", "Earthquake"],
      ["Forest", "Desert"], ["Island", "Peninsula"], ["River", "Stream"], ["Waterfall", "Ocean"], ["Soil", "Sand"],
      // Sports
      ["Football", "Futsal"], ["Basketball", "Volleyball"], ["Badminton", "Tennis"], ["Swimming", "Diving"], ["Chess", "Checkers"],
      ["Athletics", "Marathon"], ["Martial arts", "Boxing"], ["Skiing", "Ice skating"], ["Cycling", "Motorcycle racing"], ["Table tennis", "Billiards"],
      // School / Office supplies
      ["Eraser", "Correction fluid"], ["Ruler", "Compass"], ["Backpack", "Briefcase"], ["Desk", "Swivel chair"], ["Blackboard", "Whiteboard"],
      ["Sticky note", "Notebook"], ["Calculator", "Abacus"], ["Marker", "Crayon"], ["Paper clip", "Binder clip"], ["Ink", "Ink cartridge"],
      // Transportation
      ["Train", "Subway"], ["Airplane", "Helicopter"], ["Boat", "Canoe"], ["Bus", "Coach"], ["Truck", "Pickup truck"],
      ["Electric bicycle", "Electric scooter"], ["Ship", "Yacht"], ["Hot air balloon", "Paraglider"], ["Submarine", "Warship"], ["Ambulance", "Fire truck"],
      // Body parts
      ["Eye", "Nose"], ["Hand", "Foot"], ["Tooth", "Tongue"], ["Hair", "Eyebrow"], ["Heart", "Lung"],
      ["Stomach", "Intestine"], ["Neck", "Shoulder"], ["Finger", "Toe"], ["Fingernail", "Toenail"], ["Ear", "Mouth"],
      // Entertainment / Arts
      ["Movie", "TV series"], ["Pop music", "Rock music"], ["Oil painting", "Watercolor painting"], ["Piano", "Organ"], ["Comic", "Novel"],
      ["Poetry", "Prose"], ["Circus", "Magic trick"], ["Guitar", "Ukulele"], ["Karaoke", "Listening to music"], ["Playing games", "Surfing the web"],
      // Weather / Phenomena
      ["Sunny", "Rainy"], ["Fog", "Cloud"], ["Storm", "Depression"], ["Rainbow", "Aurora"], ["Thunder", "Lightning"],
      // Emotions
      ["Happy", "Joyful"], ["Sad", "Depressed"], ["Angry", "Furious"], ["Surprised", "Shocked"], ["Scared", "Anxious"],
      // Fruits / Vegetables
      ["Apple", "Pear"], ["Orange", "Tangerine"], ["Banana", "Papaya"], ["Spinach", "Cabbage"], ["Tomato", "Carrot"],
      ["Sweet potato", "Potato"], ["Onion", "Scallion"], ["Garlic", "Ginger"], ["Chili", "Pepper"], ["Pumpkin", "Winter melon"],
      // Colors
      ["Red", "Pink"], ["Blue", "Green"], ["White", "Black"], ["Yellow", "Orange"], ["Purple", "Brown"],
      ["Gray", "Silver"], ["Gold", "Bronze"], ["Beige", "Ivory"], ["Navy blue", "Pitch black"], ["Burgundy", "Navy"],
      // Household items
      ["Pan", "Pot"], ["Bowl", "Plate"], ["Chopsticks", "Spoon"], ["Knife", "Scissors"], ["Cutting board", "Tray"],
      ["Cup", "Mug"], ["Thermos", "Kettle"], ["Bath towel", "Face towel"], ["Toothbrush", "Toothpaste"], ["Pillow", "Blanket"],
      // Time
      ["Morning", "Noon"], ["Afternoon", "Evening"], ["Yesterday", "Today"], ["This week", "Next week"], ["Month", "Year"],
      ["Century", "Decade"], ["Minute", "Second"], ["Hour", "Day"], ["Spring", "Autumn"], ["Summer", "Winter"],
      // Geography / Space
      ["Asia", "Europe"], ["North Pole", "South Pole"], ["Country", "City"], ["Earth", "Mars"], ["Black hole", "Galaxy"],
      ["Ocean", "Pond"], ["Volcano", "Earthquake"], ["Tsunami", "Hurricane"], ["Density", "Gravity"], ["Equator", "Meridian"],
      // Actions
      ["Jump", "Dance"], ["Chew", "Swallow"], ["Yawn", "Sneeze"], ["Scratch", "Rub"], ["Nod", "Shake head"],
      ["Jump", "Dance"], ["Chew", "Swallow"], ["Yawn", "Sneeze"], ["Scratch", "Rub"], ["Nod", "Shake head"],
      // Culture / Society
      ["Wedding", "Engagement"], ["Birthday", "Anniversary"], ["Festival", "Event"], ["History", "Geography"], ["Religion", "Belief"],
      // Clothing / Accessories
      ["Shirt", "T-shirt"], ["Shorts", "Trousers"], ["Skirt", "Dress"], ["Cap", "Hat"], ["Sneakers", "Leather shoes"],
      ["Gloves", "Socks"], ["Belt", "Tie"], ["Glasses", "Sunglasses"], ["Jacket", "Sweater"], ["Watch", "Bracelet"],
      // Music / Instruments
      ["Violin", "Cello"], ["Drum", "Cymbal"], ["Flute", "Clarinet"], ["Speaker", "Headphones"], ["Microphone", "Megaphone"],
      // Buildings / Architecture
      ["Castle", "Palace"], ["House", "Villa"], ["Apartment", "Hotel"], ["Tent", "Cabin"], ["Bridge", "Tunnel"],
      // Fairy tales / Mythology
      ["Dragon", "Phoenix"], ["Fairy", "Witch"], ["Goblin", "Demon"], ["Giant", "Dwarf"], ["God", "Ghost"],
      // Aquatic animals
      ["Whale", "Dolphin"], ["Shrimp", "Crab"], ["Octopus", "Squid"], ["Sea turtle", "Tortoise"], ["Crocodile", "Hippopotamus"],
      // Plants / Flowers
      ["Rose", "Daisy"], ["Lotus", "Water lily"], ["Pine tree", "Oak tree"], ["Bamboo", "Cane"], ["Banyan tree", "Bodhi tree"],
      // Sweets / Desserts
      ["Cake", "Cupcake"], ["Pudding", "Jelly"], ["Gummy candy", "Hard candy"], ["Chocolate", "Caramel"], ["Cookie", "Biscuit"],
      // Sciences / Subjects
      ["Mathematics", "Physics"], ["Chemistry", "Biology"], ["Literature", "History"], ["Astronomy", "Geology"], ["Philosophy", "Psychology"],
      // Materials
      ["Wood", "Iron"], ["Plastic", "Glass"], ["Gold", "Silver"], ["Diamond", "Crystal"], ["Cotton", "Silk"],
      // Weapons
      ["Sword", "Blade"], ["Bow", "Crossbow"], ["Pistol", "Rifle"], ["Bomb", "Grenade"], ["Armor", "Shield"],
      // Communication
      ["Text message", "Phone call"], ["Email", "Letter"], ["Argument", "Debate"], ["Crying", "Whining"], ["Smile", "Laugh"],
      // Famous Landmarks
      ["Eiffel Tower", "Statue of Liberty"], ["Pyramids", "Great Wall of China"], ["Mount Everest", "Mount Fuji"], ["Sydney Opera House", "Colosseum"], ["Leaning Tower of Pisa", "Big Ben"],
      // Superheroes & Sci-Fi
      ["Batman", "Superman"], ["Spiderman", "Captain America"], ["Iron Man", "Ant-Man"], ["Thor", "Hulk"], ["Alien", "Robot"],
      // Tech Brands & Apps
      ["Facebook", "Instagram"], ["Tiktok", "Youtube"], ["Apple", "Samsung"], ["Google", "Microsoft"], ["Netflix", "Spotify"],
      // Abstract Concepts
      ["Time", "Space"], ["Freedom", "Peace"], ["Dream", "Reality"], ["Love", "Friendship"], ["Luck", "Miracle"]
    ],
    'es': [
      // Objects / Tech
      ["Bicicleta", "Motocicleta"], ["Teclado", "Ratón"], ["Reloj de pulsera", "Reloj de pared"], ["Lavadora", "Refrigerador"], ["Ventilador de techo", "Ventilador de pie"],
      ["Portátil", "Computadora de escritorio"], ["Libro", "Periódico"], ["Bolígrafo", "Lápiz"], ["Espejo", "Gafas de sol"], ["Escoba", "Aspiradora"],
      ["Teléfono inteligente", "Tableta"], ["Cámara", "Videocámara"], ["Auriculares con cable", "Auriculares Bluetooth"], ["Televisión", "Proyector"], ["Cartera", "Mochila"],
      // Food / Drinks
      ["Té con leche", "Café"], ["Sopa de fideos", "Sopa de res"], ["Cerveza", "Vino"], ["Agua filtrada", "Agua mineral"], ["Piruleta", "Chicle"],
      ["Pan", "Bollo al vapor"], ["Pizza", "Hamburguesa"], ["Leche fresca", "Leche condensada"], ["Sandía", "Melón"], ["Durian", "Jaca"],
      ["Cerdo a la parrilla", "Salchicha a la parrilla"], ["Té de limón", "Té de melocotón"], ["Yogur", "Helado"], ["Salchicha", "Perrito caliente"], ["Papas fritas", "Pollo frito"],
      // Professions
      ["Médico", "Enfermera"], ["Policía", "Guardia de seguridad"], ["Profesor", "Catedrático"], ["Cantante", "Actor"], ["Piloto", "Azafata"],
      ["Chef", "Camarero"], ["Escritor", "Periodista"], ["Peluquero", "Maquillador"], ["Programador", "Diseñador gráfico"], ["Arquitecto", "Ingeniero civil"],
      ["Agricultor", "Pescador"], ["Carpintero", "Soldador"], ["Contador", "Auditor"], ["Abogado", "Juez"], ["Modelo", "Reina de belleza"],
      // Places
      ["Mar", "Lago"], ["Montaña", "Colina"], ["Mercado", "Supermercado"], ["Hospital", "Clínica"], ["Escuela", "Centro de tutoría"],
      ["Cine", "Teatro"], ["Cafetería", "Pub"], ["Hotel", "Motel"], ["Parque", "Zoológico"], ["Aeropuerto", "Estación de autobuses"],
      ["Biblioteca", "Librería"], ["Museo", "Galería de arte"], ["Parque de atracciones", "Estadio"], ["Templo", "Iglesia"], ["Oficina de correos", "Banco"],
      // Concepts / Verbs
      ["Correr", "Caminar"], ["Dormir", "Despertar"], ["Llorar", "Reír"], ["Cantar", "Hablar"], ["Nadar", "Bucear"],
      ["Caliente", "Cálido"], ["Frío", "Fresco"], ["Lluvia", "Nieve"], ["Luz", "Oscuridad"], ["Amor", "Gustar"],
      ["Comprar", "Vender"], ["Estudiar", "Trabajar"], ["Leer", "Escribir"], ["Recordar", "Olvidar"], ["Vivir", "Existir"],
      // Animals
      ["Perro", "Gato"], ["Pollo", "Pato"], ["León", "Tigre"], ["Tiburón", "Delfín"], ["Ratón", "Ardilla"],
      ["Mono", "Simio"], ["Gorrión", "Paloma"], ["Serpiente", "Lombriz"], ["Caballo", "Burro"], ["Vaca", "Búfalo"],
      ["Hormiga", "Abeja"], ["Mosquito", "Mosca"], ["Panda", "Oso polar"], ["Pingüino", "Foca"], ["Medusa", "Calamar"],
      // Nature
      ["Sol", "Luna"], ["Estrella", "Planeta"], ["Nube", "Niebla"], ["Viento", "Tormenta"], ["Tornado", "Terremoto"],
      ["Bosque", "Desierto"], ["Isla", "Península"], ["Río", "Arroyo"], ["Cascada", "Océano"], ["Tierra", "Arena"],
      // Sports
      ["Fútbol", "Fútbol sala"], ["Baloncesto", "Voleibol"], ["Bádminton", "Tenis"], ["Natación", "Buceo"], ["Ajedrez", "Damas"],
      ["Atletismo", "Maratón"], ["Artes marciales", "Boxeo"], ["Esquí", "Patinaje sobre hielo"], ["Ciclismo", "Motociclismo"], ["Tenis de mesa", "Billar"],
      // School / Office supplies
      ["Borrador", "Líquido corrector"], ["Regla", "Compás"], ["Mochila", "Maletín"], ["Escritorio", "Silla giratoria"], ["Pizarra", "Pizarra blanca"],
      ["Nota adhesiva", "Cuaderno"], ["Calculadora", "Ábaco"], ["Marcador", "Crayón"], ["Clip de papel", "Clip de carpeta"], ["Tinta", "Cartucho de tinta"],
      // Transportation
      ["Tren", "Metro"], ["Avión", "Helicóptero"], ["Barco", "Canoa"], ["Autobús", "Autocar"], ["Camión", "Camioneta"],
      ["Bicicleta eléctrica", "Scooter eléctrico"], ["Barco", "Yate"], ["Globo aerostático", "Parapente"], ["Submarino", "Buque de guerra"], ["Ambulancia", "Camión de bomberos"],
      // Body parts
      ["Ojo", "Nariz"], ["Mano", "Pie"], ["Diente", "Lengua"], ["Pelo", "Ceja"], ["Corazón", "Pulmón"],
      ["Estómago", "Intestino"], ["Cuello", "Hombro"], ["Dedo", "Dedo del pie"], ["Uña", "Uña del pie"], ["Oreja", "Boca"],
      // Entertainment / Arts
      ["Película", "Serie de TV"], ["Música pop", "Música rock"], ["Pintura al óleo", "Acuarela"], ["Piano", "Órgano"], ["Cómic", "Novela"],
      ["Poesía", "Prosa"], ["Circo", "Truco de magia"], ["Guitarra", "Ukelele"], ["Karaoke", "Escuchar música"], ["Jugar juegos", "Navegar por la web"],
      // Colors
      ["Rojo", "Rosa"], ["Azul", "Verde"], ["Blanco", "Negro"], ["Amarillo", "Naranja"], ["Morado", "Marrón"],
      ["Gris", "Plata"], ["Oro", "Bronce"], ["Beige", "Marfil"], ["Azul marino", "Negro azabache"], ["Borgoña", "Marino"],
      // Household items
      ["Sartén", "Olla"], ["Tazón", "Plato"], ["Palillos", "Cuchara"], ["Cuchillo", "Tijeras"], ["Tabla de cortar", "Bandeja"],
      ["Taza", "Jarra"], ["Termo", "Hervidor"], ["Toalla de baño", "Toalla de cara"], ["Cepillo de dientes", "Pasta de dientes"], ["Almohada", "Manta"],
      // Time
      ["Mañana", "Mediodía"], ["Tarde", "Noche"], ["Ayer", "Hoy"], ["Esta semana", "La próxima semana"], ["Mes", "Año"],
      ["Siglo", "Década"], ["Minuto", "Segundo"], ["Hora", "Día"], ["Primavera", "Otoño"], ["Verano", "Invierno"],
      // Geography / Space
      ["Asia", "Europa"], ["Polo Norte", "Polo Sur"], ["País", "Ciudad"], ["Tierra", "Marte"], ["Agujero negro", "Galaxia"],
      ["Océano", "Estanque"], ["Volcán", "Terremoto"], ["Tsunami", "Huracán"], ["Densidad", "Gravedad"], ["Ecuador", "Meridiano"],
      // Actions
      ["Saltar", "Bailar"], ["Masticar", "Tragar"], ["Bostezar", "Estornudar"], ["Rascar", "Frotar"], ["Asentir", "Negar con la cabeza"],
      ["Saltar", "Bailar"], ["Masticar", "Tragar"], ["Bostezar", "Estornudar"], ["Rascar", "Frotar"], ["Asentir", "Negar con la cabeza"],
      // Culture / Society
      ["Boda", "Compromiso"], ["Cumpleaños", "Aniversario"], ["Festival", "Evento"], ["Historia", "Geografía"], ["Religión", "Creencia"],
      // Clothing / Accessories
      ["Camisa", "Camiseta"], ["Pantalones cortos", "Pantalones"], ["Falda", "Vestido"], ["Gorra", "Sombrero"], ["Zapatillas", "Zapatos de cuero"],
      ["Guantes", "Calcetines"], ["Cinturón", "Corbata"], ["Gafas", "Gafas de sol"], ["Chaqueta", "Suéter"], ["Reloj", "Pulsera"],
      // Music / Instruments
      ["Violín", "Violonchelo"], ["Tambor", "Platillo"], ["Flauta", "Clarinete"], ["Altavoz", "Auriculares"], ["Micrófono", "Megáfono"],
      // Buildings / Architecture
      ["Castillo", "Palacio"], ["Casa", "Villa"], ["Apartamento", "Hotel"], ["Tienda de campaña", "Cabaña"], ["Puente", "Túnel"],
      // Fairy tales / Mythology
      ["Dragón", "Fénix"], ["Hada", "Bruja"], ["Duende", "Demonio"], ["Gigante", "Enano"], ["Dios", "Fantasma"],
      // Aquatic animals
      ["Ballena", "Delfín"], ["Camarón", "Cangrejo"], ["Pulpo", "Calamar"], ["Tortuga marina", "Tortuga"], ["Cocodrilo", "Hipopótamo"],
      // Plants / Flowers
      ["Rosa", "Margarita"], ["Loto", "Nenúfar"], ["Pino", "Roble"], ["Bambú", "Caña"], ["Banyan", "Árbol de Bodhi"],
      // Sweets / Desserts
      ["Pastel", "Magdalena"], ["Pudín", "Gelatina"], ["Gominola", "Caramelo duro"], ["Chocolate", "Caramelo"], ["Galleta", "Bizcocho"],
      // Sciences / Subjects
      ["Matemáticas", "Física"], ["Química", "Biología"], ["Literatura", "Historia"], ["Astronomía", "Geología"], ["Filosofía", "Psicología"],
      // Materials
      ["Madera", "Hierro"], ["Plástico", "Vidrio"], ["Oro", "Plata"], ["Diamante", "Cristal"], ["Algodón", "Seda"],
      // Weapons
      ["Espada", "Hoja"], ["Arco", "Ballesta"], ["Pistola", "Rifle"], ["Bomba", "Granada"], ["Armadura", "Escudo"],
      // Communication
      ["Mensaje de texto", "Llamada telefónica"], ["Correo electrónico", "Carta"], ["Argumento", "Debate"], ["Llorar", "Lloriquear"], ["Sonreír", "Reír"],
      // Famous Landmarks
      ["Torre Eiffel", "Estatua de la Libertad"], ["Pirámides", "Gran Muralla China"], ["Monte Everest", "Monte Fuji"], ["Ópera de Sídney", "Coliseo"], ["Torre inclinada de Pisa", "Big Ben"],
      // Superheroes & Sci-Fi
      ["Batman", "Superman"], ["Spiderman", "Capitán América"], ["Iron Man", "Ant-Man"], ["Thor", "Hulk"], ["Extraterrestre", "Robot"],
      // Tech Brands & Apps
      ["Facebook", "Instagram"], ["Tiktok", "Youtube"], ["Apple", "Samsung"], ["Google", "Microsoft"], ["Netflix", "Spotify"],
      // Abstract Concepts
      ["Tiempo", "Espacio"], ["Libertad", "Paz"], ["Sueño", "Realidad"], ["Amor", "Amistad"], ["Suerte", "Milagro"]
    ],
    'zh': [
      // Objects / Tech
      ["自行车", "摩托车"], ["键盘", "鼠标"], ["手表", "挂钟"], ["洗衣机", "冰箱"], ["吊扇", "落地扇"],
      ["笔记本电脑", "台式电脑"], ["书", "报纸"], ["圆珠笔", "铅笔"], ["镜子", "太阳镜"], ["扫帚", "吸尘器"],
      ["智能手机", "平板电脑"], ["相机", "摄像机"], ["有线耳机", "蓝牙耳机"], ["电视", "投影仪"], ["钱包", "背包"],
      // Food / Drinks
      ["奶茶", "咖啡"], ["米粉", "牛肉面"], ["啤酒", "葡萄酒"], ["纯净水", "矿泉水"], ["棒棒糖", "口香糖"],
      ["面包", "包子"], ["披萨", "汉堡"], ["鲜奶", "炼乳"], ["西瓜", "哈密瓜"], ["榴莲", "菠萝蜜"],
      ["烤猪肉", "烤香肠"], ["柠檬茶", "蜜桃茶"], ["酸奶", "冰淇淋"], ["香肠", "热狗"], ["炸薯条", "炸鸡"],
      // Professions
      ["医生", "护士"], ["警察", "保安"], ["老师", "教授"], ["歌手", "演员"], ["飞行员", "空乘"],
      ["厨师", "服务员"], ["作家", "记者"], ["理发师", "化妆师"], ["程序员", "平面设计师"], ["建筑师", "土木工程师"],
      ["农民", "渔民"], ["木匠", "焊工"], ["会计师", "审计师"], ["律师", "法官"], ["模特", "选美皇后"],
      // Places
      ["海", "湖"], ["山", "丘陵"], ["市场", "超市"], ["医院", "诊所"], ["学校", "辅导中心"],
      ["电影院", "剧院"], ["咖啡馆", "酒吧"], ["酒店", "汽车旅馆"], ["公园", "动物园"], ["机场", "汽车站"],
      ["图书馆", "书店"], ["博物馆", "美术馆"], ["游乐园", "体育场"], ["寺庙", "教堂"], ["邮局", "银行"],
      // Concepts / Verbs
      ["跑", "走"], ["睡", "醒"], ["哭", "笑"], ["唱", "说"], ["游泳", "潜水"],
      ["热", "暖"], ["冷", "凉"], ["雨", "雪"], ["亮", "暗"], ["爱", "喜欢"],
      ["买", "卖"], ["学习", "工作"], ["读", "写"], ["记", "忘"], ["生活", "存在"],
      // Animals
      ["狗", "猫"], ["鸡", "鸭"], ["狮子", "老虎"], ["鲨鱼", "海豚"], ["老鼠", "松鼠"],
      ["猴子", "猿"], ["麻雀", "鸽子"], ["蛇", "蚯蚓"], ["马", "驴"], ["牛", "水牛"],
      ["蚂蚁", "蜜蜂"], ["蚊子", "苍蝇"], ["熊猫", "北极熊"], ["企鹅", "海豹"], ["水母", "鱿鱼"],
      // Nature
      ["太阳", "月亮"], ["星星", "行星"], ["云", "雾"], ["风", "风暴"], ["龙卷风", "地震"],
      ["森林", "沙漠"], ["岛屿", "半岛"], ["河", "溪流"], ["瀑布", "海洋"], ["土壤", "沙子"],
      // Sports
      ["足球", "五人制足球"], ["篮球", "排球"], ["羽毛球", "网球"], ["游泳", "跳水"], ["国际象棋", "跳棋"],
      ["田径", "马拉松"], ["武术", "拳击"], ["滑雪", "滑冰"], ["自行车", "摩托车赛"], ["乒乓球", "台球"],
      // School / Office supplies
      ["橡皮", "修正液"], ["尺子", "圆规"], ["背包", "公文包"], ["书桌", "转椅"], ["黑板", "白板"],
      ["便利贴", "笔记本"], ["计算器", "算盘"], ["记号笔", "蜡笔"], ["回形针", "长尾夹"], ["墨水", "墨盒"],
      // Transportation
      ["火车", "地铁"], ["飞机", "直升机"], ["船", "独木舟"], ["公交车", "长途客车"], ["卡车", "皮卡"],
      ["电动自行车", "电动滑板车"], ["轮船", "游艇"], ["热气球", "滑翔伞"], ["潜艇", "军舰"], ["救护车", "消防车"],
      // Body parts
      ["眼睛", "鼻子"], ["手", "脚"], ["牙齿", "舌头"], ["头发", "眉毛"], ["心脏", "肺"],
      ["胃", "肠"], ["脖子", "肩膀"], ["手指", "脚趾"], ["指甲", "脚趾甲"], ["耳朵", "嘴巴"],
      // Entertainment / Arts
      ["电影", "电视剧"], ["流行音乐", "摇滚音乐"], ["油画", "水彩画"], ["钢琴", "风琴"], ["漫画", "小说"],
      ["诗歌", "散文"], ["马戏团", "魔术"], ["吉他", "尤克里里"], ["卡拉OK", "听音乐"], ["玩游戏", "上网"],
      // Colors
      ["红色", "粉色"], ["蓝色", "绿色"], ["白色", "黑色"], ["黄色", "橙色"], ["紫色", "棕色"],
      ["灰色", "银色"], ["金色", "青铜色"], ["米色", "象牙色"], ["海军蓝", "乌黑色"], ["酒红色", "藏青色"],
      // Household items
      ["平底锅", "锅"], ["碗", "盘子"], ["筷子", "勺子"], ["刀", "剪刀"], ["切菜板", "托盘"],
      ["杯子", "马克杯"], ["保温瓶", "水壶"], ["浴巾", "洗脸巾"], ["牙刷", "牙膏"], ["枕头", "毯子"],
      // Time
      ["早上", "中午"], ["下午", "晚上"], ["昨天", "今天"], ["本周", "下周"], ["月", "年"],
      ["世纪", "十年"], ["分钟", "秒"], ["小时", "天"], ["春天", "秋天"], ["夏天", "冬天"],
      // Geography / Space
      ["亚洲", "欧洲"], ["北极", "南极"], ["国家", "城市"], ["地球", "火星"], ["黑洞", "星系"],
      ["海洋", "池塘"], ["火山", "地震"], ["海啸", "飓风"], ["密度", "重力"], ["赤道", "子午线"],
      // Actions
      ["跳", "跳舞"], ["咀嚼", "吞咽"], ["打哈欠", "打喷嚏"], ["抓", "揉"], ["点头", "摇头"],
      ["跳", "跳舞"], ["咀嚼", "吞咽"], ["打哈欠", "打喷嚏"], ["抓", "揉"], ["点头", "摇头"],
      // Culture / Society
      ["婚礼", "订婚"], ["生日", "纪念日"], ["节日", "活动"], ["历史", "地理"], ["宗教", "信仰"],
      // Clothing / Accessories
      ["衬衫", "T恤"], ["短裤", "长裤"], ["裙子", "连衣裙"], ["帽子", "草帽"], ["运动鞋", "皮鞋"],
      ["手套", "袜子"], ["皮带", "领带"], ["眼镜", "太阳镜"], ["夹克", "毛衣"], ["手表", "手链"],
      // Music / Instruments
      ["小提琴", "大提琴"], ["鼓", "钹"], ["长笛", "单簧管"], ["扬声器", "耳机"], ["麦克风", "扩音器"],
      // Buildings / Architecture
      ["城堡", "宫殿"], ["房子", "别墅"], ["公寓", "酒店"], ["帐篷", "小木屋"], ["桥", "隧道"],
      // Fairy tales / Mythology
      ["龙", "凤凰"], ["仙女", "女巫"], ["妖精", "恶魔"], ["巨人", "矮人"], ["神", "鬼"],
      // Aquatic animals
      ["鲸鱼", "海豚"], ["虾", "螃蟹"], ["章鱼", "鱿鱼"], ["海龟", "乌龟"], ["鳄鱼", "河马"],
      // Plants / Flowers
      ["玫瑰", "雏菊"], ["莲花", "睡莲"], ["松树", "橡树"], ["竹子", "甘蔗"], ["榕树", "菩提树"],
      // Sweets / Desserts
      ["蛋糕", "纸杯蛋糕"], ["布丁", "果冻"], ["软糖", "硬糖"], ["巧克力", "焦糖"], ["饼干", "小圆干"],
      // Sciences / Subjects
      ["数学", "物理"], ["化学", "生物"], ["文学", "历史"], ["天文学", "地质学"], ["哲学", "心理学"],
      // Materials
      ["木头", "铁"], ["塑料", "玻璃"], ["金", "银"], ["钻石", "水晶"], ["棉花", "丝绸"],
      // Weapons
      ["剑", "刀"], ["弓", "弩"], ["手枪", "步枪"], ["炸弹", "手榴弹"], ["盔甲", "盾牌"],
      // Communication
      ["短信", "电话"], ["电子邮件", "信件"], ["争论", "辩论"], ["哭泣", "抱怨"], ["微笑", "大笑"],
      // Famous Landmarks
      ["埃菲尔铁塔", "自由女神像"], ["金字塔", "长城"], ["珠穆朗玛峰", "富士山"], ["悉尼歌剧院", "罗马斗兽场"], ["比萨斜塔", "大本钟"],
      // Superheroes & Sci-Fi
      ["蝙蝠侠", "超人"], ["蜘蛛侠", "美国队长"], ["钢铁侠", "蚁人"], ["雷神", "绿巨人"], ["外星人", "机器人"],
      // Tech Brands & Apps
      ["Facebook", "Instagram"], ["Tiktok", "Youtube"], ["苹果", "三星"], ["谷歌", "微软"], ["网飞", "声田"],
      // Abstract Concepts
      ["时间", "空间"], ["自由", "和平"], ["梦想", "现实"], ["爱情", "友谊"], ["运气", "奇迹"]
    ]
  };

  static WordPair getRandomPair(String lang) {
    final list = _rawPairs[lang] ?? _rawPairs['en']!;
    final random = Random();
    final pairIndex = random.nextInt(list.length);
    final selectedPair = list[pairIndex];

    if (random.nextBool()) {
      return WordPair(
        civilianWord: selectedPair[0],
        undercoverWord: selectedPair[1],
      );
    } else {
      return WordPair(
        civilianWord: selectedPair[1],
        undercoverWord: selectedPair[0],
      );
    }
  }
}

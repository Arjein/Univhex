import 'package:univhex/Objects/app_user.dart';
import 'package:univhex/Objects/univhex_post.dart';

class Constants {
  static const List<String> schools = <String>[
    "TED UNIVERSITY",
    "BASKENT UNIVERSITY",
    "ATILIM UNIVERSITY"
  ];

  static const List<String> fields = <String>[
    "Computer Engineering",
    "Industrial Engineering",
    "Architecture",
  ];
  static const List<String> years = <String>[
    "1",
    "2",
    "3",
    "4",
  ];

  static AppUser TestUser = AppUser(
    // For Testing the app without any authentication
    email: "test@tedu.edu.tr",
    fieldOfStudy: "Computer Engineering",
    name: "Name",
    surname: "Surname",
    password: "Test",
    university: "TED University",
    yearOfStudy: "4",
    hexPoints: 21,
  );
  static UnivhexPost TestPost = UnivhexPost(
    id: "",
    postedBy: TestUser,
    textContent:
        "Lorem Ipsum, dizgi ve baskı endüstrisinde kullanılan mıgır metinlerdir. Lorem Ipsum, adı bilinmeyen bir matbaacının bir hurufat numune kitabı oluşturmak üzere bir yazı galerisini alarak karıştırdığı 1500'lerden beri endüstri standardı sahte metinler olarak kullanılmıştır. Beşyüz yıl boyunca varlığını sürdürmekle kalmamış, aynı zamanda pek değişmeden elektronik dizgiye de sıçramıştır. 1960'larda Lorem Ipsum pasajları da içeren Letraset yapraklarının yayınlanması ile ve yakın zamanda Aldus PageMaker gibi Lorem Ipsum sürümleri içeren masaüstü yayıncılık yazılımları ile popüler olmuştur.",
    isAnonymous: false,
    dateTime: DateTime(2023, 9, 7, 18, 30),
    commentBy: {},
    hexedBy: [],
  );

  static UnivhexPost TestPost2 = UnivhexPost(
    id: "",
    postedBy: TestUser,
    textContent:
        "Yinelenen bir sayfa içeriğinin okuyucunun dikkatini dağıttığı bilinen bir gerçektir. Lorem Ipsum kullanmanın amacı, sürekli 'buraya metin gelecek, buraya metin gelecek' yazmaya kıyasla daha dengeli bir harf dağılımı sağlayarak okunurluğu artırmasıdır. Şu anda birçok masaüstü yayıncılık paketi ve web sayfa düzenleyicisi, varsayılan mıgır metinler olarak Lorem Ipsum kullanmaktadır. Ayrıca arama motorlarında 'lorem ipsum' anahtar sözcükleri ile arama yapıldığında henüz tasarım aşamasında olan çok sayıda site listelenir. Yıllar içinde, bazen kazara, bazen bilinçli olarak (örneğin mizah katılarak), çeşitli sürümleri geliştirilmiştir.",
    isAnonymous: true,
    dateTime: DateTime(2023, 9, 7, 19, 30),
    commentBy: {},
    hexedBy: [],
  );
  static UnivhexPost TestPost3 = UnivhexPost(
    id: "",
    postedBy: TestUser,
    textContent:
        "Yaygın inancın tersine, Lorem Ipsum rastgele sözcüklerden oluşmaz. Kökleri M.Ö. 45 tarihinden bu yana klasik Latin edebiyatına kadar uzanan 2000 yıllık bir geçmişi vardır. Virginia'daki Hampden-Sydney College'dan Latince profesörü Richard McClintock, bir Lorem Ipsum pasajında geçen ve anlaşılması en güç sözcüklerden biri olan 'consectetur' sözcüğünün klasik edebiyattaki örneklerini incelediğinde kesin bir kaynağa ulaşmıştır.",
    isAnonymous: false,
    dateTime: DateTime(2023, 9, 7, 20, 30),
    commentBy: {},
    hexedBy: [],
  );
  static List<UnivhexPost> UnivhexPosts = [TestPost, TestPost2, TestPost3];
}

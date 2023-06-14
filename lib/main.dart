import 'package:dnd_order_app/class/class.dart';
import 'package:dnd_order_app/const/const.dart';
import 'package:dnd_order_app/pages/cart_page.dart';
import 'package:dnd_order_app/pages/category_page.dart';
import 'package:dnd_order_app/pages/login_page.dart';
import 'package:dnd_order_app/pages/main_page.dart';
import 'package:dnd_order_app/pages/map_page.dart';
import 'package:dnd_order_app/pages/my_page.dart';
import 'package:dnd_order_app/pages/splash_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

List<Store> DUMMY_STORE = [
  new Store('store1', 4.2, 324),
  new Store('store2', 4.6, 284),
  new Store('store3', 5.0, 988),
  new Store('store4', 4.4, 1023),
];

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: NeumorphicApp(
        debugShowCheckedModeBanner: false,
        title: 'DnD',
        themeMode: ThemeMode.light,
        theme: NeumorphicThemeData(
          baseColor: BACKGROUND,
          lightSource: LightSource.top,
          depth: 10,
        ),
        darkTheme: NeumorphicThemeData(
          baseColor: Color(0xFF3E3E3E),
          lightSource: LightSource.topLeft,
          depth: 6,
        ),
        home: MainApp(),
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  MainApp({
    super.key,
  });
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentIndex = 0;
  late Widget content;

  final UserInfoController userInfoController = Get.put(
    UserInfoController(),
  );

  final OrderInfoController orderInfoController = Get.put(
    OrderInfoController(),
  );

  Future<String?> isUserSaved() async {
    final UserInfoController userInfoController = Get.find();
    if (userInfoController.userName.value != '') {
      return userInfoController.userEmail.value;
    }
    var storage = new FlutterSecureStorage();
    String? value = await storage.read(key: 'DnD');
    return value;
  }

  Future<void> isControllerExist(String? email) async {
    final UserInfoController userInfoController = Get.find();
    if (userInfoController.userEmail.value != '') {
      return;
    }
    await userInfoController.getUserInfo(email);
  }

  void onCategoryTapped(String menu) {
    setState(() {
      content = CategoryPage(
        onCategoryTapped: onCategoryTapped,
        menu: menu,
      );
    });
  }

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
      switch (index) {
        case 0:
          content = MainPage(
            onCategoryTapped: onCategoryTapped,
          );
          break;
        case 1:
          content = CartPage();
          break;
        case 2:
          content = MapPage();
          break;
        case 3:
          content = MyPage();
          break;
        default:
      }
    });
  }

  @override
  void initState() {
    super.initState();
    content = MainPage(
      onCategoryTapped: onCategoryTapped,
    );
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
      future: isUserSaved(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: SplashPage(),
          );
        } else if (snapshot.hasError) {
          FlutterNativeSplash.remove();
          return Scaffold(
            backgroundColor: BACKGROUND,
            body: Center(
              child: Text("에러가 발생했습니다. 다시시도해 주세요."),
            ),
          );
        } else if (snapshot.data == null) {
          FlutterNativeSplash.remove();
          return LoginPage();
        } else {
          final AllStoreController allStoreController = Get.put(
            AllStoreController(),
          );
          allStoreController.setAllStore(DUMMY_STORE);

          final MyCartController myCartController = Get.put(
            MyCartController(),
          );

          return FutureBuilder(
            future: isControllerExist(snapshot.data),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: SplashPage(),
                );
              } else if (snapshot.data == false) {
                FlutterNativeSplash.remove();
                return Scaffold(
                  backgroundColor: BACKGROUND,
                  body: Center(
                    child: Text("에러가 발생했습니다. 다시시도해 주세요."),
                  ),
                );
              } else {
                FlutterNativeSplash.remove();
                return GestureDetector(
                  onTap: () => {
                    FocusScope.of(context).requestFocus(new FocusNode()),
                  },
                  child: Scaffold(
                    backgroundColor: BACKGROUND,
                    resizeToAvoidBottomInset: false,
                    bottomNavigationBar: BottomNavigationBar(
                      elevation: 0,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      items: [
                        BottomNavigationBarItem(
                          activeIcon: Icon(
                            Icons.home,
                            color: Color.fromRGBO(255, 238, 187, 1),
                          ),
                          icon: Icon(
                            Icons.home,
                            color: Color.fromRGBO(154, 197, 244, 1),
                          ),
                          label: '홈',
                          backgroundColor: Color(0xFFFFFFFF),
                        ),
                        BottomNavigationBarItem(
                          activeIcon: Icon(
                            Icons.shopping_cart,
                            color: Color.fromRGBO(255, 238, 187, 1),
                          ),
                          icon: Icon(
                            Icons.shopping_cart,
                            color: Color.fromRGBO(154, 197, 244, 1),
                          ),
                          label: '장바구니',
                          backgroundColor: Color(0xFFFFFFFF),
                        ),
                        BottomNavigationBarItem(
                          activeIcon: Icon(
                            Icons.map,
                            color: Color.fromRGBO(255, 238, 187, 1),
                          ),
                          icon: Icon(
                            Icons.map,
                            color: Color.fromRGBO(154, 197, 244, 1),
                          ),
                          label: '지도',
                          backgroundColor: Color(0xFFFFFFFF),
                        ),
                        BottomNavigationBarItem(
                          activeIcon: Icon(
                            Icons.person,
                            color: Color.fromRGBO(255, 238, 187, 1),
                          ),
                          icon: Icon(
                            Icons.person,
                            color: Color.fromRGBO(154, 197, 244, 1),
                          ),
                          label: '마이페이지',
                          backgroundColor: Color(0xFFFFFFFF),
                        ),
                      ],
                      currentIndex: currentIndex,
                      onTap: onTabTapped,
                    ),
                    body: content,
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}

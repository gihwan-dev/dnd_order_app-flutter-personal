import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dnd_order_app/const/const.dart';
import 'package:get/get.dart';

class AllStoreController extends GetxController {
  var storeList = <Store>[].obs;

  void setAllStore(List<Store> newStoreList) {
    storeList = [...newStoreList].obs;
  }
}

class Store {
  final String name;
  final double rating;
  final int review_count;
  final List<Item> menu = [
    Item('item1', 'description1', 1000),
    Item('item2', 'description2', 2000),
    Item('item3', 'description3', 3000),
    Item('item4', 'description4', 4000),
  ];

  Store(this.name, this.rating, this.review_count);
}

class OrderInfoController extends GetxController {
  final userEmail = ''.obs;
  final userName = ''.obs;
  // final storeName = ''.obs;
  final total = 0.obs;
  final payMethod = ''.obs;
  final payDate = ''.obs;
  List<Item> cart = [];
  final dio = Dio(BaseOptions(
    baseUrl: REQ_URL,
  ));
  Future<bool> getOrder(String enteredUserEmail) async {
    // 주문 정보가 있는지 없는지 확인
    final result = await dio.post(
      '/order/',
      data: {
        "userEmail": enteredUserEmail,
      },
    );
    if (result.data["isValidate"] == false) {
      return false;
    }
    // 있으면 오더 인포 세팅 작업
    userEmail.value = result.data["userEmail"];
    userName.value = result.data["userName"];
    total.value = result.data["total"];
    payMethod.value = result.data["payMethod"];
    payDate.value = result.data["payDate"];
    cart = [
      ...result.data["cart"].map((item) {
        return Item.fromJson(item);
      })
    ];
    // 이후 리턴 트루
    return true;
  }

  Future<bool> setOrder() async {
    try {
      var encodedCart = [
        ...cart.map((item) {
          return item.toJson();
        })
      ];
      print(encodedCart);
      final result = await dio.post('/order/complete', data: {
        "userEmail": userEmail.value,
        "userName": userName.value,
        "total": total.value,
        "payMethod": payMethod.value,
        "payDate": payDate.value,
        "cart": encodedCart,
      });
      if (result.data["accepted"] == true) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}

class Item {
  final String name;
  final String description;
  final int price;
  int amount = 0;
  Item(this.name, this.description, this.price, [this.amount = 0]);

  Item.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        price = json['price'],
        amount = json['amount'];

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "amount": amount,
    };
  }
}

class MyCartController extends GetxController {
  var cart = <Item>[].obs;
  var total = 0.obs;
  var request = ''.obs;
  var payMethod = '카드'.obs;
  var payStatus = false.obs;
  var longitude = ''.obs;
  var latitude = ''.obs;
  var client = ''.obs;

  void addItem(Item item) {
    if (cart.contains(item)) {
      cart[cart.indexOf(item)] =
          new Item(item.name, item.description, item.price, item.amount + 1);
      total.value += item.price;
    }
  }

  void removeItem(Item item) {
    if (cart.contains(item)) {
      if (cart[cart.indexOf(item)].amount == 1) {
        cart.remove(item);
      } else {
        cart[cart.indexOf(item)] =
            new Item(item.name, item.description, item.price, item.amount - 1);
        total.value -= item.price;
      }
    }
  }

  void clearCart() {
    cart.clear();
    total.value = 0;
  }

  void setCart(List<Item> newCart) {
    cart = [...newCart].obs;
    total.value = 0;
    for (var item in cart) {
      total.value += item.price * item.amount;
    }
  }

  void onOrder(String userEmail) {
    // 요청 메서드
    // 성공적이라면 payStatus = true
    // client = 사용자 이메일로 설정
    // true 반환
    // 아니라면 false 반환
  }
}

class UserInfoController extends GetxController {
  var userName = ''.obs;
  var userPhoneNumber = ''.obs;
  var userAddress = ''.obs;
  var userDetailAddress = ''.obs;
  var userEmail = ''.obs;
  var userPostCode = ''.obs;
  var token = ''.obs;
  final dio = Dio(BaseOptions(
    baseUrl: REQ_URL,
  ));

  void setUserName(String enteredName) {
    userName.value = enteredName;
  }

  void setUserPhoneNumber(String enteredPhoneNumber) {
    userPhoneNumber.value = enteredPhoneNumber;
  }

  void setUserAddress(String enteredAddress) {
    userAddress.value = enteredAddress;
  }

  void setUserDetailAddress(String enteredDetailAddress) {
    userDetailAddress.value = enteredDetailAddress;
  }

  void setUserEmail(String enteredEmail) {
    userEmail.value = enteredEmail;
  }

  void setUserPostCode(String enteredPostCode) {
    userPostCode.value = enteredPostCode;
  }

  Future<bool> getUserInfo(String? enteredUserEmail) async {
    if (enteredUserEmail == null) {
      return false;
    }
    final result = await dio.post(
      '/user/',
      data: {
        "userEmail": enteredUserEmail,
      },
    );
    if (result.data["isValid"] == false) {
      return false;
    }
    userName.value = result.data["userName"];
    userPhoneNumber.value = result.data["userPhoneNumber"];
    userAddress.value = result.data["userAddress"];
    userDetailAddress.value = result.data["userDetailAddress"];
    userEmail.value = result.data["userEmail"];
    userPostCode.value = result.data["userPostCode"];
    return true;
  }
}

class CreateUserController extends GetxController {
  var userName = ''.obs;
  var userPhoneNumber = ''.obs;
  var userAddress = ''.obs;
  var userDetailAddress = ''.obs;
  var userEmail = ''.obs;
  var userPostCode = ''.obs;
  var userPassword = ''.obs;
  final dio = Dio(
    BaseOptions(
      baseUrl: REQ_URL,
      receiveTimeout: Duration(seconds: 20),
      connectTimeout: Duration(seconds: 20),
      sendTimeout: Duration(seconds: 20),
    ),
  );

  void setUserName(String enteredName) {
    userName.value = enteredName;
  }

  void setUserPhoneNumber(String enteredPhoneNumber) {
    userPhoneNumber.value = enteredPhoneNumber;
  }

  void setUserAddress(String enteredAddress) {
    userAddress.value = enteredAddress;
  }

  void setUserDetailAddress(String enteredDetailAddress) {
    userDetailAddress.value = enteredDetailAddress;
  }

  void setUserEmail(String enteredEmail) {
    userEmail.value = enteredEmail;
  }

  void setUserPostCode(String enteredPostCode) {
    userPostCode.value = enteredPostCode;
  }

  void setUserPassword(String enteredPassword) {
    userPassword.value = enteredPassword;
  }

  Future<bool> createNewUser() async {
    try {
      final response = await dio.post(
        "/user/signup",
        data: {
          "userName": userName.value,
          "userEmail": userEmail.value,
          "userPassword": userPassword.value,
          "userPhoneNumber": userPhoneNumber.value,
          "userAddress": userAddress.value,
          "userDetailAddress": userDetailAddress.value,
          "userPostCode": userPostCode.value,
        },
      );
      if (response.data["created"] == true) {
        return true;
      }
      return false;
    } catch (error) {
      print("error: $error");
      return false;
    }
  }
}

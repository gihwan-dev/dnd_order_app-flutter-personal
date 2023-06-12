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

class Item {
  final String name;
  final String description;
  final int price;
  int amount = 0;
  Item(this.name, this.description, this.price, [this.amount = 0]);
}

class MyCartController extends GetxController {
  var cart = <Item>[].obs;
  var total = 0.obs;
  var request = ''.obs;
  var payMethod = ''.obs;
  var payStatus = false.obs;
  var longitude = ''.obs;
  var latitude = ''.obs;

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

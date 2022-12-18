// onBoarding models

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.image, this.subTitle);
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.currentIndex, this.numOfSlides);
}

//login models
/* بنعمل المودلز هنا تاني بس هنا مش هيبقي nullable هنستخدم ال mappers علشان ميبقاش فيه حاجه null ونفضل نتشيك فال view*/
class Customer {
  String id;
  String name;
  int numOfNotifications;

  Customer(this.id, this.name, this.numOfNotifications);
}

class Contacts {
  String phone;
  String email;
  String link;

  Contacts(this.phone, this.email, this.link);
}

class Authentication {
  Customer? customer;
  Contacts? contacts;

  Authentication(this.contacts, this.customer);
}

class Service {
  int id;
  String title;
  String image;

  Service(this.id, this.title, this.image);
}

class BannerAd {
  int id;
  String title;
  String image;
  String link;

  BannerAd(this.id, this.title, this.image, this.link);
}

class Store  {
  int id;
  String title;
  String image;

  Store(this.id, this.title, this.image);
}

class HomeData {
  List<Service> services;

  List<BannerAd> banners;

  List<Store> stores;

  HomeData(this.services, this.banners, this.stores);
}

class HomeObject {
  HomeData data;

  HomeObject(this.data);
}

class StoreDetails {
  int id;
  String title;
  String image;
  String details;
  String service;
  String aboutStore;

  StoreDetails(this.id, this.title, this.image, this.details, this.service,
      this.aboutStore);
}

# MINI-SuperApp

## Описание

**MINI Superapp** - ***универсальное приложение для управления финансами, заказа авиабилетов и доставки продуктов. Открывайте банковский счет, совершайте платежи и переводы, бронируйте авиабилеты и заказывайте продукты в удобном мобильном приложении. Оптимизируйте свою жизнь, используя MINI Superapp!***

## Скриншоты

<html>
 <body>
  <p>
    <img src="Screenshot/00.png" width="200">
    <img src="Screenshot/0.png" width="200">
    <img src="Screenshot/1.png" width="200">
    <img src="Screenshot/2.png" width="200">
    <img src="Screenshot/3.png" width="200">
    <img src="Screenshot/4.png" width="200">
    <img src="Screenshot/5.png" width="200">
  </p>
 </body>
</html>

## Функциональность

- БАНК
  
  Данные карт, шаблоны для оплаты, история транзакций, добавление новых карт и шаблонов оплаты
  
- АВИАБИЛЕТЫ

  ///

- КОРЗИНА

  Список всех покупок, сортировка по типу и стоимости, управление корзиной
  
- ДОСТАВКА ПРОДУКТОВ

  Продукты, категории, покупка, корзина, последние покупки, спецпредложения

- ПРОФИЛЬ

  Список избранного, уведомления, удаление учетной записи, выход из учетной записи, смена языка

## Технологии

Архитектура:
- Swift, VIPER + DI контейнеры (Builders)
- Сервер: Firebase, mock-объекты через mock-API, общение через Alamofire
- Изображения + кеш: SDWebImage
- Многопоточность: GCD
- Flow запуска приложения - Coordinator

Безопасность:
- Keychain
- FaceID, TouchID
- Firebase auth

Данные:
- Firebase storage, firestore, Realm (опционально)
- UserDefaults для хранения переменных состояний приложения

UI:
- UIKit (Layout через SnapKit)

Анимация:
- Lottie
- SkeletonView

SDK:
- MapKit
- CoreLocation

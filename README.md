# Emoji-Dictionary
Emoji Dictionary homework Swift Developer Stage 3

<img src="/screens/IMG_E5D8E46D044B-1.jpeg" width="19%">    <img src="/screens/IMG_DC1E0E29A1DA-1.jpeg" width="19%">    <img src="/screens/IMG_8743D919F347-1.jpeg" width="19%">

[Demo Video here](https://youtu.be/PgQQnNIt1bo)

## Main functionality
* Реализовано сохранение листа Эмоджи в emojis.plist
* emojis.plist интегрирован в комплект поставки приложения. Таким образом будучи загруженным впервые на устройство при первом запуске используется файл emojis.plist из Bundle.
Таким же образом всё работает и после удаления приложения и его повторной установки.
Далее в работе приложения используется папка Documents, доступ к которой открыт при помощи ключа Application supports iTunes file sharing
* реализовано перетаскивание между категориями
* реализован контроль ввода эмоджи
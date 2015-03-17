# Introduction #

Инсталацията на Apache2.2 с PHP под Windows е доста лесна...


# Details #

Сваляш последната версия на Apache от www.apache.org ( да не забравиш SSL-ще ни трябва )

Сваляш последната верия на PHP от www.php.net (installer-а разбира се)

Инсталираш Apache-то
Инсталираш PHPто (не пропускай да му кажеш пътя до httpd.conf на Apache-то като те пита)

В директорията /server/conf/httpd.conf има примерен конфигурационен файл за Apache.<br />
Променящ го според твоята машина-пътищата<br />
`DocumentRoot`<br />
`php_value include_path` <br />
`SSLCertificate*`<br />

Пускаш сървиса на Apache-то.

Ако ти даде грешка вероятно Skype или нещо друго ти е заело порт 80

C `netstat -b` можеш да видиш кое какво е заело.

Спираш нещата които ползват този порт-той е за HTTP.

Как да си направим RSA ключ като използваме `openssl`:<br />
http://www.vanemery.com/Linux/Apache/apache-SSL.html
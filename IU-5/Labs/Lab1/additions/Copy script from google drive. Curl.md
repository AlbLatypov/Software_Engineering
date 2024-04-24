# Copy script from google drive. Curl

Убедитесь, что у вас установлен утилита gdown. Если нет, установите ее с помощью pip:

`pip install gdown`

Если у вас нет pip, вы можете установить его следующим образом:

Для Debian/Ubuntu:

`sudo apt-get install python-pip`

Для RHEL/CentOS/Fedora:

`sudo yum install python-pip`

Получите ссылку на файл в Google Drive, как описано ранее: https://drive.google.com/file/d/FILE_ID/view?usp=sharing. Замените FILE_ID на идентификатор вашего файла.

Используйте gdown для скачивания файла с помощью ссылки на Google Drive:

`gdown --id FILE_ID -O script.sh`

Эта команда скачает файл скрипта с Google Drive и сохранит его под именем script.sh.

После скачивания вы можете сделать файл исполняемым и запустить его:

`chmod +x script.sh`
`./script.sh`

Теперь ваш скрипт должен быть скачан и запущен успешно.

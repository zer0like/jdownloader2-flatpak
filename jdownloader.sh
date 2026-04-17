#!/bin/sh
# JDownloader Flatpak Launcher

# Папка, где JDownloader будет реально жить и обновляться
JD_DIR="$XDG_DATA_HOME/jdownloader"
mkdir -p "$JD_DIR"

# Если в папке данных еще нет JAR-файла, копируем его из /app как начальный образ
if [ ! -f "$JD_DIR/JDownloader.jar" ]; then
    cp /app/share/java/JDownloader.jar "$JD_DIR/JDownloader.jar"
fi

cd "$JD_DIR"

# Запускаем из папки данных. Теперь у него будут права на запись.
# Принудительно отключаем headless режим.
exec java -Xmx512m -Djava.net.preferIPv4Stack=true -Djava.awt.headless=false -jar "$JD_DIR/JDownloader.jar" .

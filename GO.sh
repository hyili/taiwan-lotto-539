#!/bin/sh


run_once() {
    echo '<tr>'
    echo '<td style="background-color:#FFD382;padding:10px;margin-bottom:5px;border-radius:10px;width:50%;vertical-align:top">'
    echo '<h2 style="text-align:center"> '$1' ~ '$2' </h2>'
    echo '<p style="white-space: pre-wrap">'
    ./statistics.py $1 $2 $3 $4
    echo '</p>'
    echo '</td>'
    echo '<td style="background-color:#90EE90;padding:10px;margin-bottom:5px;border-radius:10px;width:50%;text-align:center;vertical-align:top">'
    echo '<h2> '$1' ~ '$2' </h2>'
    echo '<img src="'$4'" style="width:100%;height:auto;">'
    echo '</td>'
    echo '</tr>'
}


webpage="/usr/local/www/nginx/539/report.html"
date=$(TZ=Asia/Taipei date +"%Y-%m-%d %T")

if [ "$1" == "-y" ] || [ "$1" == "-Y" ]; then
    ./fetchCSV.sh
fi

echo '<meta charset="utf-8">' > $webpage
echo '<title>539加工廠</title>' >> $webpage

echo '<table style="width:100%">' >> $webpage
echo '<tr><th>2星3星 最常出現前20總計</th><th>各數字出現次數總計</th></tr>' >> $webpage
run_once 2019-01-01 2022-01-01 20 "img/2019-01-01_2022-01-01.png" >> $webpage
run_once 2019-01-01 2020-01-01 20 "img/2019-01-01_2020-01-01.png" >> $webpage
run_once 2020-01-01 2021-01-01 20 "img/2020-01-01_2021-01-01.png" >> $webpage
run_once 2021-01-01 2022-01-01 20 "img/2021-01-01_2022-01-01.png" >> $webpage

echo '</table>' >> $webpage

echo '<p>' >> $webpage
echo '最後更新時間: '$date >> $webpage
echo '</p>' >> $webpage


mv img/* /usr/local/www/nginx/539/img/

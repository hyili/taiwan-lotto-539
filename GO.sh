#!/bin/sh


run_once() {
    if [ "$5" == "0" ]; then
        echo '<tr id="run_once_tr_'$1'_'$2'" style="display:none">'
    else
        echo '<tr id="run_once_tr_'$1'_'$2'">'
    fi
    echo '<td style="background-color:#FFD382;padding:10px;margin-bottom:5px;border-radius:10px;width:50%;vertical-align:top">'
    echo '<a name='$1'_'$2'></a>'
    echo '<h2 style="text-align:center;margin-top:0px;margin-bottom:0px;"> '$1' ~ '$2' </h2>'
    echo '<p style="white-space: pre-wrap">'
    ./statistics.py $1 $2 $3 $4
    echo '</p>'
    echo '</td>'
    echo '<td style="background-color:#90EE90;padding:10px;margin-bottom:5px;border-radius:10px;width:50%;vertical-align:top">'
    echo '<h2 style="text-align:center;margin-top:0px;margin-bottom:0px;"> '$1' ~ '$2' </h2>'
    echo '<img src="'$4'" style="width:100%;height:auto;">'
    echo '</td>'
    echo '</tr>'
}

javascript_block() {
    echo '<script src="https://code.jquery.com/jquery-3.4.1.js"
                integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>'
    echo '<script>'
    echo '
    function hideTR(id) {
        var date = id.split("_");

        document.getElementById("run_once_tr_"+id).style.display = "none";
        document.getElementById("fast_travel_td_"+id).style.backgroundColor = "#B9B9FF";
        document.getElementById("fast_travel_a_"+id).onclick = function() { showTR(id) };
        document.getElementById("fast_travel_a_"+id).innerHTML = "顯示 " + date[0] + " ~ " + date[1];

        $.ajax({
            url: "operation.html",
            method: "GET",
            dataType: "json",
            data: {
                hide: true,
                id: id
            },

            success: function(res){console.log("Ok");},
            error: function(res){console.log("Ok");},
        });

        return true;
    }

    function showTR(id) {
        var date = id.split("_");

        document.getElementById("run_once_tr_"+id).style.display = "";
        document.getElementById("fast_travel_td_"+id).style.backgroundColor = "#CC0000";
        document.getElementById("fast_travel_a_"+id).onclick = function() { hideTR(id) };
        document.getElementById("fast_travel_a_"+id).innerHTML = "隱藏 " + date[0] + " ~ " + date[1];

        $.ajax({
            url: "operation.html",
            method: "GET",
            dataType: "json",
            data: {
                hide: false,
                id: id
            },

            success: function(res){console.log("Ok");},
            error: function(res){console.log("Ok");},
        });

        return true;
    }
    '
    echo '</script>'
}

other_link() {
    echo '<table>'
    echo '<tr><th>'
    echo '<td style="background-color:#FFD382;padding:10px;margin-bottom:5px;border-radius:10px;text-align:center;vertical-align:top">'
    echo '539加工廠'
    echo '</th><th>'
    echo '<td style="background-color:#90EE90;padding:10px;margin-bottom:5px;border-radius:10px;text-align:center;vertical-align:top">'
    echo '<a href="../fantasy5/report.html"> fantasy5加工廠 </a>'
    echo '</th><th>'
    echo '<td style="background-color:#FF6384;padding:10px;margin-bottom:5px;border-radius:10px;text-align:center;vertical-align:top">'
    echo '<a href="../539/rangeslider.html"> 539新功能測試區 </a>'
    echo '</th><th>'
    echo '<td style="background-color:#36A2EB;padding:10px;margin-bottom:5px;border-radius:10px;text-align:center;vertical-align:top">'
    echo '<a href="../539/formula.html"> 算法 </a>'
    echo '</th></tr>'
    echo '</table>'
}

fast_travel() {
    echo '<th>'
    if [ "$3" == "0" ]; then
        echo '<td id="fast_travel_td_'$1'_'$2'" style="background-color:#B9B9FF;padding:10px;margin-bottom:5px;border-radius:10px;text-align:center;vertical-align:top">'
        echo '<a id="fast_travel_a_'$1'_'$2'" onclick="return showTR('"'"$1'_'$2"'"')" href="report.html#'$1'_'$2'" style="font-size:12px"> 顯示 '$1' ~ '$2' </a>'
    else
        echo '<td id="fast_travel_td_'$1'_'$2'" style="background-color:#CC0000;padding:10px;margin-bottom:5px;border-radius:10px;text-align:center;vertical-align:top">'
        echo '<a id="fast_travel_a_'$1'_'$2'" onclick="return hideTR('"'"$1'_'$2"'"')" href="report.html#'$1'_'$2'" style="font-size:12px"> 隱藏 '$1' ~ '$2' </a>'
    fi
    echo '</th>'
}

webpage="/usr/local/www/nginx/539/report.html"
date=$(TZ=Asia/Taipei date +"%Y-%m-%d %T")

if [ "$1" == "-y" ] || [ "$1" == "-Y" ]; then
    ./fetchCSV.sh
fi

echo '<head>' > $webpage
echo '<meta charset="utf-8">' >> $webpage
echo '<title>539加工廠</title>' >> $webpage
echo '<link rel="icon" href="/favicon.ico">' >> $webpage

javascript_block >> $webpage
echo '</head>' >> $webpage

echo '<body>' >> $webpage
other_link >> $webpage

echo '<table style="width:100%">' >> $webpage
echo '<tr>' >> $webpage
fast_travel 2019-01-01 2022-01-01 0 >> $webpage
fast_travel 2010-01-01 2012-01-01 0 >> $webpage
fast_travel 2012-01-01 2014-01-01 0 >> $webpage
fast_travel 2014-01-01 2016-01-01 0 >> $webpage
fast_travel 2016-01-01 2018-01-01 0 >> $webpage
fast_travel 2018-01-01 2019-01-01 0 >> $webpage
fast_travel 2019-01-01 2020-01-01 0 >> $webpage
fast_travel 2020-01-01 2021-01-01 0 >> $webpage
fast_travel 2021-01-01 2022-01-01 1 >> $webpage
echo '</tr>' >> $webpage
echo '</table>' >> $webpage


echo '<table style="width:100%">' >> $webpage
echo '<tr><th style="padding:10px;margin-bottom:5px;border-radius:10px;width:50%;vertical-align:top">2星3星 最常出現前30總計</th><th style="padding:10px;margin-bottom:5px;border-radius:10px;width:50%;vertical-align:top">各數字出現次數總計</th></tr>' >> $webpage
run_once 2019-01-01 2022-01-01 30 "img/2019-01-01_2022-01-01.png" 0 >> $webpage
run_once 2010-01-01 2012-01-01 30 "img/2010-01-01_2012-01-01.png" 0 >> $webpage
run_once 2012-01-01 2014-01-01 30 "img/2012-01-01_2014-01-01.png" 0 >> $webpage
run_once 2014-01-01 2016-01-01 30 "img/2014-01-01_2016-01-01.png" 0 >> $webpage
run_once 2016-01-01 2018-01-01 30 "img/2016-01-01_2018-01-01.png" 0 >> $webpage
run_once 2018-01-01 2019-01-01 30 "img/2018-01-01_2019-01-01.png" 0 >> $webpage
run_once 2019-01-01 2020-01-01 30 "img/2019-01-01_2020-01-01.png" 0 >> $webpage
run_once 2020-01-01 2021-01-01 30 "img/2020-01-01_2021-01-01.png" 0 >> $webpage
run_once 2021-01-01 2022-01-01 30 "img/2021-01-01_2022-01-01.png" 1 >> $webpage

echo '</table>' >> $webpage

echo '<p style="white-space: pre-wrap">' >> $webpage
echo '最後更新時間(每4小時更新一次): '$date >> $webpage
echo '' >> $webpage
echo '原始資料來源網站：https://en.lottolyzer.com/history-export-csv/taiwan/daily-cash-539' >> $webpage
echo '</p>' >> $webpage
echo '</body>' >> $webpage


mv img/* /usr/local/www/nginx/539/img/


./transform_json.py 2008-01-01 2022-01-01
mv data_json/* /usr/local/www/nginx/539/data_json/

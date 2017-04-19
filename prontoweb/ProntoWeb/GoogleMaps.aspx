<%@ Page Language="VB"
    AutoEventWireup="false"
    MasterPageFile="~/MasterPage.master"
    CodeFile="GoogleMaps.aspx.vb" Inherits="GoogleMaps"
    Title="Informes" ValidateRequest="false" EnableEventValidation="false" %>


<%--https://jsfiddle.net/jitendravyas/f5ZLn/

https://developers.google.com/chart/interactive/docs/gallery/geochart#displaying-proportional-markers--%>


http://stackoverflow.com/questions/10142232/google-charts-geochart-zoom-in-closer

I had the same problem, and GeoChart proved to be too limited in that regard.

One option is to use Google Maps and Data Layers. If you need markers with colors and sizes, for example, you 
could do something like the example 
on the following page (see 'advanced style'): https://developers.google.com/maps/documentation/javascript/examples/layer-data-quakes

You'll need to implement your own interpolation to determine sizes and colors, but the 
resulting map/chart will be better than GeoChart alone.



<html>
  <head>
    <script type='text/javascript' src='https://www.gstatic.com/charts/loader.js'></script>
    <script type='text/javascript'>
        google.charts.load('current', { 'packages': ['geochart'] });
        google.charts.setOnLoadCallback(drawMarkersMap);

        function drawMarkersMap() {
            var data = google.visualization.arrayToDataTable([
              ['City', 'Population', 'Area'],
              ['Rome', 2761477, 1285.31],
              ['Milan', 1324110, 181.76],
              ['Naples', 959574, 117.27],
              ['Turin', 907563, 130.17],
              ['Palermo', 655875, 158.9],
              ['Genoa', 607906, 243.60],
              ['Bologna', 380181, 140.7],
              ['Florence', 371282, 102.41],
              ['Fiumicino', 67370, 213.44],
              ['Anzio', 52192, 43.43],
              ['Ciampino', 38262, 11]
            ]);

            var options = {
                region: 'IT',
                displayMode: 'markers',
                colorAxis: { colors: ['green', 'blue'] }
            };

            var chart = new google.visualization.GeoChart(document.getElementById('chart_div'));
            chart.draw(data, options);
        };
    </script>
  </head>
  <body>
    <div id="chart_div" style="width: 900px; height: 500px;"></div>
  </body>
</html>
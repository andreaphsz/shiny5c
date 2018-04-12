help.html <- paste0('
<div class="tab-content" data-tabsetid="9999">

<div class="tab-pane active" data-value="map" id="tab-9999-1">
<h4>The tab [Map <i class="fa fa-globe" aria-hidden="true"></i>] provides a geographical perspective on the data, based on an interactive map.</h4>
Features:
<ul>
<li><b>"Region"</b><br>
  Select the region on the map that you are interested in</li>
<li><b>"Dimension/factor"</b><br>
  Select which factor or dimension you want to look at
  <ul>
    <li>Importance: 5C career success dimensions, importance scores</li>
    <li>Achievement: 5C career success dimensions, achievement scores</li>
    <li>Gap: 5C career success dimensions, difference between achievement and importance scores</li>
    <li>Individual factors: Individual-level variables, aggregated at country-level (e.g., perceived supervisor support)</li>
    <li>Country factors: Country-level variables (e.g., GDP, Gini coefficient)</li>
  </ul>
  <li>Based on the preselected factor/dimension, choose the specific variable from the dropdown menu below</li>
  <li>Display country names and selected country scores when moving the mouse over the map</li>
  <li><b>"Colors"</b><br>
    Choose between two color-schemes (default or optimized for color-blind users)</li>
  <li><b>"Download Map"</b><br>
    Download the map as an HTML-file</li>
  <li><b>"Variables"</b><br>
    For an overview of all variables, variable descriptions, sample items and scale references, see the <i>Variables</i> section inside this tab.</li>
</ul>
</div>

<div class="tab-pane" data-value="success" id="tab-9999-2">
<h4>The tab [Success Factors <i class="fa fa-bar-chart" aria-hidden="true"></i>] allows the comparison of a broad range of career success variables between one or multiple countries.</h4>
Features:
<ul>
  <li><b>"Countries"</b><br>
    Select/deselect the country/countries you are interested in.<br>
    To add a country, click in the “countries” field and select the country from the dropdown menu that appears. To remove a country from the selection, highlight the name in the “country” field and delete it.</li>
  <li><b>"Importance"</b><br>
    Select/deselect the 5C career success dimension(s) you are interested in (importance scores).</li>
  <li><b>"Achievement"</b><br>
    Select/deselect the 5C career success dimension(s) you are interested in (achievement scores). </li>
  <li><b>"Gap"</b><br>
    Select/deselect the 5C career success gaps (i.e., achievement minus importance) in the dimension(s) you are interested in.</li>
  <li><b>"x-Axis"</b><br>
    Choose whether selected countries or selected 5C dimensions should appear on the x-axis.</li>
  <li><b>"Download Plot"</b><br>
    Download the selected plot as a png-file.</li>
  <li><b>"Variables"</b><br>
    For an overview of all variables, variable descriptions, sample items and scale references, see the <i>Variables</i> section inside this tab.</li>
</ul>
</div>

<div class="tab-pane" data-value="multi" id="tab-9999-3">
<h4>The tab [Multidimensional Views <i class="fa fa-line-chart" aria-hidden="true"></i>] allows a multi-dimensional view on preselected multiple variables and countries.</h4>
Features:
<ul>
  <li><b>"Clusters/Countries"</b><br>
    Select/deselect whether the focus is on country clusters (e.g., Latin America) or individual countries.<br>
    To remove a country or cluster from the selection, highlight the name in the “clusters/countries” field and delete it. To add a country or cluster, click in the field and select the country or cluster from the dropdown menu that appears.</li>
  <li><b>"x-Axis"</b><br>
    Select which factor or dimension you want to look at on the x-axis:
  <ul>
    <li>Importance: 5C career success dimensions, importance scores</li>
    <li>Achievement: 5C career success dimensions, achievement scores</li>
    <li>Gap: 5C career success dimensions, difference between achievement and importance scores</li>
    <li>Individual factors: Individual-level variables, aggregated at country-level (e.g., perceived supervisor support)</li>
    <li>Country factors: Country-level variables (e.g., GDP, Gini coefficient)</li>
  </ul></li>
  <li><b>"y-Axis"</b><br>
    Select which factor or dimension you want to look at on the y-axis:
  <ul>
    <li>Importance: 5C career success dimensions, importance scores</li>
    <li>Achievement: 5C career success dimensions, achievement scores</li>
    <li>Gap: 5C career success dimensions, difference between achievement and importance scores</li>
    <li>Individual factors: Individual-level variables, aggregated at country-level (e.g., perceived supervisor support)</li>
    <li>Country factors: Country-level variables (e.g., GDP, Gini coefficient)</li>
  </ul></li>
  <li><b>"Size"</b><br>
    Select which factor or dimension should be used as the third dimension. The selected variable will be displayed using the size of the data points in the matrix:
  <ul>
    <li>None: No third variable will be added, all data points are of equal size</li>
    <li>Importance: 5C career success dimensions, importance scores</li>
    <li>Achievement: 5C career success dimensions, achievement scores</li>
    <li>Gap: 5C career success dimensions, difference between achievement and importance scores</li>
    <li>Individual factors: Individual-level variables, aggregated at country-level (e.g., perceived supervisor support)</li>
    <li>Country factors: Country-level variables (e.g., GDP, Gini coefficient)</li>
  </ul></li>
  <li><b>"Download Plot"</b><br>
    Download the selected plot as a png-file.</li>
  <li><b>"Variables"</b><br>
    For an overview of all variables, variable descriptions, sample items and scale references, see the <i>Variables</i> section inside this tab.</li>
</ul>
</div>

<div class="tab-pane" data-value="infotab" id="tab-9999-4">
<h4>Variables</h4>
', print.xtable(xtable(info.tab), type="html", print.results=FALSE, include.rownames=FALSE,
                html.table.attributes="style='border: 0; padding: 10px;'"),
'
</div>

</div>
')

about.html <- '
<div class="tab-content" data-tabsetid="9998">

<div class="tab-pane active" data-value="aboutus" id="tab-9998-1">
<h4>About us</h4>
<p>This visualization tool is based on the 5C project (Cross-Cultural Collaboration on Contemporary Careers), a global research collaboration that aims to study careers and career success across various cultures and generations. For this visualization, data of 15,900 [update with latest figures] individuals (49.8% female, average age: 41 years) from 25 countries [update with latest figures] from all global cultural clusters were analyzed. Participants work in one of four broad occupational fields, namely, as managers, professionals, clerical/service workers or skilled labor. Data are not representative for each country. Data were collected between summer 2015 and autumn 2016, using an online survey available in the native language(s) for each country.</p>
<br>
<p><b>Disclaimer</b><p>
<p>The 5C consortium is providing this data visualisation for your convenience only. Please note however that no warranty, representation, guarantee or legally binding description is provided by publishing this informational data, nor does the 5C consortium acknowledge or accept any liability related thereto. The detailed documentation and data of 5C-related studies can be found in our officially published academic journals and books.</p>
<p><b>Further information</b>
<ul>
  <li><a href="https://5c.careers/" target="_blank">5C.careers</a></li>
</ul></p>
<p><b>Contact</b>
<ul>
  <li>[WOLFGANG? JON? …?]</li>
</ul></p>
<p><b>Tool hosting and maintenance</b>
<ul>
<li>Dominik Zellhofer, WU Vienna, Vienna, Austria (<a href="https://www.wu.ac.at/" target="_blank">www.wu.ac.at</a>)</li>
</ul></p>
<p><b>Tool development:</b>
<ul>
<li>Andrea Cantieni, Schwyz University of Teacher Education, Goldau, Switzerland (<a href="https://www.phsz.ch/en/" target="_blank">www.phsz.ch</a>)</li>
<li>Martin Gubler, Schwyz University of Teacher Education, Goldau, Switzerland (<a href="https://www.phsz.ch/en/" target="_blank">www.phsz.ch</a>)</li>
<li>Rick Cotton, University of Victoria, Victoria, Canada (<a href="https://www.uvic.ca/" target="_blank">www.uvic.ca</a>)</li>
<li>Dominik Zellhofer, WU Vienna, Vienna, Austria (<a href="https://www.wu.ac.at/" target="_blank">www.wu.ac.at</a>)</li>
</ul></p>
</div>

<div class="tab-pane" data-value="techdet" id="tab-9998-2">
<h4>Technical details</h4>
This visualisation tool is highly inspired by the <a href="https://rstudio.stat.washington.edu/shiny/wppExplorer/inst/explore/" target="_blank">WPP 2017 Explorer</a>. It runs on a <a href="https://www.rstudio.com/products/shiny/" target="_blank">Shiny server</a> and uses <a href="https://developers.google.com/chart/" target="_blank">Google Charts</a> to show the world map. The world map implementation is done via the fantastic R package <a href="https://cran.r-project.org/web/packages/googleVis/" target="_blank">googleVis: R Interface to Google Charts</a>. The bar charts and the scatter plots are build using <a href="https://cran.r-project.org/web/packages/ggplot2/index.html" target="_blank">ggplot2</a>. The default color scheme is implemented via <a href="https://cran.r-project.org/web/packages/viridis/index.html" target="_blank">viridis: Default Color Maps from \'matplotlib\'</a>. And finally the logos on the top are placed as desrcibed under <a href="http://candrea.ch/blog/adding-multiple-company-logos-to-shiny-app/" target="_blank">Adding multiple Company Logos to Shiny App</a>.
</div>

</div>
'

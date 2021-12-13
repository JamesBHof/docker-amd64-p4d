/*
 *  list.js
 *
 *  (c) 2020-2021 Jörg Wendel
 *
 * This code is distributed under the terms and conditions of the
 * GNU GENERAL PUBLIC LICENSE. See the file COPYING for details.
 *
 */

function initList()
{
   if (allSensors == null)
   {
      console.log("Fatal: Missing widgets!");
      return;
   }

   $('#stateContainer').removeClass('hidden');
   $('#container').removeClass('hidden');

   document.getElementById("container").innerHTML = '<div id="listContainer" class="rounded-border listContainer"</div>';
   var root = document.getElementById("listContainer");

   // state

   document.getElementById("stateContainer").innerHTML =
      '<div id="stateContainerS3200" class="rounded-border heatingState"></div>' +
      '<div id="stateContainerImage" class="rounded-border imageState"></div>' +
      '<div id="stateContainerP4" class="rounded-border daemonState"></div>';

   // heating state

   var rootStateS3200 = document.getElementById("stateContainerS3200");

   switch (s3200State.state) {
      case 0:  style = "aStateFail";     break;
      case 3:  style = "aStateHeating";  break;
      case 19: style = "aStateOk";       break;
      default: style = "aStateOther"
   }

   d = new Date(s3200State.time * 1000);

   html = '<div><span id="' + style + '">' + s3200State.stateinfo + '</span></div>\n';
   html += '<br/>\n';
   html += '<div style="display:flex;"><span style="width:30%;display:inline-block;">Uhrzeit:</span><span>' + d.toLocaleTimeString() + '</span></div>\n';
   html += '<div style="display:flex;"><span style="width:30%;display:inline-block;">Betriebsmodus: </span><span>' + s3200State.modeinfo + '</span></div>\n';

   rootStateS3200.innerHTML = html;

   // state image
   var rootStateImage = document.getElementById("stateContainerImage");

   html = '<img src="' + s3200State.image + '">\n';

   rootStateImage.innerHTML = html;

   // daemon state
   var rootStateP4 = document.getElementById("stateContainerP4");

   if (daemonState.state != null && daemonState.state == 0)
   {
      html =  '<div id="aStateOk"><span style="text-align: center;">Heating Control ONLINE</span></div>';
      html +=  '<br/>\n';
      html +=  '<div style="display:flex;"><span style="width:30%;display:inline-block;">Läuft seit:</span><span display="inline-block">' + daemonState.runningsince + '</span></div>\n';
      html +=  '<div style="display:flex;"><span style="width:30%;display:inline-block;">Version:</span> <span display="inline-block">' + daemonState.version + '</span></div>\n';
      html +=  '<div style="display:flex;"><span style="width:30%;display:inline-block;">CPU-Last:</span><span display="inline-block">' + daemonState.average0 + " " + daemonState.average1 + ' '  + daemonState.average2 + ' ' + '</span></div>\n';
   }
   else
   {
      html = '<div id="aStateFail">ACHTUNG:<br/>Heating Control OFFLINE</div>\n';
   }

   rootStateP4.innerHTML = html;

   // clean page content

   root.innerHTML = "";

   var elem = document.createElement("div");
   elem.className = "chartTitle rounded-border";

   // build page content

   for (var key in allSensors) {
      var sensor = allSensors[key];
      var elemId = key.replace(':', '_'); // don't know why but : not working for image :o
      var fact = valueFacts[key];

      if (fact == null) {
         console.log("Fact for sensor '" + key + "' not found, ignoring");
         continue;
      }

      var title = fact.usrtitle != '' && fact.usrtitle != null ? fact.usrtitle : fact.title;
      var html = "";

      if (fact.widget.widgettype == 0) {                                             // Symbol
         if (localStorage.getItem(storagePrefix + 'Rights') & fact.rights)
            html += '   <div class="listFirstCol" onclick="toggleIo(' + fact.address + ",'" + fact.type + '\')"><img id="widget' + elemId + '"/></div>\n';
         else
            html += '   <div class="listFirstCol"><img id="widget' + elemId + '"/></div>\n';
      }
      else if (fact.widget.widgettype == 2 || fact.widget.widgettype == 8) {         // Text, Choice
         html += '<div class="listFirstCol" id="widget' + elemId + '"></div>';
      }
      else {
         html += '<span class="listFirstCol" id=widget' + elemId + '">' + (sensor.value ? sensor.value.toFixed(2) : '-') + '&nbsp;' + fact.widget.unit;
         html += '&nbsp; <p style="display:inline;font-size:12px;font-style:italic;">(' + (sensor.peak != null ? sensor.peak.toFixed(2) : '  ') + ')</p>';
         html += '</span>';
      }

      html += '<span class="listSecondCol listText" >' + title + '</span>';

      var elem = document.createElement('div');
      elem.className = 'listRow';
      elem.innerHTML = html;
      root.appendChild(elem);
   }

   updateList();
}

function updateList()
{
   for (var key in allSensors) {
      var sensor = allSensors[key];
      var fact = valueFacts[key];

      if (fact == null) {
         console.log("Fact for widget '" + key + "' not found, ignoring");
         continue;
      }

      var elemId = "#widget" + key.replace(':', '_');

      if (fact.widget.widgettype == 1 || fact.widget.widgettype == 3) {
         var peak = sensor.peak != null ? sensor.peak.toFixed(2) : "  ";
         $(elemId).html(sensor.value.toFixed(2) + "&nbsp;" + fact.widget.unit +
                        "&nbsp; <p style=\"display:inline;font-size:12px;font-style:italic;\">(" + peak + ")</p>");
      }
      else if (fact.widget.widgettype == 0) {   // Symbol
         var image = sensor.value != 0 ? fact.widget.imgon : fact.widget.imgoff;
         $(elemId).attr("src", image);
      }
      else if (fact.widget.widgettype == 2 || fact.widget.widgettype == 7) {   // Text, PlainText
         $(elemId).html(sensor.text);
      }
      else {
         if (sensor.value == null)
            console.log("Missing value for " + key);
         else
            $(elemId).html(sensor.value.toFixed(0));
      }

      // console.log(i + ") " + fact.widget.widgettype + " : " + title + " / " + sensor.value + "(" + id + ")");
   }
}

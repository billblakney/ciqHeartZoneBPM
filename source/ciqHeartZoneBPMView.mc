using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.UserProfile as Profile;

class ciqHeartZoneBPMView extends Ui.DataField
{
   /** default back/foreground colors */
   var defaultBgColor = Gfx.COLOR_WHITE;
   var defaultFgColor = Gfx.COLOR_BLACK;

   /** heart zone definitions */
   var beginZone1;
   var beginZone2;
   var beginZone3;
   var beginZone4;
   var beginZone5;

   /** lowest hilite zone */
   var hiliteZone = 1;

   /**
    * zone fore/background colors
    * back1, fore1, back2, fore2, ..., back5, fore5
    */
   var zoneColors = new [10];

   /** monitored heart rate */
   hidden var mHeartRate;

   /** drawable for background */
   hidden var background;

   /** drawable for value */
   hidden var value;

   /*-------------------------------------------------------------------------
    *------------------------------------------------------------------------*/
   function initialize()
   {
      DataField.initialize();

      mHeartRate = 0;
           
      initializeZoneColors();

      getZonesFromUserProfile();
   }

   /*-------------------------------------------------------------------------
    * TODO default colors per default bg
    *------------------------------------------------------------------------*/
   function initializeZoneColors()
   {
//      zoneColors[0] = Gfx.COLOR_WHITE;
//      zoneColors[1] = Gfx.COLOR_BLACK;
//      zoneColors[2] = Gfx.COLOR_WHITE;
//      zoneColors[3] = Gfx.COLOR_BLACK;
//      zoneColors[4] = Gfx.COLOR_WHITE;
//      zoneColors[5] = Gfx.COLOR_BLACK;
//      zoneColors[6] = Gfx.COLOR_WHITE;
//      zoneColors[7] = Gfx.COLOR_BLACK;
//      zoneColors[8] = Gfx.COLOR_WHITE;
//      zoneColors[9] = Gfx.COLOR_BLACK;

//      zoneColors[0] = 8;
//      zoneColors[1] = 3;
//      zoneColors[2] = 7;
//      zoneColors[3] = 3;
//      zoneColors[4] = 6;
//      zoneColors[5] = 0;
//      zoneColors[6] = 4;
//      zoneColors[7] = 0;
//      zoneColors[8] = 5;
//      zoneColors[9] = 0;

      zoneColors[0] = Gfx.COLOR_BLUE;
      zoneColors[1] = Gfx.COLOR_BLACK;
      zoneColors[2] = Gfx.COLOR_BLUE;
      zoneColors[3] = Gfx.COLOR_BLACK;
      zoneColors[4] = Gfx.COLOR_ORANGE;
      zoneColors[5] = Gfx.COLOR_WHITE;
      zoneColors[6] = Gfx.COLOR_RED;
      zoneColors[7] = Gfx.COLOR_WHITE;
      zoneColors[8] = Gfx.COLOR_DK_RED;
      zoneColors[9] = Gfx.COLOR_WHITE;
   }

   /*-------------------------------------------------------------------------
    *------------------------------------------------------------------------*/
   function getUserSettings() {

      hiliteZone = App.getApp().getProperty("hiliteZone");
//      Sys.println("hiliteZone: " + hiliteZone);

      useBlackBack = App.getApp().getProperty("useBlackBack");

      var zone1BgColorNum = App.getApp().getProperty("z1BgColor");
      var zone1FgColorNum = App.getApp().getProperty("z1FgColor");
      var zone2BgColorNum = App.getApp().getProperty("z2BgColor");
      var zone2FgColorNum = App.getApp().getProperty("z2FgColor");
      var zone3BgColorNum = App.getApp().getProperty("z3BgColor");
      var zone3FgColorNum = App.getApp().getProperty("z3FgColor");
      var zone4BgColorNum = App.getApp().getProperty("z4BgColor");
      var zone4FgColorNum = App.getApp().getProperty("z4FgColor");
      var zone5BgColorNum = App.getApp().getProperty("z5BgColor");
      var zone5FgColorNum = App.getApp().getProperty("z5FgColor");

//      zoneColors[0] = getColorCode(zone1BgColorNum);
//      zoneColors[1] = getColorCode(zone1FgColorNum);
//      zoneColors[2] = getColorCode(zone2BgColorNum);
//      zoneColors[3] = getColorCode(zone2FgColorNum);
//      zoneColors[4] = getColorCode(zone3BgColorNum);
//      zoneColors[5] = getColorCode(zone3FgColorNum);
//      zoneColors[6] = getColorCode(zone4BgColorNum);
//      zoneColors[7] = getColorCode(zone4FgColorNum);
//      zoneColors[8] = getColorCode(zone5BgColorNum);
//      zoneColors[9] = getColorCode(zone5FgColorNum);
   }
   
   /*-------------------------------------------------------------------------
    *------------------------------------------------------------------------*/
   function getZonesFromUserProfile()
   {
      var sport = Profile.getCurrentSport();
//      Sys.println("currentSport: " + sport);
      var zones = Profile.getHeartRateZones(sport);

      beginZone1 = zones[0];
      beginZone2 = zones[1] + 1;
      beginZone3 = zones[2] + 1;
      beginZone4 = zones[3] + 1;
      beginZone5 = zones[4] + 1;
//      Sys.println("beginZone1: " + beginZone1);
//      Sys.println("beginZone2: " + beginZone2);
//      Sys.println("beginZone3: " + beginZone3);
//      Sys.println("beginZone4: " + beginZone4);
//      Sys.println("beginZone5: " + beginZone5);
   }

   /*-------------------------------------------------------------------------
    *------------------------------------------------------------------------*/
   function onLayout(dc)
   {
      var width = dc.getWidth();
      var height = dc.getHeight();
      var obscurityFlags = DataField.getObscurityFlags();
      
      setLayout(dc,width,height,obscurityFlags);
      
//      Sys.println("layout: " + layout);
      
      background = View.findDrawableById("Background");
      value = View.findDrawableById("value");
      
      return true;
   }

   /*-------------------------------------------------------------------------
    *------------------------------------------------------------------------*/
    function compute(info)
    {
        // See Activity.Info in the documentation for available information.
        if(info has :currentHeartRate){
            if(info.currentHeartRate != null){
                mHeartRate = info.currentHeartRate;
            } else {
                mHeartRate = 0;
            }
        }
    }

   /*-------------------------------------------------------------------------
    * Display the value you computed here. This will be called
    * once a second when the data field is visible.
    *------------------------------------------------------------------------*/
    function onUpdate(dc)
    {
       dc.setColor(defaultFgColor,defaultBgColor);
       dc.clear();

hiliteZone = 1;
       var zone = getZone(mHeartRate);

       // get zone background color
       var zoneBgColor = defaultBgColor;
       if (zone >= hiliteZone) {
          zoneBgColor = zoneColors[2*(zone-1)];
       }

       // get zone foreground color
       var zoneFgColor = defaultFgColor;
       if (zone >= hiliteZone) {
          zoneFgColor = zoneColors[2*(zone-1)+1];
       }

       //Sys.println("zone,bg,fg: "
       //   + zone + "," + zoneBgColor + "," + zoneFgColor);

       /*
        * Draw backdrop. If below the hilite zone, fill with the default bg
        * color, and draw text with default fg color.
        */
       if (background != null) {
          background.setBorderColor(zoneBgColor);
          if (zone < hiliteZone) {
             background.setBackColor(defaultBgColor);
          }
          else {
             background.setBackColor(zoneBgColor);
          }
          background.draw(dc);
       }

       /*
        * Draw the heart rate.
        */
       value.setText(toStr(mHeartRate));
       //        value.setText(mHeartRate.format("%2f"));
       if (zone < hiliteZone) {
          value.setColor(defaultFgColor);
       }
       else {
          value.setColor(zoneFgColor);
       }
       value.draw(dc);
    }

//   /*-------------------------------------------------------------------------
//    *------------------------------------------------------------------------*/
//    function getZoneBgColor(zone)
//    {
//       if (zone == 0) {
//          return defaultBgColor;
//       }
//       else {
//          return zoneColors[2*(zone-1)];
//       }
//    }

//   /*-------------------------------------------------------------------------
//    *------------------------------------------------------------------------*/
//    function getZoneFgColor(zone)
//    {
//       if (zone == 0) {
//          return defaultFgColor;
//       }
//       else {
//          return zoneColors[2*(zone-1)+1];
//       }
//    }
    
   /*-------------------------------------------------------------------------
    * Display the value you computed here. This will be called
    * once a second when the data field is visible.
    *------------------------------------------------------------------------*/
    function getZone(heartRate)
    {
       var zone = 0;

       if (heartRate >= beginZone5) {
          zone = 5;
       } else if (heartRate >= beginZone4) {
          zone = 4;
       } else if (heartRate >= beginZone3) {
          zone = 3;
       } else if (heartRate >= beginZone2) {
          zone = 2;
       } else if (heartRate >= beginZone1) {
          zone = 1;
       }
       
       return zone;
    }

   /*-------------------------------------------------------------------------
    *------------------------------------------------------------------------*/
   function toStr(o) {
      if (o != null && o > 0) {
         return "" + o;
      } else {
         return "---";
      }
   }

   /*-------------------------------------------------------------------------
    * Compact version, optimized for size.
    * Saves about 1kB of run-time memory.
    *------------------------------------------------------------------------*/
   function setLayout(dc,width,height,obscurity)
   {
      var id = 1000*obscurity + width + height;

      if (id == 15395 /*fr*/ || id == 15436 /*fx*/) {
            View.setLayout(Rez.Layouts.All(dc));
      }
      else if (id == 7304 /*fr*/ || id == 7326 /*fx*/) {
            View.setLayout(Rez.Layouts.TopHalf(dc));
      }
      else if (id == 13304 /*fr*/ || id == 13326 /*fx*/) {
            View.setLayout(Rez.Layouts.BotHalf(dc));
      }
      else if (id == 7270 /*fr*/ || id == 7288 /*fx*/) {
            View.setLayout(Rez.Layouts.TopThird(dc));
      }
      else if (id == 5281 /*fr*/ || id == 5292 /*fx*/) {
            View.setLayout(Rez.Layouts.MidThird(dc));
      }
      else if (id == 13270 /*fr*/ || id == 13288 /*fx*/) {
            View.setLayout(Rez.Layouts.BotThird(dc));
      }
      else if (id == 1173 /*fr*/ || id == 1182 /*fx*/) {
            View.setLayout(Rez.Layouts.LeftMidThird(dc));
      }
      else if (id == 4173 /*fr*/ || id == 4182 /*fx*/) {
            View.setLayout(Rez.Layouts.RightMidThird(dc));
      }
      else if (id == 3216 /*fx*/) {
            View.setLayout(Rez.Layouts.TopLeftQuad(dc));
      }
      else if (id == 6216 /*fx*/) {
            View.setLayout(Rez.Layouts.TopRightQuad(dc));
      }
      else if (id == 9216 /*fx*/) {
            View.setLayout(Rez.Layouts.BotLeftQuad(dc));
      }
      else if (id == 12216 /*fx*/) {
            View.setLayout(Rez.Layouts.BotRightQuad(dc));
      }
      else {
            View.setLayout(Rez.Layouts.All(dc));
      }
   }
}

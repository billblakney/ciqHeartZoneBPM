using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
//using Toybox.System as Sys;
using Toybox.UserProfile as Profile;
using Toybox.Application as App;

class HeartZoneBPMView extends Ui.DataField
{
   const COLOR_IDX_WHITE    = 0;
   const COLOR_IDX_LT_GRAY  = 1;
   const COLOR_IDX_DK_GRAY  = 2;
   const COLOR_IDX_BLACK    = 3;
   const COLOR_IDX_RED      = 4;
   const COLOR_IDX_DK_RED   = 5;
   const COLOR_IDX_ORANGE   = 6;
   const COLOR_IDX_YELLOW   = 7;
   const COLOR_IDX_GREEN    = 8;
   const COLOR_IDX_DK_GREEN = 9;
   const COLOR_IDX_BLUE     = 10;
   const COLOR_IDX_DK_BLUE  = 11;
   const COLOR_IDX_PURPLE   = 12;
   const COLOR_IDX_PINK     = 13;

   /** default back/foreground colors */
   var defaultBgColor;
   var defaultFgColor;

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

   /**
    * zone and zone colors for update
    * (could move to update to save some bytes)
    */
   hidden var zone;
   hidden var zoneBgColor;
   hidden var zoneFgColor;

   /** drawable */
   hidden var painter;

   /*-------------------------------------------------------------------------
    *------------------------------------------------------------------------*/
   function initialize()
   {
      DataField.initialize();

      mHeartRate = 0;
      
      defaultBgColor = getBackgroundColor();
      if (defaultBgColor == Gfx.COLOR_WHITE) {
         defaultFgColor = Gfx.COLOR_BLACK;
      }
      else {
         defaultFgColor = Gfx.COLOR_WHITE;
      }
           
      initializeZoneColors();

      getZonesFromUserProfile();

      getUserSettings();
   }

   /*-------------------------------------------------------------------------
    * TODO default colors per default bg
    *------------------------------------------------------------------------*/
   function initializeZoneColors()
   {
      zoneColors[0] = Gfx.COLOR_GREEN;
      zoneColors[1] = Gfx.COLOR_BLACK;
      zoneColors[2] = Gfx.COLOR_GREEN;
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

      zoneColors[0] = getColorCode(zone1BgColorNum);
      zoneColors[1] = getColorCode(zone1FgColorNum);
      zoneColors[2] = getColorCode(zone2BgColorNum);
      zoneColors[3] = getColorCode(zone2FgColorNum);
      zoneColors[4] = getColorCode(zone3BgColorNum);
      zoneColors[5] = getColorCode(zone3FgColorNum);
      zoneColors[6] = getColorCode(zone4BgColorNum);
      zoneColors[7] = getColorCode(zone4FgColorNum);
      zoneColors[8] = getColorCode(zone5BgColorNum);
      zoneColors[9] = getColorCode(zone5FgColorNum);
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
hiliteZone = 6; //TODO rm
      var width = dc.getWidth();
      var height = dc.getHeight();
      var obscurityFlags = DataField.getObscurityFlags();
      
      setLayout(dc,width,height,obscurityFlags);
//      var layout = setLayout(dc,width,height,obscurityFlags);
//      Sys.println("layout: " + layout);
      
      painter = View.findDrawableById("Painter");
//      Sys.println("painter: " + painter);
      painter.normalize(width,height);
      
      return true;
   }

   /*-------------------------------------------------------------------------
    *------------------------------------------------------------------------*/
    function compute(info)
    {
        // Get the current heart rate.
        if(info has :currentHeartRate){
            if(info.currentHeartRate != null){
                mHeartRate = info.currentHeartRate;
            } else {
                mHeartRate = 0;
            }
        }

       // Get zone and zone colors.
       zone = getZone(mHeartRate);
       if (zone > 0) {
          zoneBgColor = zoneColors[2*(zone-1)];
          zoneFgColor = zoneColors[2*(zone-1)+1];
       }
       else {
          zoneBgColor = defaultBgColor;
          zoneFgColor = defaultFgColor;
       }

       //Sys.println("zone,bg,fg: "
       //   + zone + "," + zoneBgColor + "," + zoneFgColor);
    }

   /*-------------------------------------------------------------------------
    * Display the value you computed here. This will be called
    * once a second when the data field is visible.
    *------------------------------------------------------------------------*/
    function onUpdate(dc)
    {
       /*
        * Set dc colors.
        */
       if (zone < hiliteZone) {
          painter.drawBackground(dc,defaultBgColor);
          painter.drawZoneBar(dc,zoneBgColor);
          painter.drawText(dc,defaultFgColor,defaultBgColor,toStr(mHeartRate));
       }
       else {
          painter.drawBackground(dc,zoneBgColor);
          painter.drawText(dc,zoneFgColor,zoneBgColor,toStr(mHeartRate));
       }
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
    *------------------------------------------------------------------------*/
   function textC(dc, x, y, font, s) {
      if (s != null) {
         dc.drawText(x, y, font, s, Graphics.TEXT_JUSTIFY_CENTER);
      }
   }

   /*-------------------------------------------------------------------------
    *------------------------------------------------------------------------*/
   function getColorCode(color_index) {

      if (color_index == COLOR_IDX_WHITE) {
         return Graphics.COLOR_WHITE;
      }
      else if (color_index == COLOR_IDX_LT_GRAY) {
         return Graphics.COLOR_LT_GRAY;
      }
      else if (color_index == COLOR_IDX_DK_GRAY) {
         return Graphics.COLOR_DK_GRAY;
      }
      else if (color_index == COLOR_IDX_BLACK) {
         return Graphics.COLOR_BLACK;
      }
      else if (color_index == COLOR_IDX_RED) {
         return Graphics.COLOR_RED;
      }
      else if (color_index == COLOR_IDX_DK_RED) {
         return Graphics.COLOR_DK_RED;
      }
      else if (color_index == COLOR_IDX_ORANGE) {
         return Graphics.COLOR_ORANGE;
      }
      else if (color_index == COLOR_IDX_YELLOW) {
         return Graphics.COLOR_YELLOW;
      }
      else if (color_index == COLOR_IDX_GREEN) {
         return Graphics.COLOR_GREEN;
      }
      else if (color_index == COLOR_IDX_DK_GREEN) {
         return Graphics.COLOR_DK_GREEN;
      }
      else if (color_index == COLOR_IDX_BLUE) {
         return Graphics.COLOR_BLUE;
      }
      else if (color_index == COLOR_IDX_DK_BLUE) {
         return Graphics.COLOR_DK_BLUE;
      }
      else if (color_index == COLOR_IDX_PURPLE) {
         return Graphics.COLOR_PURPLE;
      }
      else if (color_index == COLOR_IDX_PINK) {
         return Graphics.COLOR_PINK;
      }
      else {
         return Graphics.COLOR_ORANGE;
//         Sys.println("ERROR: unknown color: " + color_index);
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
      else if (id == 7304 /*fr*/ || id == 7326 /*fx*/ || id == 278) {
            View.setLayout(Rez.Layouts.TopHalf(dc));
      }
      else if (id == 13304 /*fr*/ || id == 13326 /*fx*/) {
            View.setLayout(Rez.Layouts.BotHalf(dc));
      }
      else if (id == 7270 /*fr*/ || id == 7288 /*fx*/ || id == 248 /*va*/) {
            View.setLayout(Rez.Layouts.TopThird(dc));
      }
      else if (id == 5281 /*fr*/ || id == 5292 /*fx*/ || id == 262 /*va*/) {
            View.setLayout(Rez.Layouts.MidThird(dc));
      }
      else if (id == 13270 /*fr*/ || id == 13288 /*fx*/ || id == 249 /*va*/) {
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

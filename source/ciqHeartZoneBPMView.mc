using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.UserProfile as Profile;

class ciqHeartZoneBPMView extends Ui.DataField
{
   /** layouts for different watchface areas */
   const LAYOUT_ALL             = "All";
   const LAYOUT_TOP_HALF        = "TopHalf";
   const LAYOUT_BOT_HALF        = "BotHalf";
   const LAYOUT_TOP_THIRD       = "TopThird";
   const LAYOUT_MID_THIRD       = "MidThird";
   const LAYOUT_LEFT_MID_THIRD  = "LeftMidThird";
   const LAYOUT_RIGHT_MID_THIRD = "RightMidThird";
   const LAYOUT_BOT_THIRD       = "BotThird";
   const LAYOUT_TOP_LEFT_QUAD   = "TopLeftQuad";
   const LAYOUT_TOP_RIGHT_QUAD  = "TopRightQuad";
   const LAYOUT_BOT_LEFT_QUAD   = "BotLeftQuad";
   const LAYOUT_BOT_RIGHT_QUAD  = "BotRightQuad";
   const LAYOUT_UNKNOWN         = "Unknown";

   /** all possible obscurity flag values */
   const UNOBSCURED         = 0;  // 0000
   const OBSCURED_LEFT      = 1;  // 0001
   const OBSCURED_RIGHT     = 4;  // 0100
   const OBSCURED_LR        = 5;  // 0101
   const OBSCURED_TOP       = 2;  // 0010
   const OBSCURED_TOP_LEFT  = 3;  // 0011
   const OBSCURED_TOP_RIGHT = 6;  // 0110
   const OBSCURED_TOP_LR    = 7;  // 0111
   const OBSCURED_BOT       = 8;  // 1000
   const OBSCURED_BOT_LEFT  = 9;  // 1001
   const OBSCURED_BOT_RIGHT = 12; // 1100
   const OBSCURED_BOT_LR    = 13; // 1101
   const OBSCURED_TB        = 10; // 1010
   const OBSCURED_TB_LEFT   = 11; // 1011
   const OBSCURED_TB_RIGHT  = 14; // 1110
   const OBSCURED_ALL     = 15; // 1111

   /** screen dimensions */
   var screenWidth;
   var screenHeight;

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
   var hiliteZone = 0;

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

      var deviceSettings = Sys.getDeviceSettings();
      screenWidth = deviceSettings.screenWidth;
      screenHeight = deviceSettings.screenHeight;

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
   function printFontDims(fontName,dimX,dimY) {
         Sys.println(fontName + " dims: " + dimX + "," + dimY);
   }

   /*-------------------------------------------------------------------------
    *------------------------------------------------------------------------*/
   function onLayout(dc)
   {
      var width = dc.getWidth();
      var height = dc.getHeight();
      var obscurityFlags = DataField.getObscurityFlags();
      
      /*var layout = */getLayoutName(dc,screenWidth,screenHeight,width,height,obscurityFlags);
      
//      Sys.println("layout: " + layout);
      
/*
      if (layout == LAYOUT_ALL) {
         View.setLayout(Rez.Layouts.All(dc));
      }
      else if (layout == LAYOUT_TOP_HALF) {
         View.setLayout(Rez.Layouts.TopHalf(dc));
      }
      else if (layout == LAYOUT_BOT_HALF) {
         View.setLayout(Rez.Layouts.BotHalf(dc));
      }
      else if (layout == LAYOUT_TOP_THIRD) {
         View.setLayout(Rez.Layouts.TopThird(dc));
      }
      else if (layout == LAYOUT_MID_THIRD) {
         View.setLayout(Rez.Layouts.MidThird(dc));
      }
      else if (layout == LAYOUT_BOT_THIRD) {
         View.setLayout(Rez.Layouts.BotThird(dc));
      }
      else if (layout == LAYOUT_LEFT_MID_THIRD) {
         View.setLayout(Rez.Layouts.LeftMidThird(dc));
      }
      else if (layout == LAYOUT_RIGHT_MID_THIRD) {
         View.setLayout(Rez.Layouts.RightMidThird(dc));
      }
      else if (layout == LAYOUT_TOP_LEFT_QUAD) {
         View.setLayout(Rez.Layouts.TopLeftQuad(dc));
      }
      else if (layout == LAYOUT_TOP_RIGHT_QUAD) {
         View.setLayout(Rez.Layouts.TopRightQuad(dc));
      }
      else if (layout == LAYOUT_BOT_LEFT_QUAD) {
         View.setLayout(Rez.Layouts.BotLeftQuad(dc));
      }
      else if (layout == LAYOUT_BOT_RIGHT_QUAD) {
         View.setLayout(Rez.Layouts.BotRightQuad(dc));
      }
      else {
         View.setLayout(Rez.Layouts.All(dc));
      }
*/
/*
      var dims;
      var fontIsSet = false;
      var debugUsingFont = true;

      dims = dc.getTextDimensions("888", Gfx.FONT_NUMBER_THAI_HOT);
      printFontDims("thai hot",dims[0],dims[1]);
//      if (dims[0] < width && dims[1] < height) {
//         font = Gfx.FONT_NUMBER_THAI_HOT;
//         fontIsSet = true;
////         if (debugUsingFont) { Sys.println("using thai hot"); }
//      }

      dims = dc.getTextDimensions("888", Gfx.FONT_NUMBER_HOT);
      printFontDims("hot",dims[0],dims[1]);
//      if (!fontIsSet && dims[0] < width && dims[1] < height) {
//         font = Gfx.FONT_NUMBER_HOT;
//         fontIsSet = true;
////         if (debugUsingFont) { Sys.println("using hot"); }
//      }

      dims = dc.getTextDimensions("888", Gfx.FONT_NUMBER_MEDIUM);
      printFontDims("medium",dims[0],dims[1]);
//      if (!fontIsSet && dims[0] < width && dims[1] < height) {
//         font = Gfx.FONT_NUMBER_MEDIUM;
//         fontIsSet = true;
////         if (debugUsingFont) { Sys.println("using medium"); }
//      }

      dims = dc.getTextDimensions("888", Gfx.FONT_NUMBER_MILD);
      printFontDims("mild",dims[0],dims[1]);
//      if (!fontIsSet) {
//         font = Gfx.FONT_NUMBER_MILD;
//         fontIsSet = true;
//         if (debugUsingFont) { Sys.println("using low");
//         }
//      }
 */
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

hiliteZone = 6;
       var zone = getZone(mHeartRate);

       var zoneBgColor = getZoneBgColor(zone);
       var zoneFgColor = getZoneFgColor(zone);

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

   /*-------------------------------------------------------------------------
    *------------------------------------------------------------------------*/
    function getZoneBgColor(zone)
    {
       if (zone == 0) {
          return defaultBgColor;
       }
       else {
          return zoneColors[2*(zone-1)];
       }
    }

   /*-------------------------------------------------------------------------
    *------------------------------------------------------------------------*/
    function getZoneFgColor(zone)
    {
       if (zone == 0) {
          return defaultFgColor;
       }
       else {
          return zoneColors[2*(zone-1)+1];
       }
    }
    
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

   function toStr(o) {
      if (o != null && o > 0) {
         return "" + o;
      } else {
         return "---";
      }
   }

   /*
   ************************
   forerunner layouts
   ------------------------
   all: 215,180 tbLR       = 1
   ------------------------
   topHalf: 215, 89 tLR    = 2
   botHalf: 215, 89 bLR    = 3
   ------------------------
   topThird: 215, 55 tLR   = 4
   midThird: 215, 66 LR    = 5
   botThird: 215, 55 bLR   = 6
   ------------------------
   topThird:  215, 55 tLR
   lMidThird: 107, 66 L    = 7
   rMidThird: 107, 66 R    = 8
   botThird:  215, 55 bLR
   ------------------------

   ************************
   fenix/bravo layouts
   ------------------------
   all:       218,218 tbLR = 1
   ------------------------
   topHalf:   218,108 tLR  = 2
   botHalf:   218,108 bLR  = 3
   ------------------------
   topThird:  218, 70 tLR  = 4
   midThird:  218, 74 LR   = 5
   botThird:  218, 70 bLR  = 6
   ------------------------
   topHalf:   218,108 tLR
   blQuad:    108,108 bL   = 9
   brQuad:    108,108 bR   = 10
   ------------------------
   topThird:  218, 70 tLR
   lMidThird: 108, 74 L    = 11
   rMidThird: 108, 74 R    = 12
   botThird:  218, 70 bLR
   ------------------------
   tlQuad:    108,108 tL   = 7
   trQuad:    108,108 tR   = 8
   blQuad:    108,108 bL
   brQuad:    108,108 bR
   ------------------------
   */
 
   /*-------------------------------------------------------------------------
    * TODO can simplify this for less code
    *------------------------------------------------------------------------*/

//   (:semiround215x180) function getLayoutName(dc,screenWidth,screenHeight,width,height,obscurity)
//   {
//      if (obscurity == OBSCURED_ALL) {
//         View.setLayout(Rez.Layouts.All(dc));
//         //            return LAYOUT_ALL;
//      }
//      else if (obscurity == OBSCURED_TOP_LR && height == 89) {
//         View.setLayout(Rez.Layouts.TopHalf(dc));
//         //            return LAYOUT_TOP_HALF;
//      }
//      else if (obscurity == OBSCURED_BOT_LR && height == 89) {
//         View.setLayout(Rez.Layouts.BotHalf(dc));
//         //            return LAYOUT_BOT_HALF;
//      }
//      else if (obscurity == OBSCURED_TOP_LR /* && height == 55*/) {
//         View.setLayout(Rez.Layouts.TopThird(dc));
//         //            return LAYOUT_TOP_THIRD;
//      }
//      else if (obscurity == OBSCURED_LR) {
//         View.setLayout(Rez.Layouts.MidThird(dc));
//         //            return LAYOUT_MID_THIRD;
//      }
//      else if (obscurity == OBSCURED_BOT_LR /* && height == 55*/) {
//         View.setLayout(Rez.Layouts.BotThird(dc));
//         //            return LAYOUT_BOT_THIRD;
//      }
//      else if (obscurity == OBSCURED_LEFT) {
//         View.setLayout(Rez.Layouts.LeftMidThird(dc));
//         //            return LAYOUT_LEFT_MID_THIRD;
//      }
//      else if (obscurity == OBSCURED_RIGHT) {
//         View.setLayout(Rez.Layouts.RightMidThird(dc));
//         //            return LAYOUT_RIGHT_MID_THIRD;
//      }
//      else {
//         View.setLayout(Rez.Layouts.All(dc));
//         //            return LAYOUT_UNKNOWN; //TODO what?
//         //            return LAYOUT_ALL;
//      }
//   }
//
//   (:round218x218) function getLayoutName(dc,screenWidth,screenHeight,width,height,obscurity)
//   {
//      if (obscurity == OBSCURED_ALL) {
//         View.setLayout(Rez.Layouts.All(dc));
//         //            return LAYOUT_ALL;
//      }
//      else if (obscurity == OBSCURED_TOP_LR && height == 108) {
//         View.setLayout(Rez.Layouts.TopHalf(dc));
//         //            return LAYOUT_TOP_HALF;
//      }
//      else if (obscurity == OBSCURED_BOT_LR && height == 108) {
//         View.setLayout(Rez.Layouts.BotHalf(dc));
//         //            return LAYOUT_BOT_HALF;
//      }
//      else if (obscurity == OBSCURED_TOP_LR /* && height == 70*/) {
//         View.setLayout(Rez.Layouts.TopThird(dc));
//         //            return LAYOUT_TOP_THIRD;
//      }
//      else if (obscurity == OBSCURED_LR) {
//         View.setLayout(Rez.Layouts.MidThird(dc));
//         //            return LAYOUT_MID_THIRD;
//      }
//      else if (obscurity == OBSCURED_BOT_LR /* && height == 70*/) {
//         View.setLayout(Rez.Layouts.BotThird(dc));
//         //            return LAYOUT_BOT_THIRD;
//      }
//      else if (obscurity == OBSCURED_LEFT) {
//         View.setLayout(Rez.Layouts.LeftMidThird(dc));
//         //            return LAYOUT_LEFT_MID_THIRD;
//      }
//      else if (obscurity == OBSCURED_RIGHT) {
//         View.setLayout(Rez.Layouts.RightMidThird(dc));
//         //            return LAYOUT_RIGHT_MID_THIRD ;
//      }
//      else if (obscurity == OBSCURED_TOP_LEFT) {
//         View.setLayout(Rez.Layouts.TopLeftQuad(dc));
//         //            return LAYOUT_TOP_LEFT_QUAD;
//      }
//      else if (obscurity == OBSCURED_TOP_RIGHT) {
//         View.setLayout(Rez.Layouts.TopRightQuad(dc));
//         //            return LAYOUT_TOP_RIGHT_QUAD;
//      }
//      else if (obscurity == OBSCURED_BOT_LEFT) {
//         View.setLayout(Rez.Layouts.BotLeftQuad(dc));
//         //            return LAYOUT_BOT_LEFT_QUAD;
//      }
//      else if (obscurity == OBSCURED_BOT_RIGHT) {
//         View.setLayout(Rez.Layouts.BotRightQuad(dc));
//         //            return LAYOUT_BOT_RIGHT_QUAD;
//      }
//      else {
//         View.setLayout(Rez.Layouts.TopHalf(dc));
//         //            return LAYOUT_UNKNOWN;
//      }
//   }

   function getLayoutName(dc,screenWidth,screenHeight,width,height,obscurity)
   {
      if (screenWidth == 215 && screenHeight == 180 ) {

         if (obscurity == OBSCURED_ALL) {
            View.setLayout(Rez.Layouts.All(dc));
//            return LAYOUT_ALL;
         }
         else if (obscurity == OBSCURED_TOP_LR && height == 89) {
            View.setLayout(Rez.Layouts.TopHalf(dc));
//            return LAYOUT_TOP_HALF;
         }
         else if (obscurity == OBSCURED_BOT_LR && height == 89) {
            View.setLayout(Rez.Layouts.BotHalf(dc));
//            return LAYOUT_BOT_HALF;
         }
         else if (obscurity == OBSCURED_TOP_LR /* && height == 55*/) {
            View.setLayout(Rez.Layouts.TopThird(dc));
//            return LAYOUT_TOP_THIRD;
         }
         else if (obscurity == OBSCURED_LR) {
            View.setLayout(Rez.Layouts.MidThird(dc));
//            return LAYOUT_MID_THIRD;
         }
         else if (obscurity == OBSCURED_BOT_LR /* && height == 55*/) {
            View.setLayout(Rez.Layouts.BotThird(dc));
//            return LAYOUT_BOT_THIRD;
         }
         else if (obscurity == OBSCURED_LEFT) {
            View.setLayout(Rez.Layouts.LeftMidThird(dc));
//            return LAYOUT_LEFT_MID_THIRD;
         }
         else if (obscurity == OBSCURED_RIGHT) {
            View.setLayout(Rez.Layouts.RightMidThird(dc));
//            return LAYOUT_RIGHT_MID_THIRD;
         }
         else {
//            return LAYOUT_UNKNOWN; //TODO what?
//            return LAYOUT_ALL;
         }
      }
//      else if (screenWidth == 218 && screenHeight == 218 ) {
//
//         if (obscurity == OBSCURED_ALL) {
//            View.setLayout(Rez.Layouts.All(dc));
////            return LAYOUT_ALL;
//         }
//         else if (obscurity == OBSCURED_TOP_LR && height == 108) {
//            View.setLayout(Rez.Layouts.TopHalf(dc));
////            return LAYOUT_TOP_HALF;
//         }
//         else if (obscurity == OBSCURED_BOT_LR && height == 108) {
//            View.setLayout(Rez.Layouts.BotHalf(dc));
////            return LAYOUT_BOT_HALF;
//         }
//         else if (obscurity == OBSCURED_TOP_LR /* && height == 70*/) {
//            View.setLayout(Rez.Layouts.TopThird(dc));
////            return LAYOUT_TOP_THIRD;
//         }
//         else if (obscurity == OBSCURED_LR) {
//            View.setLayout(Rez.Layouts.MidThird(dc));
////            return LAYOUT_MID_THIRD;
//         }
//         else if (obscurity == OBSCURED_BOT_LR /* && height == 70*/) {
//            View.setLayout(Rez.Layouts.BotThird(dc));
////            return LAYOUT_BOT_THIRD;
//         }
//         else if (obscurity == OBSCURED_LEFT) {
//            View.setLayout(Rez.Layouts.LeftMidThird(dc));
////            return LAYOUT_LEFT_MID_THIRD;
//         }
//         else if (obscurity == OBSCURED_RIGHT) {
//            View.setLayout(Rez.Layouts.RightMidThird(dc));
////            return LAYOUT_RIGHT_MID_THIRD ;
//         }
//         else if (obscurity == OBSCURED_TOP_LEFT) {
//            View.setLayout(Rez.Layouts.TopLeftQuad(dc));
////            return LAYOUT_TOP_LEFT_QUAD;
//         }
//         else if (obscurity == OBSCURED_TOP_RIGHT) {
//            View.setLayout(Rez.Layouts.TopRightQuad(dc));
////            return LAYOUT_TOP_RIGHT_QUAD;
//         }
//         else if (obscurity == OBSCURED_BOT_LEFT) {
//            View.setLayout(Rez.Layouts.BotLeftQuad(dc));
////            return LAYOUT_BOT_LEFT_QUAD;
//         }
//         else if (obscurity == OBSCURED_BOT_RIGHT) {
//            View.setLayout(Rez.Layouts.BotRightQuad(dc));
////            return LAYOUT_BOT_RIGHT_QUAD;
//         }
//         else {
////            return LAYOUT_UNKNOWN;
//         }
//      }
      
//      return LAYOUT_UNKNOWN;
   }

//   function getLayoutName(screenWidth,screenHeight,width,height,obscurity)
//   {
//      var model = "unknown";
//      
//      if (screenWidth == 215 && screenHeight == 180 ) {
//
//         if (obscurity == OBSCURED_ALL) {
//            model = LAYOUT_ALL;
//         }
//         else if (obscurity == OBSCURED_TOP_LR && height == 89) {
//            model = LAYOUT_TOP_HALF;
//         }
//         else if (obscurity == OBSCURED_BOT_LR && height == 89) {
//            model = LAYOUT_BOT_HALF;
//         }
//         else if (obscurity == OBSCURED_TOP_LR /* && height == 55*/) {
//            model = LAYOUT_TOP_THIRD;
//         }
//         else if (obscurity == OBSCURED_LR) {
//            model = LAYOUT_MID_THIRD;
//         }
//         else if (obscurity == OBSCURED_BOT_LR /* && height == 55*/) {
//            model = LAYOUT_BOT_THIRD;
//         }
//         else if (obscurity == OBSCURED_LEFT) {
//            model = LAYOUT_LEFT_MID_THIRD;
//         }
//         else if (obscurity == OBSCURED_RIGHT) {
//            model = LAYOUT_RIGHT_MID_THIRD;
//         }
//         else {
////            model = LAYOUT_UNKNOWN; //TODO what?
//            model = LAYOUT_ALL;
//         }
//      }
//      else if (screenWidth == 218 && screenHeight == 218 ) {
//
//         if (obscurity == OBSCURED_ALL) {
//            model = LAYOUT_ALL;
//         }
//         else if (obscurity == OBSCURED_TOP_LR && height == 108) {
//            model = LAYOUT_TOP_HALF;
//         }
//         else if (obscurity == OBSCURED_BOT_LR && height == 108) {
//            model = LAYOUT_BOT_HALF;
//         }
//         else if (obscurity == OBSCURED_TOP_LR /* && height == 70*/) {
//            model = LAYOUT_TOP_THIRD;
//         }
//         else if (obscurity == OBSCURED_LR) {
//            model = LAYOUT_MID_THIRD;
//         }
//         else if (obscurity == OBSCURED_BOT_LR /* && height == 70*/) {
//            model = LAYOUT_BOT_THIRD;
//         }
//         else if (obscurity == OBSCURED_LEFT) {
//            model = LAYOUT_LEFT_MID_THIRD;
//         }
//         else if (obscurity == OBSCURED_RIGHT) {
//            model = LAYOUT_RIGHT_MID_THIRD ;
//         }
//         else if (obscurity == OBSCURED_TOP_LEFT) {
//            model = LAYOUT_TOP_LEFT_QUAD;
//         }
//         else if (obscurity == OBSCURED_TOP_RIGHT) {
//            model = LAYOUT_TOP_RIGHT_QUAD;
//         }
//         else if (obscurity == OBSCURED_BOT_LEFT) {
//            model = LAYOUT_BOT_LEFT_QUAD;
//         }
//         else if (obscurity == OBSCURED_BOT_RIGHT) {
//            model = LAYOUT_BOT_RIGHT_QUAD;
//         }
//         else {
//            model = LAYOUT_UNKNOWN;
//         }
//      }
//      
//      return model;
//   }
}

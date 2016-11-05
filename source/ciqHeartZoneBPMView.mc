using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.UserProfile as Profile;

class ciqHeartZoneBPMView extends Ui.DataField
{
   const LAYOUT_RUNNER_ALL             = "frAll";
   const LAYOUT_RUNNER_TOP_HALF        = "frTopHalf";
   const LAYOUT_RUNNER_BOT_HALF        = "frBotHalf";
   const LAYOUT_RUNNER_TOP_THIRD       = "frTopThird";
   const LAYOUT_RUNNER_MID_THIRD       = "frMidThird";
   const LAYOUT_RUNNER_BOT_THIRD       = "frBotThird";
   const LAYOUT_RUNNER_LEFT_MID_THIRD  = "frLeftMidThird";
   const LAYOUT_RUNNER_RIGHT_MID_THIRD = "frRightMidThird";
   const LAYOUT_RUNNER_UNKNOWN         = "frUnknown";

   const LAYOUT_FENIX_ALL = "fenixAll";
   const LAYOUT_FENIX_TOP_HALF        = "fxTopHalf";
   const LAYOUT_FENIX_BOT_HALF        = "fxBotHalf";
   const LAYOUT_FENIX_TOP_THIRD       = "fxTopThird";
   const LAYOUT_FENIX_MID_THIRD       = "fxMidThird";
   const LAYOUT_FENIX_BOT_THIRD       = "fxBotThird";
   const LAYOUT_FENIX_LEFT_MID_THIRD  = "fxLeftMidThird";
   const LAYOUT_FENIX_RIGHT_MID_THIRD = "fxRightMidThird";
   const LAYOUT_FENIX_TOP_LEFT_QUAD   = "fxTopLeftQuad";
   const LAYOUT_FENIX_TOP_RIGHT_QUAD  = "fxTopRightQuad";
   const LAYOUT_FENIX_BOT_LEFT_QUAD   = "fxBotLeftQuad";
   const LAYOUT_FENIX_BOT_RIGHT_QUAD  = "fxBotRightQuad";
   const LAYOUT_FENIX_UNKNOWN         = "fxUnknown";

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

   hidden var mHeartRate;

   var beginZone1;
   var beginZone2;
   var beginZone3;
   var beginZone4;
   var beginZone5;

   var hiliteZone = 0;

   var zoneColors = new [10];

   /*-------------------------------------------------------------------------
    *------------------------------------------------------------------------*/
   function initialize()
   {
      DataField.initialize();

      mHeartRate = 0.0f;
           
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

   // Set your layout here. Anytime the size of obscurity of
   // the draw context is changed this will be called.
   function onLayout(dc)
   {
      var deviceSettings = Sys.getDeviceSettings();
      var screenWidth = deviceSettings.screenWidth;
      var screenHeight = deviceSettings.screenHeight;

      var width = dc.getWidth();
      var height = dc.getHeight();
      var obscurityFlags = DataField.getObscurityFlags();
      
      Sys.println("layout: "
         + getLayoutName(screenWidth,screenHeight,width,height,obscurityFlags));
      

//      var topleft = OBSCURE_TOP | OBSCURE_LEFT;
//      var topright = OBSCURE_TOP | OBSCURE_RIGHT;
//      var bottomleft = OBSCURE_BOTTOM | OBSCURE_LEFT;
//      var bottomright = OBSCURE_BOTTOM | OBSCURE_RIGHT;
//
//      // Top left quadrant so we'll use the top left layout
//      if (obscurityFlags == (OBSCURE_TOP & OBSCURE_LEFT)) {
////         Sys.println("using TopLeft layout " + width + "," + height + "," + obscurityFlags);
//         View.setLayout(Rez.Layouts.TopLeftLayout(dc));
//
//         // Top right quadrant so we'll use the top right layout
//      } else if (obscurityFlags == (OBSCURE_TOP | OBSCURE_RIGHT)) {
////         Sys.println("using TopRight layout " + width + "," + height + "," + obscurityFlags);
//         View.setLayout(Rez.Layouts.TopRightLayout(dc));
//
//         // Bottom left quadrant so we'll use the bottom left layout
//      } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT)) {
////         Sys.println("using BottomLeft layout " + width + "," + height + "," + obscurityFlags);
//         View.setLayout(Rez.Layouts.BottomLeftLayout(dc));
//
//         // Bottom right quadrant so we'll use the bottom right layout
//      } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_RIGHT)) {
////         Sys.println("using BottomRight layout " + width + "," + height + "," + obscurityFlags);
//         View.setLayout(Rez.Layouts.BottomRightLayout(dc));
//
//         // Use the generic, centered layout
//      } else {
//         Sys.println("----------> using Main layout " + width + "," + height + "," + obscurityFlags);

      var font = Gfx.FONT_NUMBER_MILD;

         var dims;
         var fontIsSet = false;

         dims = dc.getTextDimensions("888", Gfx.FONT_NUMBER_THAI_HOT);

         var debugUsingFont = true;
         
         printFontDims("thai hot",dims[0],dims[1]);
         if (dims[0] < width && dims[1] < height) {
            font = Gfx.FONT_NUMBER_THAI_HOT;
            fontIsSet = true;
            if (debugUsingFont) { Sys.println("using thai hot");
            }
         }

/**/
         dims = dc.getTextDimensions("888", Gfx.FONT_SYSTEM_NUMBER_THAI_HOT);
         printFontDims("system thai hot",dims[0],dims[1]);
         if (dims[0] < width && dims[1] < height) {
            font = Gfx.FONT_SYSTEM_NUMBER_THAI_HOT;
            fontIsSet = true;
            if (debugUsingFont) { Sys.println("using system thai hot");
            }
         }

         dims = dc.getTextDimensions("888", Gfx.FONT_NUMBER_HOT);
         printFontDims("hot",dims[0],dims[1]);
         if (!fontIsSet && dims[0] < width && dims[1] < height) {
            font = Gfx.FONT_NUMBER_HOT;
            fontIsSet = true;
            if (debugUsingFont) { Sys.println("using hot");
            }
         }

         dims = dc.getTextDimensions("888", Gfx.FONT_NUMBER_MEDIUM);
         printFontDims("medium",dims[0],dims[1]);
         if (!fontIsSet && dims[0] < width && dims[1] < height) {
            font = Gfx.FONT_NUMBER_MEDIUM;
            fontIsSet = true;
            if (debugUsingFont) { Sys.println("using medium");
            }
         }

         dims = dc.getTextDimensions("888", Gfx.FONT_NUMBER_MILD);
         printFontDims("mild",dims[0],dims[1]);
         if (!fontIsSet) {
            font = Gfx.FONT_NUMBER_MILD;
            fontIsSet = true;
            if (debugUsingFont) { Sys.println("using low");
            }
         }
/**/

         View.setLayout(Rez.Layouts.MainLayout(dc));
         var labelView = View.findDrawableById("label");
         labelView.locY = labelView.locY - 16;
         var valueView = View.findDrawableById("value");
         valueView.locY = valueView.locY + 7;
         valueView.setFont(font);
         /* First go to center, then to account for the fact that the top of font
          * is rendered at the y-value, subract half the font size to center it
          * on the center.
          */
         valueView.locY = height/2 - Gfx.getFontHeight(font)/2;
//      }

      View.findDrawableById("label").setText(Rez.Strings.label);

      return true;
   }

   /*-------------------------------------------------------------------------
    *------------------------------------------------------------------------*/
    // The given info object contains all the current workout
    // information. Calculate a value and save it locally in this method.
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
    *------------------------------------------------------------------------*/
    function getZoneBgColor(zone)
    {
       if (zone == 0) {
          return Gfx.COLOR_WHITE; //TODO
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
          return Gfx.COLOR_BLACK; //TODO
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

   /*-------------------------------------------------------------------------
    * Display the value you computed here. This will be called
    * once a second when the data field is visible.
    *------------------------------------------------------------------------*/
    function onUpdate(dc)
    {
       var zone = getZone(mHeartRate);

       var zoneBgColor = getZoneBgColor(zone);
       var zoneFgColor = getZoneFgColor(zone);

       Sys.println("zone,bg,fg: "
             + zone + "," + zoneBgColor + "," + zoneFgColor);

//      dc.setColor(zoneFgColor,zoneBgColor);
//      dc.clear();

        // Set the background color
//        View.findDrawableById("Background").setColor(getBackgroundColor());
        View.findDrawableById("Background").setColor(zoneBgColor);

        // Set the foreground color and value
        var value = View.findDrawableById("value");
//        if (getBackgroundColor() == Gfx.COLOR_BLACK) {
//            value.setColor(Gfx.COLOR_WHITE);
//        } else {
//            value.setColor(Gfx.COLOR_BLACK);
//        }

        value.setColor(zoneFgColor);
//        value.setText(mHeartRate.format("%2f"));
        value.setText(toStr(mHeartRate));

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
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
 
   function getLayoutName(screenWidth,screenHeight,width,height,obscurity)
   {
      var model = "unknown";
      
      if (screenWidth == 215 && screenHeight == 180 ) {

         model = "runner";
         
         if (obscurity == OBSCURED_ALL) {
            model = LAYOUT_RUNNER_ALL;
         }
         else if (obscurity == OBSCURED_TOP_LR && height == 89) {
            model = LAYOUT_RUNNER_TOP_HALF;
         }
         else if (obscurity == OBSCURED_BOT_LR && height == 89) {
            model = LAYOUT_RUNNER_BOT_HALF;
         }
         else if (obscurity == OBSCURED_TOP_LR /* && height == 55*/) {
            model = LAYOUT_RUNNER_TOP_THIRD;
         }
         else if (obscurity == OBSCURED_LR) {
            model = LAYOUT_RUNNER_MID_THIRD;
         }
         else if (obscurity == OBSCURED_BOT_LR /* && height == 55*/) {
            model = LAYOUT_RUNNER_BOT_THIRD;
         }
         else if (obscurity == OBSCURED_LEFT) {
            model = LAYOUT_RUNNER_LEFT_MID_THIRD;
         }
         else if (obscurity == OBSCURED_RIGHT) {
            model = LAYOUT_RUNNER_RIGHT_MID_THIRD;
         }
         else {
            model = LAYOUT_RUNNER_UNKNOWN;
         }
      }
      else if (screenWidth == 218 && screenHeight == 218 ) {

         if (obscurity == OBSCURED_ALL) {
            model = LAYOUT_FENIX_ALL;
         }
         else if (obscurity == OBSCURED_TOP_LR && height == 108) {
            model = LAYOUT_FENIX_TOP_HALF;
         }
         else if (obscurity == OBSCURED_BOT_LR && height == 108) {
            model = LAYOUT_FENIX_BOT_HALF;
         }
         else if (obscurity == OBSCURED_TOP_LR /* && height == 70*/) {
            model = LAYOUT_FENIX_TOP_THIRD;
         }
         else if (obscurity == OBSCURED_LR) {
            model = LAYOUT_FENIX_MID_THIRD;
         }
         else if (obscurity == OBSCURED_BOT_LR /* && height == 70*/) {
            model = LAYOUT_FENIX_BOT_THIRD;
         }
         else if (obscurity == OBSCURED_LEFT) {
            model = LAYOUT_FENIX_LEFT_MID_THIRD;
         }
         else if (obscurity == OBSCURED_RIGHT) {
            model = LAYOUT_FENIX_RIGHT_MID_THIRD ;
         }
         else if (obscurity == OBSCURED_TOP_LEFT) {
            model = LAYOUT_FENIX_TOP_LEFT_QUAD;
         }
         else if (obscurity == OBSCURED_TOP_RIGHT) {
            model = LAYOUT_FENIX_TOP_RIGHT_QUAD;
         }
         else if (obscurity == OBSCURED_BOT_LEFT) {
            model = LAYOUT_FENIX_BOT_LEFT_QUAD;
         }
         else if (obscurity == OBSCURED_BOT_RIGHT) {
            model = LAYOUT_FENIX_BOT_RIGHT_QUAD;
         }
         else {
            model = LAYOUT_FENIX_UNKNOWN;
         }
      }
      
      return model;
   }
}

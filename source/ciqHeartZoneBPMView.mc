using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class ciqHeartZoneBPMView extends Ui.DataField
{
   const LAYOUT_RUNNER_ALL             = "runnerAll";
   const LAYOUT_RUNNER_TOP_HALF        = "runnerTopHalf";
   const LAYOUT_RUNNER_BOT_HALF        = "runnerBotHalf";
   const LAYOUT_RUNNER_TOP_THIRD       = "runnerTopThird";
   const LAYOUT_RUNNER_MID_THIRD       = "runnerMidThird";
   const LAYOUT_RUNNER_BOT_THIRD       = "runnerBotThird";
   const LAYOUT_RUNNER_LEFT_MID_THIRD  = "runnerLeftMidThird";
   const LAYOUT_RUNNER_RIGHT_MID_THIRD = "runnerRightMidThird";
   const LAYOUT_RUNNER_UNKNOWN         = "runnerUnknown";

   const LAYOUT_FENIX_ALL = "fenixAll";
   const LAYOUT_FENIX_TOP_HALF        = "fenixTopHalf";
   const LAYOUT_FENIX_BOT_HALF        = "fenixBotHalf";
   const LAYOUT_FENIX_TOP_THIRD       = "fenixTopThird";
   const LAYOUT_FENIX_MID_THIRD       = "fenixMidThird";
   const LAYOUT_FENIX_BOT_THIRD       = "fenixBotThird";
   const LAYOUT_FENIX_LEFT_MID_THIRD  = "fenixLeftMidThird";
   const LAYOUT_FENIX_RIGHT_MID_THIRD = "fenixRightMidThird";
   const LAYOUT_FENIX_TOP_LEFT_QUAD   = "fenixTopLeftQuad";
   const LAYOUT_FENIX_TOP_RIGHT_QUAD  = "fenixTopRightQuad";
   const LAYOUT_FENIX_BOT_LEFT_QUAD   = "fenixBotLeftQuad";
   const LAYOUT_FENIX_BOT_RIGHT_QUAD  = "fenixBotRightQuad";
   const LAYOUT_FENIX_UNKNOWN         = "fenixUnknown";

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

   hidden var mValue;

   function initialize() {
      DataField.initialize();
      mValue = 0.0f;
   }

   function printFontDims(fontName,dimX,dimY) {
//         Sys.println(fontName + " dims: " + dimX + "," + dimY);
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

//      Sys.println("swidth,sheight,width,height,obscurity: "
//            + screenWidth + "," + screenHeight + ") "
//            + width + "," + height + ","
//            + getObscurityString(obscurityFlags));
      
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

         var debugUsingFont = false;
         
         printFontDims("thai hot",dims[0],dims[1]);
         if (dims[0] < width && dims[1] < height) {
            font = Gfx.FONT_NUMBER_THAI_HOT;
            fontIsSet = true;
            if (debugUsingFont) { Sys.println("using thai hot");
            }
         }

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

    // The given info object contains all the current workout
    // information. Calculate a value and save it locally in this method.
    function compute(info) {
        // See Activity.Info in the documentation for available information.
        if(info has :currentHeartRate){
            if(info.currentHeartRate != null){
                mValue = info.currentHeartRate;
            } else {
                mValue = 0.0f;
            }
        }
    }

    // Display the value you computed here. This will be called
    // once a second when the data field is visible.
    function onUpdate(dc) {
        // Set the background color
        View.findDrawableById("Background").setColor(getBackgroundColor());

        // Set the foreground color and value
        var value = View.findDrawableById("value");
        if (getBackgroundColor() == Gfx.COLOR_BLACK) {
            value.setColor(Gfx.COLOR_WHITE);
        } else {
            value.setColor(Gfx.COLOR_BLACK);
        }
        value.setText(mValue.format("%.2f"));

        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
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
   
   //TODO deprecate
   function getObscurityString(obscurityFlags)
   {
      var obscurity = "unknown";
      if (obscurityFlags == UNOBSCURED) {
         obscurity = "L";
      }
      else if (obscurityFlags == OBSCURED_LEFT) {
         obscurity = "L";
      }
      else if (obscurityFlags == OBSCURED_RIGHT) {
         obscurity = "R";
      }
      else if (obscurityFlags == OBSCURED_LR) {
         obscurity = "LR";
      }
      else if (obscurityFlags == OBSCURED_TOP) {
         obscurity = "t";
      }
      else if (obscurityFlags == OBSCURED_TOP_LEFT) {
         obscurity = "tL";
      }
      else if (obscurityFlags == OBSCURED_TOP_RIGHT) {
         obscurity = "tR";
      }
      else if (obscurityFlags == OBSCURED_TOP_LR) {
         obscurity = "tLR";
      }
      else if (obscurityFlags == OBSCURED_BOT) {
         obscurity = "b";
      }
      else if (obscurityFlags == OBSCURED_BOT_LEFT) {
         obscurity = "bL";
      }
      else if (obscurityFlags == OBSCURED_BOT_RIGHT) {
         obscurity = "bR";
      }
      else if (obscurityFlags == OBSCURED_BOT_LR) {
         obscurity = "bLR";
      }
      else if (obscurityFlags == OBSCURED_TB) {
         obscurity = "tb";
      }
      else if (obscurityFlags == OBSCURED_TB_LEFT) {
         obscurity = "tbL";
      }
      else if (obscurityFlags == OBSCURED_TB_RIGHT) {
         obscurity = "tbR";
      }
      else if (obscurityFlags == OBSCURED_ALL) {
         obscurity = "tbLR";
      }
      
      return obscurity;
   }
}

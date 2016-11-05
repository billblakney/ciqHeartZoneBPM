using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class ciqHeartZoneBPMView extends Ui.DataField {

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
      var width = dc.getWidth();
      var height = dc.getHeight();
      var obscurityFlags = DataField.getObscurityFlags();

      Sys.println("width,height,obscurity: " + width + "," + height + ","
      + getObscurityString(obscurityFlags));

      var topleft = OBSCURE_TOP | OBSCURE_LEFT;
      var topright = OBSCURE_TOP | OBSCURE_RIGHT;
      var bottomleft = OBSCURE_BOTTOM | OBSCURE_LEFT;
      var bottomright = OBSCURE_BOTTOM | OBSCURE_RIGHT;

      var font = Gfx.FONT_NUMBER_MILD;

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
   
   function getObscurityString(obscurityFlags)
   {
      var obscurity = "unknown";

      if (obscurityFlags == 0) {        // unobscured
         obscurity = "L";
      }
      else if (obscurityFlags == 1) {   // L
         obscurity = "L";
      }
      else if (obscurityFlags == 4) {   // R
         obscurity = "R";
      }
      else if (obscurityFlags == 5) {   // LR
         obscurity = "LR";
      }
      else if (obscurityFlags == 2) {   // t
         obscurity = "t";
      }
      else if (obscurityFlags == 3) {   // tL
         obscurity = "tL";
      }
      else if (obscurityFlags == 6) {   // tR
         obscurity = "tR";
      }
      else if (obscurityFlags == 7) {   // tLR
         obscurity = "tLR";
      }
      else if (obscurityFlags == 8) {   // b
         obscurity = "b";
      }
      else if (obscurityFlags == 9) {   // bL
         obscurity = "bL";
      }
      else if (obscurityFlags == 12) {   // bR
         obscurity = "bR";
      }
      else if (obscurityFlags == 13) {   // bLR
         obscurity = "bLR";
      }
      else if (obscurityFlags == 10) {   // tb (prob never used)
         obscurity = "tb";
      }
      else if (obscurityFlags == 11) {   // tbL
         obscurity = "tbL";
      }
      else if (obscurityFlags == 14) {   // tbR
         obscurity = "tbR";
      }
      else if (obscurityFlags == 15) {   // tbLR
         obscurity = "tbLR";
      }
      
      return obscurity;
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

}

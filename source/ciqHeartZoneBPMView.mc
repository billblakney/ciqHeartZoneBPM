using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class ciqHeartZoneBPMView extends Ui.DataField {

   hidden var mValue;

   hidden var lastWidth = 0;
   hidden var lastHeight = 0;
   hidden var lastObscurity = 0;

   function initialize() {
      DataField.initialize();
      mValue = 0.0f;
   }

   // Set your layout here. Anytime the size of obscurity of
   // the draw context is changed this will be called.
   function onLayout(dc) {
      var obscurityFlags = DataField.getObscurityFlags();

      var width = dc.getWidth();
      var height = dc.getHeight();

      Sys.println("===> " + width + "," + lastWidth + "," + height + "," + lastHeight + "," + obscurityFlags + "," + lastObscurity);
      if (width != lastWidth || height != lastHeight || obscurityFlags != lastObscurity) {

         var topleft = OBSCURE_TOP | OBSCURE_LEFT;
         var topright = OBSCURE_TOP | OBSCURE_RIGHT;
         var bottomleft = OBSCURE_BOTTOM | OBSCURE_LEFT;
         var bottomright = OBSCURE_BOTTOM | OBSCURE_RIGHT;

         Sys.println("tl,tr,bl,br "
               + topleft + "," + topright + ","
               + bottomleft + "," + bottomright);

         var font = Gfx.FONT_NUMBER_MILD;

         // Top left quadrant so we'll use the top left layout
         if (obscurityFlags == (OBSCURE_TOP & OBSCURE_LEFT)) {
            Sys.println("using TopLeft layout " + width + "," + height + "," + obscurityFlags);
            View.setLayout(Rez.Layouts.TopLeftLayout(dc));

            // Top right quadrant so we'll use the top right layout
         } else if (obscurityFlags == (OBSCURE_TOP | OBSCURE_RIGHT)) {
            Sys.println("using TopRight layout " + width + "," + height + "," + obscurityFlags);
            View.setLayout(Rez.Layouts.TopRightLayout(dc));

            // Bottom left quadrant so we'll use the bottom left layout
         } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_LEFT)) {
            Sys.println("using BottomLeft layout " + width + "," + height + "," + obscurityFlags);
            View.setLayout(Rez.Layouts.BottomLeftLayout(dc));

            // Bottom right quadrant so we'll use the bottom right layout
         } else if (obscurityFlags == (OBSCURE_BOTTOM | OBSCURE_RIGHT)) {
            //            Sys.println("using BottomRight layout " + width + "," + height + "," + obscurityFlags);
            View.setLayout(Rez.Layouts.BottomRightLayout(dc));

            // Use the generic, centered layout
         } else {
            Sys.println("----------> using Main layout " + width + "," + height + "," + obscurityFlags);
            var dims;
            var fontIsSet = false;

            dims = dc.getTextDimensions("888", Gfx.FONT_NUMBER_THAI_HOT); 
            Sys.println("thai hot dims: " + dims[0] + "," + dims[1]);
            if (dims[0] < width && dims[1] < height) {
               font = Gfx.FONT_NUMBER_THAI_HOT;
               fontIsSet = true;
               Sys.println("using thai hot");
            }

            dims = dc.getTextDimensions("888", Gfx.FONT_SYSTEM_NUMBER_THAI_HOT); 
            Sys.println("system thai hot dims: " + dims[0] + "," + dims[1]);
            if (dims[0] < width && dims[1] < height) {
               font = Gfx.FONT_SYSTEM_NUMBER_THAI_HOT;
               fontIsSet = true;
               Sys.println("using system thai hot");
            }

            dims = dc.getTextDimensions("888", Gfx.FONT_NUMBER_HOT); 
            Sys.println("hot dims: " + dims[0] + "," + dims[1]);
            if (!fontIsSet && dims[0] < width && dims[1] < height) {
               font = Gfx.FONT_NUMBER_HOT;
               fontIsSet = true;
               Sys.println("using hot");
            }

            dims = dc.getTextDimensions("888", Gfx.FONT_NUMBER_MEDIUM); 
            Sys.println("medium dims: " + dims[0] + "," + dims[1]);
            if (!fontIsSet && dims[0] < width && dims[1] < height) {
               font = Gfx.FONT_NUMBER_MEDIUM;
               fontIsSet = true;
               Sys.println("using medium");
            }

            dims = dc.getTextDimensions("888", Gfx.FONT_NUMBER_MILD); 
            Sys.println("mild dims: " + dims[0] + "," + dims[1]);
            if (!fontIsSet) {
               font = Gfx.FONT_NUMBER_MILD;
               fontIsSet = true;
               Sys.println("using low");
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
         }

         View.findDrawableById("label").setText(Rez.Strings.label);
      }

      lastWidth = width;
      lastHeight = height;
      lastObscurity = obscurityFlags;

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

}

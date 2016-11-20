using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

/*
 * Draws the elements of the canvas for HeartZoneBMApp.
 * 
 * This drawable uses the following params:
 * x - horizontal center for drawing text
 * y - vertical center for drawing text
 * font - font for text
 * bar_mode - zone bar placement (see below)
 * bar_height - height of zone strip
 * 
 * The x, y, and font params are required. Others are optional.
 * 
 * bar_mode takes one of three values. Value 2 is the default
 *    0 - Paint bar on bottom of the field
 *    1 - Paint bar on top of the field
 *    2 - Paint bar on bottom and top of the field
 *    
 *  If bar_height is not specified, it is computed as a fraction of the
 *  text height.
 */
class Painter extends Ui.Drawable {

    hidden var mX;
    hidden var mY;
    hidden var mWidth;
    hidden var mHeight;
    hidden var mFont;
    hidden var mBarMode;
    hidden var mBarHeight;

   /*-------------------------------------------------------------------------
    * Initialize the params.
    * The x, y, and font values are required. Others are optional; default
    * default values are set for params not in the params dictionary.
    *------------------------------------------------------------------------*/
    function initialize(params)
    {
        Drawable.initialize(params);

        mX = params.get(:x);
        mY = params.get(:y);
        mFont = params.get(:font);
        
        if (params.hasKey(:bar_mode)) {
           mBarMode = params.get(:bar_mode);
        }
        else {
           mBarMode = 2;
        }
        
        if (params.hasKey(:bar_height)) {
           mBarHeight = params.get(:bar_height);
        }
        else {
           mBarHeight = 0;
        }
    }
    
   /*-------------------------------------------------------------------------
    * Compute values that are dependent on the field dimensions.
    * This method should be called after initialize, but before any of the
    * "draw" methods are called.
    *------------------------------------------------------------------------*/
    function normalize(width,height) {
       
       mWidth = width;
       mHeight = height;
       
       if (mBarHeight == 0) {
          mBarHeight = 0.15 * height;
       }
       
       if (mX.equals("center")) {
          mX = width/2;
       }
       if (mY.equals("center")) {
          mY = height/2;
       }
    }

   /*-------------------------------------------------------------------------
    * Fills the background with a specified color.
    *------------------------------------------------------------------------*/
    function drawBackground(dc,color) {
       dc.setColor(color,color);
       dc.clear();
    }

   /*-------------------------------------------------------------------------
    * Draws the zone bar(s) according to the specified color.
    *------------------------------------------------------------------------*/
    function drawZoneBar(dc,color) {
       dc.setColor(color,color);
       if (mBarMode >= 1) {
          dc.fillRectangle(0,0,mWidth,mBarHeight);
       }
       if (mBarMode != 1) {
          dc.fillRectangle(0,mHeight-mBarHeight+1,mWidth,mBarHeight);
       }
    }

   /*-------------------------------------------------------------------------
    * Draws text in the specified color.
    *------------------------------------------------------------------------*/
    function drawText(dc,fgColor,bgColor,txt) {
//       dc.setColor(fgColor,bgColor);
       dc.setColor(fgColor,Gfx.COLOR_TRANSPARENT);
       dc.drawText(mX, mY, mFont, txt, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
    }
}

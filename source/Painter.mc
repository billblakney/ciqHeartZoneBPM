using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class Painter extends Ui.Drawable {

    hidden var mX;
    hidden var mY;
    hidden var mWidth;
    hidden var mHeight;
    hidden var mFont;
    hidden var mBottom;
    hidden var mBarMode;
    hidden var mBarHeight;

    function initialize(params)
    {
        Drawable.initialize(params);

        mX = params.get(:x);
        mY = params.get(:y);
        mFont = params.get(:font);
        
        if (params.hasKey("top")) {
           mBottom = false;
        }
        else {
           mBottom = true;
        }
        
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

    function drawBackground(dc,color) {
       dc.setColor(color,color);
       dc.clear();
    }

    function drawZoneBar(dc,color) {
       dc.setColor(color,color);
       if (mBarMode >= 1) {
          dc.fillRectangle(0,0,mWidth,mBarHeight);
       }
       if (mBarMode != 1) {
          dc.fillRectangle(0,mHeight-mBarHeight+1,mWidth,mBarHeight);
       }
    }

    function drawText(dc,color,txt) {
       dc.setColor(color,Gfx.COLOR_TRANSPARENT);
       dc.drawText(mX, mY, mFont, txt, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
    }
}

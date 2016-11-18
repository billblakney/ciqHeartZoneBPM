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

//        var dictionary = {
//            :identifier => "Painter"
//        };

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
           mBarMode = 0;
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
          mBarHeight = height/10;
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
          dc.fillRectangle(0,mHeight-mBarHeight,mWidth,mBarHeight);
       }
    }

//    function drawTextBg(dc,color,txt) {
//       dc.setColor(color,color);
//       var dims = dc.getTextDimensions(txt,mFont);
//       var txtW = 1.2 * dims[0];
//       var txtH = 1.2 * dims[1];
//       dc.fillRoundedRectangle(mX-txtW/2,mY-txtH/2,txtW,txtH,txtH/5);
//    }

    function drawText(dc,color,txt) {
       dc.setColor(color,Gfx.COLOR_TRANSPARENT);
       dc.drawText(mX, mY, mFont, txt, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
    }

//    function draw(dc,txt) {
//       dc.clear();
//       dc.fillRectangle(0,0,mWidth,10);
//       dc.drawText(mX, mY, mFont, txt, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
//    }
}

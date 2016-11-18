using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class Painter extends Ui.Drawable {

    hidden var mX;
    hidden var mY;
    hidden var mWidth;
    hidden var mHeight;
    hidden var mFont;
    hidden var mBottom;
    hidden var mThickness;

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
        
        if (params.hasKey("thick")) {
           mThickness = params.get(:thick);
        }
        else {
           mThickness = 0;
        }
    }
    
    function normalize(width,height) {
       
       mWidth = width;
       mHeight = height;
       
       if (mThickness == 0) {
          mThickness = height/10;
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
       dc.fillRectangle(0,0,mWidth,mThickness);
       dc.fillRectangle(0,mHeight-mThickness,mWidth,mThickness);
    }

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

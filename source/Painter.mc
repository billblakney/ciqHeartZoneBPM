using Toybox.WatchUi as Ui;

class Painter extends Ui.Drawable {

//    hidden var mBackColor;
//    hidden var mBorderColor;
    hidden var mX;
    hidden var mY;
    hidden var mFont;

    function initialize(params)
    {
        Drawable.initialize(params);

//        var dictionary = {
//            :identifier => "Painter"
//        };

        mX = params.get(:x);
        mY = params.get(:y);
        mFont = params.get(:font);
    }
    
    function normalize(width,height) {
       
       if (mX.equals("center")) {
          mX = width/2;
       }
       if (mY.equals("center")) {
          mY = height/2;
       }
    }

//    function setBackColor(color) {
//        mBackColor = color;
//    }
//
//    function setBorderColor(color) {
//        mBorderColor = color;
//    }

    function draw(dc,txt) {
//       dc.setColor(fgColor,bgColor);
       dc.clear();
       dc.drawText(mX, mY, mFont, txt, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
//        dc.setColor(fgColor,bgColor);
//var height = Gfx.getFontHeight(mFont);
//var width = Gfx.getFontWidth(mFont);
//var dims = dc.getTextDimensions("888", mFont);
//Sys.println("TEXT w,h: " + dims[0] + "," + dims[1]);
//        dc.fillCircle(mX,mY,mFont);
    }

}

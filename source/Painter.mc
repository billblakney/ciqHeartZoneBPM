using Toybox.WatchUi as Ui;

class Painter extends Ui.Drawable {

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

    function draw(dc,txt) {

       dc.clear();
       dc.drawText(mX, mY, mFont, txt, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
    }
}

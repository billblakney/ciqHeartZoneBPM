using Toybox.WatchUi as Ui;
using Toybox.Application as App;
using Toybox.Graphics as Gfx;

class Background extends Ui.Drawable {

    hidden var mBackColor;
    hidden var mBorderColor;
    hidden var mCenterX;
    hidden var mCenterY;
    hidden var mRadius;

    function initialize(params)
    {
        Drawable.initialize(params);

//        var dictionary = {
//            :identifier => "Background"
//        };

        mCenterX = params.get(:center_x);
        mCenterY = params.get(:center_y);
        mRadius = params.get(:radius);
    }

    function setBackColor(color) {
        mBackColor = color;
    }

    function setBorderColor(color) {
        mBorderColor = color;
    }

    function draw(dc) {
        dc.setColor(Gfx.COLOR_TRANSPARENT, mBorderColor);
        dc.clear();
        dc.setColor(mBackColor,mBackColor);
        dc.fillCircle(mCenterX,mCenterY,mRadius);
    }

}

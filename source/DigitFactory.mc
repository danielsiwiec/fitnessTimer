using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class DigitFactory extends Ui.PickerFactory {
    hidden var mFormatString = "%d";
    hidden var mFont = Gfx.FONT_NUMBER_HOT;
    hidden var options;

    function initialize(optionsArray) {
      options = optionsArray;
      PickerFactory.initialize();
    }

    function getValue(index) {
      return options[index];
    }

    function getDrawable(index, selected) {
        return new Ui.Text( { :text => options[index].format(mFormatString), :color=>Gfx.COLOR_WHITE, :font=> mFont, :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_CENTER } );
    }

    function getSize() {
        return options.size();
    }
}

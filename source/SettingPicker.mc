using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class SettingPickerView extends Ui.Picker {

	function initialize(titleText, options){
		var title = new Ui.Text({:text => titleText, :locX=>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_TOP, :color=>Gfx.COLOR_WHITE});
		Ui.Picker.initialize({:title => title,:pattern => createNumberPattern(options)});
	}

	function createNumberPattern(options) {
		return [ new DigitFactory(options) ];
	}

	function onUpdate(dc) {
		dc.setColor( Gfx.COLOR_BLACK, Gfx.COLOR_BLACK );
    dc.clear();
    dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );
  }
}

class SettingPickerDelegate extends Ui.PickerDelegate {

	var settingsSymbol;

  function initialize(symbol){
		settingsSymbol = symbol;
    PickerDelegate.initialize();
  }

	function onAccept(values) {
    settings[settingsSymbol] = values[0];
    Ui.popView( Ui.SLIDE_IMMEDIATE );
  }

}

using Toybox.Application as App;
using Toybox.WatchUi as Ui;

var settings = {};
var model;

class FitnessTimerApp extends App.AppBase {

  function initialize() {
    AppBase.initialize();
  }

  function getInitialView() {
    return [ new StartView() ];
  }

  function onStop(state) {
    if (model.session.isRecording()) {
      var result = model.session.stop() && model.session.discard();
    }
  }

}

class StartView extends Ui.View {

  function initialize() {
    View.initialize();
  }

	function onShow() {
    if(settings[:rounds] == null) {
      Ui.pushView(new SettingPickerView("ROUNDS", [1,2,3,4,5,6,7,8,9,10]), new SettingPickerDelegate(:rounds), Ui.SLIDE_IMMEDIATE);
    } else if (settings[:goTime] == null) {
      Ui.pushView(new SettingPickerView("GO TIME", [10, 20, 30, 60, 90, 120]), new SettingPickerDelegate(:goTime), Ui.SLIDE_IMMEDIATE);
    } else if (settings[:restTime] == null) {
      Ui.pushView(new SettingPickerView("REST TIME", [0, 5, 10, 20, 30, 60, 90, 120]), new SettingPickerDelegate(:restTime), Ui.SLIDE_IMMEDIATE);
    } else {
      model = new TimerModel(settings);
      Ui.pushView( new TimerView(model), new TimerDelegate(model), Ui.SLIDE_IMMEDIATE);
    }
    return true;
	}
}

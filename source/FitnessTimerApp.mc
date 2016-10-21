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
    switchToRoundsSelect();
    return true;
	}

  function switchToRoundsSelect(){
    var roundsPicker = new SettingPickerView("ROUNDS", [1,2,3,4,5,6,7,8,9,10]);
    var roundsPickerDelegate = new SettingPickerDelegate(:rounds, self.method(:switchToGoTimeSelect));
    Ui.pushView(roundsPicker, roundsPickerDelegate, Ui.SLIDE_IMMEDIATE );
  }

  function switchToGoTimeSelect(){
    var goTimePicker = new SettingPickerView("GO TIME", [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 90, 120]);
    var goTimePickerDelegate = new SettingPickerDelegate(:goTime, self.method(:switchToRestTimeSelect));
    Ui.pushView(goTimePicker, goTimePickerDelegate, Ui.SLIDE_IMMEDIATE );
  }

  function switchToRestTimeSelect(){
    var restTimePicker = new SettingPickerView("REST TIME", [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 90, 120]);
    var restTimePickerDelegate = new SettingPickerDelegate(:restTime, self.method(:switchToTimer));
    Ui.pushView(restTimePicker, restTimePickerDelegate, Ui.SLIDE_IMMEDIATE );
  }

  function switchToTimer(){
    model = new TimerModel(settings);
    var timerView = new TimerView(model);
    var timerDelegate = new TimerDelegate(model);
    Ui.pushView(timerView, timerDelegate, Ui.SLIDE_IMMEDIATE );
  }
}

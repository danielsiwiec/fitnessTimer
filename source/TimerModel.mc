using Toybox.Timer as Timer;
using Toybox.WatchUi as Ui;
using Toybox.Attention as Attention;
using Toybox.ActivityRecording as ActivityRecording;
using Toybox.Sensor as Sensor;
using Toybox.Time as Time;

class TimerModel{

	var REST_TIME;
	var PREP_TIME;
	var WORK_TIME;
	var TOTAL_ROUNDS;
	const HAS_TONES = Attention has :playTone;

	var counter;
	var round = 0;
	var phase = :prep;
	var done = false;
	var session = ActivityRecording.createSession({:sport => ActivityRecording.SPORT_TRAINING, :subSport => ActivityRecording.SUB_SPORT_CARDIO_TRAINING, :name => "Interval training"});

	hidden var refreshTimer = new Timer.Timer();
	hidden var sensors = Sensor.setEnabledSensors([Sensor.SENSOR_HEARTRATE]);

	function initialize(settings){
		REST_TIME = settings[:restTime];
		PREP_TIME = REST_TIME;
		WORK_TIME = settings[:goTime];
		TOTAL_ROUNDS = settings[:rounds];

		counter = PREP_TIME;
	}

	function start(){
		refreshTimer.start(method(:refresh), 1000, true);
		startBuzz();
		Ui.requestUpdate();
	}

	function refresh(){
		if (counter > 1){
			counter--;
		} else {
			if (phase == :prep) {
				session.start();
				phase = :work;
				counter = WORK_TIME;
				round++;
				intervalBuzz();
			} else if (phase == :work) {
				phase = :rest;
				counter = REST_TIME;
				intervalBuzz();
			}	else if (phase == :rest) {
				if (round == TOTAL_ROUNDS){
					completeSession();
					stopBuzz();
				} else {
					phase = :work;
					counter = WORK_TIME;
					round++;
					intervalBuzz();
				}
			}
		}
		Ui.requestUpdate();
	}

	function completeSession() {
		done = true;
		session.stop();
		session.save();
		refreshTimer.stop();
	}

	function startBuzz(){
		var foo = HAS_TONES && beep(Attention.TONE_LOUD_BEEP);
		vibrate(1500);
	}

	function stopBuzz(){
		var foo = HAS_TONES && beep(Attention.TONE_LOUD_BEEP);
		vibrate(1500);
	}

	function intervalBuzz(){
		var foo = HAS_TONES && beep(Attention.TONE_LOUD_BEEP);
		vibrate(1000);
	}

	function vibrate(duration){
		var vibrateData = [ new Attention.VibeProfile(  100, duration ) ];
		Attention.vibrate( vibrateData );
	}

	function beep(tone){
		Attention.playTone(tone);
		return true;
	}

	function dropSession() {
		refreshTimer.stop();
		if (session.isRecording()) {
			session.stop();
			session.discard();
		}
	}

}

console.log("inside timer");

$(document).on('turbo:click', function(event) {
  window.countdownTimer.kill();
});

$(document).on('turbo:load', function() {
  var countdownTimer = {
    timerContainer: null,
    progressBar: null,
    progressBarText: null,
    timeInput: null,
    timer: null,
    form: null,
    soundNotification: null,
    playSound: true,
    buttons: {
      play: null,
      stop: null,
      toggleFullscreen: null
    },

    parser: {
      getHumanTime : function(timeInSeconds) {
        var minutes = Math.floor(timeInSeconds / 60);
        var seconds = timeInSeconds % 60;
        return this.strPadLeft(minutes,'0',2) + ':' + this.strPadLeft(seconds,'0',2);
      },
      strPadLeft: function(string, pad, length) {
          return (new Array(length + 1).join(pad) + string).slice(-length);
      }
    },

    run: function() {
      if ($('#timer_container')[0] === undefined) {
        return;
      } else {
        this.initialize();
        this.bindButtons();
        this.reset();
      }
    },

    kill: function() {
      if(this.timer) this.timer.stop();
    },

    initialize: function() {

      var that = this;

      that.timerContainer   = $('#timer_container');
      that.progressBarText  = that.timerContainer.find('.timer .ui.progress-value');
      that.timeInput        = that.timerContainer.find('.timer .timeinput');
      that.form             = that.timerContainer.find('.timer form');
      that.soundNotification= that.timerContainer.find('.timer audio.sound-notification');

      that.progressBar = new ProgressBar.Circle('#timer_container .timer #progress', {
          color:        '#36f8b0',
          color:        '#636363',
          strokeWidth:  5,
          trailColor:   '#ffffff',
          trailColor:   '#eeeeee',
          trailWidth:   5,
          autoStyleContainer: false
      });

      that.timer = new Timer({
          onstart : function(millisec) {
              var sec = Math.round(millisec / 1000);
              that.progressBar.set(-(sec / 3600));
              that.progressBarText.text(that.parser.getHumanTime(sec));
          },
          ontick  : function(millisec) {
              var sec = Math.round(millisec / 1000);
              that.progressBar.set(-(sec / 3600));
              that.progressBarText.text(that.parser.getHumanTime(sec));
          },
          onpause : function() {
              //$timer.text('pause');
          },
          onstop  : function() {

          },
          onend   : function() {
              that.progressBarText.text(that.parser.getHumanTime(0));
              that.timerContainer.transition('tada', 800);
              that.progressBarText.transition('flash', 800);
              that.soundNotification[0].loop = true;
              var promise = that.soundNotification[0].play();
              if (promise !== undefined) {
                  //promise.catch(error => {
                      // Auto-play was prevented
                      // Show a UI element to let the user manually start playback
                      //@TODO : alert("Auto-play disabled");
                  //} else {
                    //).then(() => {
                        // Auto-play started
                  //
                  //});
              }
              var animation = setInterval(function(){
                that.timerContainer.transition('tada', 800);
                that.progressBarText.transition('flash', 800);
              }, 2300);
              $(document).on('click', function(){
                clearInterval(animation);
                that.soundNotification[0].pause();
                that.soundNotification[0].load();
                $(document).unbind( "click" );
              });
          }
      });

      that.buttons.play = that.timerContainer.find('.timer button.play');
      that.buttons.stop = that.timerContainer.find('.timer button.stop');
      that.buttons.toggleFullscreen = that.timerContainer.find('.timer button.toggle-fullscreen');
    },

    bindButtons: function() {

      var that = this;

      that.buttons.play
        .on('click', function(event) {
          var icon = that.buttons.play.find('i.icon');
          if (that.timer.getStatus() === 'paused') {
              that.timer.start();
              icon.removeClass('play').addClass('pause');
          } else {
            if (that.timer.getStatus() === 'started') {
                that.timer.pause();
                icon.removeClass('pause').addClass('play');
            } else {
              var time = that.timeInput.val();
              if (!time) return;
              if (time > 60) return;
              if (isNaN(time)) return;
              that.timer.start(time * 60);
              icon.removeClass('play').addClass('pause');
              that.buttons.stop.removeClass('disabled');
            }
          }
        });

      that.buttons.stop
        .on('click', function(event) {
          if (/started|paused|stopped/.test(that.timer.getStatus())) {
              that.timer.stop();
              that.reset();
              that.buttons.stop.addClass('disabled');
              that.buttons.play.find('i.icon').removeClass('pause').addClass('play');
          }
        });

      if (screenfull.enabled) {
        var coreContent = that.timerContainer[0];
        that.buttons.toggleFullscreen.on('click', function(event) {
            screenfull.toggle(coreContent);
        });
        document.addEventListener(screenfull.raw.fullscreenchange, function() {
            if(!screenfull.isFullscreen) {
              that.onExitFullscreen();
            }else{
              that.onEnterFullscreen();
            }
        });
      } else {
        that.buttons.toggleFullscreen.addClass('disabled');
      }

      var popup = $('#timer_container .timer .ui.progress-value').popup({
        inline: true,
        position: 'top center',
        on: 'click',
        variation: "large",
        onVisible: function() {
          that.timeInput.focus().select();
        }
      });

      that.form
        .form({
          fields: {
            'timeinput' : 'integer[1..60]'
          }
        })
      ;
      that.form.on('submit', function(event) {
        event.preventDefault();
        if (that.form.form('is valid')) {
          var time = that.timeInput.val();
          document.cookie = "timer_minutes=" + time;
          if (that.timer.getStatus() === 'started') {
              setTimeout(function(){
                that.timer.start(time * 60);
              }, 100);
          }
          that.timer.stop();
          that.reset();
          popup.click();
        }
      });
    },

    reset: function() {
      var that = this;

      var sec = that.timeInput.val() * 60;
      that.progressBar.set(-(sec / 3600));
      that.progressBarText.text(that.parser.getHumanTime(sec));
    },

    onEnterFullscreen: function() {
      var that = this;
      var popup = that.timerContainer.find('.timer .ui.progress-value').next('.popup');
      popup.find('.warning').show();
      popup.find('form').hide();
      that.timerContainer.find('.timer button.toggle-fullscreen i.icon').removeClass('expand').addClass('compress');
    },

    onExitFullscreen: function() {
      var that = this;
      var popup = that.timerContainer.find('.timer .ui.progress-value').next('.popup');
      popup.find('.warning').hide();
      popup.find('form').show();
      that.timerContainer.find('.timer button.toggle-fullscreen i.icon').removeClass('compress').addClass('expand');
    }
  };
  window.countdownTimer = countdownTimer;
  window.countdownTimer.run();
});

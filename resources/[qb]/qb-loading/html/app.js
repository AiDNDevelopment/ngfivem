const { ref } = Vue

// Customize language for dialog menus and carousels here

const load = Vue.createApp({
  setup () {
    return {
      CarouselText1: 'If you are downed you have 6 minutes before you are automatically admitted to the emergency room.',
      CarouselSubText1: 'Photo captured by: Markyoo#8068',
      CarouselText2: `We've got plenty for you to waste your money on!`,
      CarouselSubText2: 'Photo captured by: ihyajb#9723',
      CarouselText3: 'Join our development tests and earn rewards!.',
      CarouselSubText3: 'Photo captured by: FLAPZ[INACTIV]#9925',
      CarouselText4: 'Guess who ran out of things to put as we went on xD',
      CarouselSubText4: 'Photo captured by: Robinerino#1312',

      DownloadTitle: 'Preparing our city for you 👍',
      DownloadDesc: "Please hold up for a moment whilst we download all of the resources and assets needed to join our city. \n\nOnce the download has been completed successfully, you will be sent into our city and this screen will dissapear. Please don't leave or turn off your PC",

      SettingsTitle: 'Settings',
      AudioTrackDesc1: 'When disabled the current audio-track playing will be stopped.',
      AutoPlayDesc2: 'When disabled carousel images will stop cycling and remain on the last shown.',
      PlayVideoDesc3: 'When disabled video will stop playing and remain paused.',

      KeybindTitle: 'Default Keybinds',
      Keybind1: 'Open Inventory',
      Keybind2: 'Cycle Proximity',
      Keybind3: 'Open Phone',
      Keybind4: 'Toggle Seat Belt',
      Keybind5: 'Open Target Menu',
      Keybind6: 'Radial Menu',
      Keybind7: 'Open Hud Menu',
      Keybind8: 'Talk Over Radio',
      Keybind9: 'Open Scoreboard',
      Keybind10: 'Vehicle Locks',
      Keybind11: 'Toggle Engine',
      Keybind12: 'Pointer Emote',
      Keybind13: 'Keybind Slots',
      Keybind14: 'Hands Up Emote',
      Keybind15: 'Use Item Slots',
      Keybind16: 'Cruise Control',

      version:'1.0.0',
      updatedate: '04/08/2023', /*UK time ofc*/
      

      firstap: ref(true),
      secondap: ref(true),
      thirdap: ref(true),
      firstslide: ref(1),
      secondslide: ref('1'),
      thirdslide: ref('5'),
      audioplay: ref(true),
      playvideo: ref(true),
      download: ref(true),
      settings: ref(false),
    }
  }
})

load.use(Quasar, { config: {} })
load.mount('#loading-main')

var audio = document.getElementById("audio");
audio.volume = 0.05;

function audiotoggle() {
    var audio = document.getElementById("audio");
    if (audio.paused) {
        audio.play();
    } else {
        audio.pause();
    }
}

function videotoggle() {
    var video = document.getElementById("video");
    if (video.paused) {
        video.play();
    } else {
        video.pause();
    }
}

let count = 0;
let thisCount = 0;

const handlers = {
    startInitFunctionOrder(data) {
        count = data.count;
    },

    initFunctionInvoking(data) {
        document.querySelector(".thingy").style.left = "0%";
        document.querySelector(".thingy").style.width = (data.idx / count) * 100 + "%";
    },

    startDataFileEntries(data) {
        count = data.count;
    },

    performMapLoadFunction(data) {
        ++thisCount;

        document.querySelector(".thingy").style.left = "0%";
        document.querySelector(".thingy").style.width = (thisCount / count) * 100 + "%";
    },
};

window.addEventListener("message", function (e) {
    (handlers[e.data.eventName] || function () {})(e.data);
});

function progressBar() {    
    let progress = 0;
    const progressBarInner = document.querySelector('.progress-bar-inner');
    const interval = setInterval(() => {
        progress += 10;
        progressBarInner.style.width = `${progress}%`;
        if (progress >= 100) {
            clearInterval(interval);
            // You can add code here to hide the loading screen and show the game UI
        }
    }, 500);
}

let text = 'We are loading our city for you...';
let index = 0;
let typingText = document.getElementById('typing-text');

function typeText() {
    let typingInterval = setInterval(() => {
      typingText.textContent += text.charAt(index);
      index++;
      if (index === text.length) {
        clearInterval(typingInterval);
        setTimeout(() => {
          index = 0;
          typingText.textContent = '';
        }, 3000);
      }
    }, 100);
  }
  
  setInterval(typeText, 3000);


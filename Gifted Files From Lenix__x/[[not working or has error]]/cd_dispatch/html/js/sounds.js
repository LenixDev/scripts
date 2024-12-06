var panicSound;
var panicSoundAvailable = true;

var notificationSound;
var notificationSoundAvailable = true;

var soundMuted = false;

function playPanicSound(){
    if(panicSoundAvailable && !soundMuted){ // Check if the sound stopped playing
        panicSoundAvailable = false; // Set the avaliability to false, since we are going to play it now.
        
        panicSound.volume = 0.5; // Set the volume to 0.5 (or adjust to your own preference)

        panicSound.play().then(() => {
          panicSound.currentTime = 0; // Reset the position to start
          panicSoundAvailable = true; // Sound stopped playing, so it is now avaliable
        });
      }
}

function playNotificationSound(){
  if(notificationSoundAvailable && !soundMuted){ // Check if the sound stopped playing
    notificationSoundAvailable = false; // Set the avaliability to false, since we are going to play it now.
    
    notificationSound.volume = 0.5; // Set the volume to 0.5 (or adjust to your own preference)

    notificationSound.play().then(() => {
      notificationSound.currentTime = 0; // Reset the position to start
      notificationSoundAvailable = true; // Sound stopped playing, so it is now avaliable
    });
  }
}
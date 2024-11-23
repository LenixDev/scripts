const regged = [];
AddEventHandler('_npx_uiReady', () => {
    regged.forEach((eventName) => exports['np-ui'].RegisterUIEvent(eventName));
});
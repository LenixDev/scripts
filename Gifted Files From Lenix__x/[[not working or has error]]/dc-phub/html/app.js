let CurrentDutyStatus = 'meow';
let CallSignMenu = false;
let PlayerJob = 'meow';
let HoveredPlayerInfo = {};
let CommanderCid = 'NO';
let DispatchCid = 'NO';
let oldTitle = '';
let FilterSettings = {
    'commanders': {
        data: '',
        enabled: false,
        priority: 5
    },
    'dispatch': {
        data: '',
        enabled: false,
        priority: 4
    },
    'duty': {
        data: '',
        enabled: false,
        priority: 3
    },
    'break': {
        data: '',
        enabled: false,
        priority: 2
    },
    'offduty': {
        data: '',
        enabled: false,
        priority: 1
    },
    'everyone': {
        data: '',
        enabled: true, // default
        priority: 0
    }
};



$('.app').resizable()

$(document).ready(function () {
    $("body").on("keyup", function (key) {
        if (key.which === 113 || key.which == 27 || key.which == 90) {
            $.post(`https://${GetParentResourceName()}/Close`, JSON.stringify({}));
            $('.meow-firstsection > .circle-container:nth-child(n+2)').css('display', 'none')
            $('.meow-secondsection > .circle-container:nth-child(n+1)').css('display', 'none')
            $('.officer').find('.grade').css('display', 'none');
            CallSignMenu = false;
            $('#main-title').html(`<div class="title-text">${PlayerJob === 'police' ? `Police List` : PlayerJob.label + ' List'}</div>`);
        }
    });
});

window.addEventListener("message", function (event) {
    let action = event.data.action;
    let data = event.data.data;
    let datatitle = event.data.title;
    DispatchCid = event.data.DisCid;
    CommanderCid = event.data.ComCid;
    if (action == 'open') {
        $('.circle-container:nth-child(1)').css('display', 'flex')
        $(".app").fadeIn(500);
        CurrentDutyStatus = event.data.duty
        PlayerJob = event.data.job
        $('#main-title').html(`<div class="title-text">${PlayerJob === 'police' ? `Police List` : PlayerJob.label + ' List'}</div>`);
    } else if (action == 'drag') {
        $(".app").fadeIn(500);
        $('.meow-firstsection > .circle-container:nth-child(1)').css('display', 'flex')
        $('.meow-firstsection > .circle-container:nth-child(2)').css('display', 'flex')
        $('.meow-secondsection > .circle-container:nth-child(1)').css('display', 'flex')
        CurrentDutyStatus = event.data.duty
        PlayerJob = event.data.job
        $('#main-title').html(`<div class="title-text">${PlayerJob === 'police' ? `Police List` : PlayerJob.label + ' List'}</div>`);
    } else if (action == 'close') {
        $(".app").fadeOut(500);
        $('.circle-container:nth-child(1)').css('display', 'none')
    } else if (action == 'refresh') {
        $('.officers').empty();
        $("#count").html(datatitle);
        $('#commanders').append(`<div class="title"><div class="title-text">Commanders</div></div>`)
        $('#dispatch').append(`<div class="title"><div class="title-text">Dispatch</div></div>`)
        $('#duty').append(`<div class="title"><div class="title-text">Duty</div></div>`)
        $('#break').append(`<div class="title"><div class="title-text">Break</div></div>`)
        $('#offduty').append(`<div class="title"><div class="title-text">Off Duty</div></div>`)
        $.each(data, function (i, valueOfElement) {
            $('#everyone').append(`
            <div id='Officer-${i}' data-cid='${data[i]['CitizenId']}' class='officer'>
                <div class='firstuselessinfo'>
                    <div class='callsign'>${data[i]['CallSign']}</div>
                    <div class='fa9lh'>|</div>
                    <div class='name'>${data[i]['OfficerName']}</div>
                </div>
                <div class='seconduselessinfo'>
                    <div id='Radio-${i}' class='radio'>${data[i]['Radio']}</div>
                </div>
            </div>
            `)
            if (i === DispatchCid) {
                if (data[i]['Break']) {
                    return
                }
                $('#dispatch').append(`
                <div id='Officer-${i}' data-cid='${data[i]['CitizenId']}' class='officer'>
                    <div class='firstuselessinfo'>
                        <div class='callsign'>${data[i]['CallSign']}</div>
                        <div class='fa9lh'>|</div>
                        <div class='name'>${data[i]['OfficerName']}</div>
                    </div>
                    <div class='seconduselessinfo'>
                        <div id='Radio-${i}' class='radio'>${data[i]['Radio']}</div>
                    </div>
                </div>
                `)
            }
            if (i === CommanderCid) {
                if (data[i]['Break']) {
                    return
                }
                $('#commanders').append(`
                <div id='Officer-${i}' data-cid='${data[i]['CitizenId']}' class='officer'>
                    <div class='firstuselessinfo'>
                        <div class='callsign'>${data[i]['CallSign']}</div>
                        <div class='fa9lh'>|</div>
                        <div class='name'>${data[i]['OfficerName']}</div>
                    </div>
                    <div class='seconduselessinfo'>
                        <div id='Radio-${i}' class='radio'>${data[i]['Radio']}</div>
                    </div>
                </div>
                `)
            }
            if (data[i]['Duty']) {
                if (i == CommanderCid || i == DispatchCid || data[i]['Break']) {
                    return
                }
                $('#duty').append(`
                <div id='Officer-${i}' data-cid='${data[i]['CitizenId']}' class='officer'>
                    <div class='firstuselessinfo'>
                        <div class='callsign'>${data[i]['CallSign']}</div>
                        <div class='fa9lh'>|</div>
                        <div class='name'>${data[i]['OfficerName']}</div>
                    </div>
                    <div class='seconduselessinfo'>
                        <div id='Radio-${i}' class='radio'>${data[i]['Radio']}</div>
                    </div>
                </div>
                `)
            } else {
                if (i == CommanderCid || i == DispatchCid) {
                    return
                }
                if (!data[i]['Break']) {
                $('#offduty').append(`
                <div id='Officer-${i}' data-cid='${data[i]['CitizenId']}' class='officer'>
                    <div class='firstuselessinfo'>
                        <div class='callsign'>${data[i]['CallSign']}</div>
                        <div class='fa9lh'>|</div>
                        <div class='name'>${data[i]['OfficerName']}</div>
                    </div>
                    <div class='seconduselessinfo'>
                        <div id='Radio-${i}' class='radio'>${data[i]['Radio']}</div>
                    </div>
                </div>
                `)
            }
            }
            if (data[i]['Break']) {
                $('#break').append(`
                <div id='Officer-${i}' data-cid='${data[i]['CitizenId']}' class='officer'>
                    <div class='firstuselessinfo'>
                        <div class='callsign'>${data[i]['CallSign']}</div>
                        <div class='fa9lh'>|</div>
                        <div class='name'>${data[i]['OfficerName']}</div>
                    </div>
                    <div class='seconduselessinfo'>
                        <div id='Radio-${i}' class='radio'>${data[i]['Radio']}</div>
                    </div>
                </div>
                `)
            }
            AddButtons(data[i]);
        });
    }
})

AddButtons = function (i) {
    $(document).on("mouseenter", `#Officer-${i['CitizenId']}`, function (e) {
        $(this).find('.name').text(i['Grade'])
        $(this).find('.name').css('color', 'rgb(229, 99, 12)')
    });

    $(document).on("mouseleave", `#Officer-${i['CitizenId']}`, function (e) {
        $(this).find('.name').text(i['OfficerName'])
        $(this).find('.name').css('color', 'white')
    });

    $(document).on("click", `#Radio-${i['cid']}`, function (e) {
        $.post(`https://${GetParentResourceName()}/jointhisbitchradio`, JSON.stringify({
            radio: i['Radio']
        }));
    });
}



// FindDuplicateAndAdjust = function (Category) {
//     let visibleCids = {};

//     $('.officers .officer').css('display', 'none');
//     visibleCids = {};

//     $('.officers').each(function () {
//         let parentID = $(this).attr('id');

//         $('.officers#' + parentID + ' .officer').each(function () {
//             let cid = $(this).data('cid');
//             let shouldDisplay = false;

//             switch (parentID) {
//                 case 'Commanders':
//                     shouldDisplay = (Category === 'Commanders' || Category === 'Dispatch');
//                     break;
//                 case 'Dispatch':
//                     shouldDisplay = (Category === 'Dispatch' || Category === 'Break');
//                     break;
//                 case 'Duty':
//                     shouldDisplay = (Category === 'Duty' || Category === 'Break');
//                     break;    
//                 case 'Break':
//                     shouldDisplay = (Category === 'Break' || Category === 'OffDuty');
//                     break;
//                 case 'OffDuty':
//                     shouldDisplay = (Category === 'OffDuty');
//                     break;
//                 default:
//                     break;
//             }
//             let isDisplayed = $(this).css('display') !== 'none';

//             shouldDisplay = shouldDisplay || isDisplayed;
//             if (shouldDisplay && !(cid in visibleCids)) {
//                 $(this).css('display', 'flex');
//                 visibleCids[cid] = true;
//             }
//         });
//     });
// };
function getKeyByValue(value) {
    let priority = {
        "commanders": 5,
        "dispatch": 4,
        "duty": 3,
        "break": 2,
        "offduty": 1
    }
    return Object.keys(priority).find(key => priority[key] === value);
}

FindDuplicateAndAdjust = function (Category, closed) {
    let priority = {
        "commanders": 5,
        "dispatch": 4,
        "duty": 3,
        "break": 2,
        "offduty": 1
    };

    let highestPriority = 0;
    let lowerPriorities = [];

    for (let key in FilterSettings) {
        if (!closed) {
            if (FilterSettings[key].enabled && priority[key] > highestPriority) {
                highestPriority = priority[key];
            }
        } else {
            if (FilterSettings[key].enabled && priority[key] !== highestPriority) {
                lowerPriorities.push(priority[key]);
            }
        }
    }
    $('.officers#' + Category + ' .officer').show();
    for (let key in FilterSettings) {
        if (FilterSettings[key]['enabled']) {
            let categoryPriority = priority[key];
            $('.officers .officer').each(function () {
                let officerCategory = $(this).parent().attr('id');
                let officerCid = $(this).data('cid');
                officerPriority = priority[officerCategory]
                if (officerPriority > categoryPriority) {
                    if (FilterSettings[getKeyByValue(officerPriority)]['enabled']) {
                        $('#' + getKeyByValue(categoryPriority)).find('[data-cid="' + officerCid + '"]').css('display', 'none');
                    }
                }
            });
        }
    }
    if (closed) {
        for (let key in FilterSettings) {
            let categoryPriority = priority[key];
            $('.officers .officer').each(function () {
                let officerCategory = $(this).parent().attr('id');
                let officerCid = $(this).data('cid');
                officerPriority = priority[officerCategory]
                if (officerPriority > categoryPriority) {
                    if (!FilterSettings[getKeyByValue(officerPriority)]['enabled']) {
                        if ($('#' + getKeyByValue(categoryPriority)).find('[data-cid="' + officerCid + '"]').length == 1) {
                            if ($('#' + getKeyByValue(categoryPriority)).find('[data-cid="' + officerCid + '"]').css('display') == 'none') {
                                $('#' + getKeyByValue(categoryPriority)).find('[data-cid="' + officerCid + '"]').css('display', 'flex');
                            }
                        }
                    }
                }
            });
        }
    }
};


// FindDuplicateAndAdjust = function(Category, closed) {
//     let priority = {
//         "commanders": 5,
//         "dispatch": 4,
//         "duty": 3,
//         "break": 2,
//         "offduty": 1
//     };

//     // Determine the highest priority among open categories
//     let highestPriority = 0;
//     for (let key in FilterSettings) {
//         if (!closed && FilterSettings[key].enabled && priority[key] > highestPriority) {
//             highestPriority = priority[key];
//         }
//     }

//     // Hide all officers initially
//     $('.officers .officer').hide();

//     // Show officers in the current category with the highest priority
//     $('.officers#' + Category + ' .officer').each(function() {
//         let officerPriority = priority[Category];
//         if (!closed && officerPriority === highestPriority) {
//             $(this).show();
//         }
//     });

//     // Hide officers from lower priority categories if not closed
//     if (!closed) {
//         for (let key in priority) {
//             if (priority[key] < highestPriority && FilterSettings[key].enabled) {
//                 $('.officers#' + key + ' .officer').each(function() {
//                     let cid = $(this).data('cid');
//                     let officerPriority = priority[key];
//                     if ($('.officers .officer[data-cid="' + cid + '"]:visible').length === 0 && officerPriority !== highestPriority) {
//                         $(this).hide();
//                     }
//                 });
//             }
//         }
//     }
// };





$('.circle').click(function (e) {
    e.preventDefault();
    var id = $(this).attr('id');
    switch (id) {
        case 'FilterMenu':
            if ($('.meow-firstsection > .circle-container:nth-child(3)').css('display') !== 'none') {
                $('.meow-firstsection > .circle-container:nth-child(n+3)').css('display', 'none')
                return
            }
            if ($('.meow-secondsection > .circle-container:nth-child(2)').css('display') == 'none') {
                $('.meow-secondsection > .circle-container').css('display', 'flex')
            } else {
                $('.meow-secondsection > .circle-container:nth-child(n+2)').css('display', 'none')
            }
            break;
        case 'FilterMenuCommanders':
            if (FilterSettings['commanders']['enabled']) {
                $(this).removeClass('circle-active')
                $('#commanders').css('display', 'none')
                FilterSettings['commanders']['enabled'] = false;
                FindDuplicateAndAdjust('commanders', true);
            } else {
                if ($('#commanders').children().length === 0) {
                    return $.post(`https://${GetParentResourceName()}/notify`, JSON.stringify({
                        why: 'There are no commanders available'
                    }));
                }
                if (FilterSettings['everyone']['enabled']) {
                    $('#everyone').removeClass('circle-active')
                    $('#everyone').css('display', 'none')
                    FilterSettings['everyone']['enabled'] = false;
                    // $('#main-title').css('display', 'none')
                }
                $(this).addClass('circle-active')
                $('#commanders').css('display', 'flex')
                FilterSettings['commanders']['enabled'] = true;
                FindDuplicateAndAdjust('commanders', false);
            }
            break;
        case 'FilterMenuDispatch':
            if (FilterSettings['dispatch']['enabled']) {
                $(this).removeClass('circle-active')
                $('#dispatch').css('display', 'none')
                FilterSettings['dispatch']['enabled'] = false;
                FindDuplicateAndAdjust('dispatch', true);
            } else {
                if ($('#dispatch').children().length === 0) {
                    return $.post(`https://${GetParentResourceName()}/notify`, JSON.stringify({
                        why: 'There are no dispatch available'
                    }));

                }
                if (FilterSettings['everyone']['enabled']) {
                    $('#everyone').removeClass('circle-active')
                    $('#everyone').css('display', 'none')
                    FilterSettings['everyone']['enabled'] = false;
                    // $('#main-title').css('display', 'none')
                }
                $(this).addClass('circle-active')
                $('#dispatch').css('display', 'flex')
                FilterSettings['dispatch']['enabled'] = true;
                FindDuplicateAndAdjust('dispatch', false);
            }
            break;
        case 'FilterMenuBreak':
            if (FilterSettings['break']['enabled']) {
                $(this).removeClass('circle-active')
                FilterSettings['break']['enabled'] = false;
                $('#break').css('display', 'none')
                FindDuplicateAndAdjust('break', true);
            } else {
                if ($('#break').children().length === 0) {
                    console.log('no officers available')
                    return $.post(`https://${GetParentResourceName()}/notify`, JSON.stringify({
                        why: 'There are no officer on break available'
                    }));
                }
                if (FilterSettings['everyone']['enabled']) {
                    $('#everyone').removeClass('circle-active')
                    $('#everyone').css('display', 'none')
                    FilterSettings['everyone']['enabled'] = false;
                    // $('#main-title').css('display', 'none')
                }
                $(this).addClass('circle-active')
                $('#break').css('display', 'flex')
                FilterSettings['break']['enabled'] = true;
                FindDuplicateAndAdjust('break', false);
            }
            break;
        case 'FilterMenuOffDuty':
            if (FilterSettings['offduty']['enabled']) {
                $(this).removeClass('circle-active')
                $('#offduty').css('display', 'none')
                FilterSettings['offduty']['enabled'] = false;
                FindDuplicateAndAdjust('offduty', true);
            } else {
                if ($('#offduty').children().length === 0) {
                    return $.post(`https://${GetParentResourceName()}/notify`, JSON.stringify({
                        why: 'There are no officer off duty available'
                    }));
                }
                if (FilterSettings['everyone']['enabled']) {
                    $('#everyone').removeClass('circle-active')
                    $('#everyone').css('display', 'none')
                    FilterSettings['everyone']['enabled'] = false;
                    // $('#main-title').css('display', 'none')
                }
                $(this).addClass('circle-active')
                $('#offduty').css('display', 'flex')
                FilterSettings['offduty']['enabled'] = true;
                FindDuplicateAndAdjust('offduty', false);
            }
            break;
        case 'FilterMenuOnDuty':
            if (FilterSettings['duty']['enabled']) {
                $(this).removeClass('circle-active')
                $('#duty').css('display', 'none')
                FilterSettings['duty']['enabled'] = false;
                FindDuplicateAndAdjust('duty', true);
            } else {
                if ($('#duty').children().length === 0) {
                    return $.post(`https://${GetParentResourceName()}/notify`, JSON.stringify({
                        why: 'There are no officer on duty available'
                    }));
                }
                if (FilterSettings['everyone']['enabled']) {
                    $('#everyone').removeClass('circle-active')
                    $('#everyone').css('display', 'none')
                    FilterSettings['everyone']['enabled'] = false;
                    // $('#main-title').css('display', 'none')
                }
                $(this).addClass('circle-active')
                $('#duty').css('display', 'flex')
                FilterSettings['duty']['enabled'] = true;
                FindDuplicateAndAdjust('duty', false);
            }
            break;
        case 'FilterMenuShowEveryone':
            if (FilterSettings['everyone']['enabled']) {
                $(this).removeClass('circle-active')
                $('#everyone').css('display', 'none')
                FilterSettings['everyone']['enabled'] = false;
            } else {
                $('.circle').removeClass('circle-active')
                $(this).addClass('circle-active')
                $('#main-title').css('display', 'flex')
                $('#everyone').css('display', 'flex')
                $('#duty').css('display', 'none')
                $('#offduty').css('display', 'none')
                $('#break').css('display', 'none')
                $('#dispatch').css('display', 'none')
                $('#commanders').css('display', 'none')
                FilterSettings['everyone']['enabled'] = true;
                FilterSettings['commanders']['enabled'] = false;
                FilterSettings['dispatch']['enabled'] = false;
                FilterSettings['break']['enabled'] = false;
                FilterSettings['offduty']['enabled'] = false;
                FilterSettings['duty']['enabled'] = false;
            }
            break;
        case 'settings':
            if ($('.meow-secondsection > .circle-container:nth-child(2)').css('display') !== 'none') {
                $('.meow-secondsection > .circle-container:nth-child(n+2)').css('display', 'none')
                return
            }
            if ($('.meow-firstsection > .circle-container:nth-child(3)').css('display') == 'none') {
                $('.meow-firstsection > .circle-container').css('display', 'flex')
                $('#cduty').parent().find('.circle-text').text(`${CurrentDutyStatus ? 'Sign out' : 'Sign in'}`)
            } else {
                $('.meow-firstsection > .circle-container:nth-child(n+3)').css('display', 'none')
            }
            break;
        case 'cduty':
            CurrentDutyStatus = !CurrentDutyStatus;
            $('#cduty').parent().find('.circle-text').text(`${CurrentDutyStatus ? 'Sign out' : 'Sign in'}`)
            $.post(`https://${GetParentResourceName()}/onduty`, JSON.stringify({}));
            break;
        case 'cbreak':
            $.post(`https://${GetParentResourceName()}/break`, JSON.stringify({}));
            break;
        case 'cdispatch':
            $.post(`https://${GetParentResourceName()}/dispatch`, JSON.stringify({}));
            break;
        case 'ccommander':
            $.post(`https://${GetParentResourceName()}/commander`, JSON.stringify({}));
            break;
        case 'changecallsign':
            CallSignMenu = !CallSignMenu
            oldTitle = $('#main-title').text();
            $('#main-title').html(`${CallSignMenu ? `<div class='meow2'><div class='meow-input'><input class='input-meow' maxlength='6' placeholder='CallSign'></div><div class='meow-buttons'><div id='Cancel' class='button'><p>Cancel</p></div><div id='Confirm' class='button'><p>Confirm</p></div></div>` : `<div class="title-text">${PlayerJob === 'police' ? `Police List` : PlayerJob.label + ' List'}</div>`}`);
            break;
    }
});

// $(document).on("mouseenter", ".officer", function (e) {
//     $(this).find('.name').text($(this).data('grade'))
//     $(this).find('.name').css('color', 'rgb(229, 99, 12)')
// });

// $(document).on("mouseleave", ".officer", function (e) {
//     $(this).find('.name').text($(this).data('name'))
//     $(this).find('.name').css('color', 'white')
// });

// $(document).on("click", ".radio", function (e) {
//     $.post(`https://${GetParentResourceName()}/jointhisbitchradio`, JSON.stringify({
//         radio : $(this).parent().data('radio')
//     }));
// });

$(document).on("click", ".button", function (e) {
    id = $(this).attr('id');
    val = $('.input-meow').val();
    switch (id) {
        case 'Confirm':
            $.post(`https://${GetParentResourceName()}/changecallsign`, JSON.stringify({
                callsign: val
            }));
            CallSignMenu = false;
            $('.title').html(`<div class="title-text">${PlayerJob === 'police' ? `Police List` : PlayerJob.label + ' List'}</div>`);
            break;
        case 'Cancel':
            CallSignMenu = false;
            $('#main-title').html(`<div class="title-text">${oldTitle/*PlayerJob === 'police' ? `Police List` : PlayerJob.label + ' List'*/}</div>`);
            oldTitle = '';
            break;
    }
});

$('.app').draggable({ disabled: false })
// $('.title').mouseenter(function () { 
// });

// $('.title').mouseleave(function () { 
//     $('.app').draggable({disabled: true})
// });

$('.circle').mouseenter(function () {
    $(this).parent().find('.circle-text').css('display', 'block');
});

$('.circle').mouseleave(function () {
    $(this).parent().find('.circle-text').css('display', 'none');
});
Config = {}

Config['Kidnapping'] = {
    ['nextNapping'] = 500, -- seconds
    ['start'] = { -- start boss ped
        ped = {model = 'a_m_m_soucent_02', pos = vector3(-1383.1, -640.04, 28.6733), heading = 211.53}
    },
    ['randomSpawnCoords'] = { -- kidnapped ped spawn
        {pos = vector3(-833.02, -350.74, 38.6802), heading = 243.42},
        {pos = vector3(-197.90, -864.60, 29.3243), heading = 246.03},
        {pos = vector3(-20.242, -1721.1, 29.2882), heading = 22.81}
    },
    ['query'] = {
        scenePos = vector3(568.450, -3123.8, 18.7686),
        sceneRot = vector3(0.0, 0.0, -90.0),
        laptopScenePos = vector3(565.9, -3123.0, 18.7686),
        laptopSceneRot = vector3(0.0, 0.0, 0.0),
        tripodPos = vector3(570.572, -3123.8, 17.7086),
        cameraPos = vector3(570.572, -3123.755, 19.2986),
        cameraHeading = -90.0
    },
    videoRecordItem = 'videorecord', -- add database item
    pedToKidnapped = 'a_m_m_prolhost_01',
    rewardCash = 80000, -- reward cash to video record
    randomRewardItems = { -- reward random item for sell video record
        'bread',
        'water'
    },
    ['objects_1'] = {
        'prop_cs_wrench'
    },
    ['animations_1'] = {
        {'wrench_idle_player', 'wrench_idle_victim', 'wrench_idle_chair', 'wrench_idle_wrench'},
        {'wrench_attack_left_player', 'wrench_attack_left_victim', 'wrench_attack_left_chair', 'wrench_attack_left_wrench'},
        {'wrench_attack_mid_player', 'wrench_attack_mid_victim', 'wrench_attack_mid_chair', 'wrench_attack_mid_wrench'},
        {'wrench_attack_right_player', 'wrench_attack_right_victim', 'wrench_attack_right_chair', 'wrench_attack_right_wrench'},
    },
    ['objects_2'] = {
        'w_am_jerrycan',
        'p_loose_rag_01_s'
    },
    ['animations_2'] = {
        {'waterboard_idle_player', 'waterboard_idle_victim', 'waterboard_idle_chair', 'waterboard_idle_jerrycan', 'waterboard_idle_rag'},
        {'waterboard_kick_player', 'waterboard_kick_victim', 'waterboard_kick_chair', 'waterboard_kick_jerrycan', 'waterboard_kick_rag'},
        {'waterboard_loop_player', 'waterboard_loop_victim', 'waterboard_loop_chair', 'waterboard_loop_jerrycan', 'waterboard_loop_rag'},
        {'waterboard_outro_player', 'waterboard_outro_victim', 'waterboard_outro_chair', 'waterboard_outro_jerrycan', 'waterboard_outro_rag'}
    },
    ['objects_3'] = {
        'prop_pliers_01'
    },
    ['animations_3'] = {
        {'pull_tooth_intro_player', 'pull_tooth_intro_victim', 'pull_tooth_intro_pliers'},
        {'pull_tooth_idle_player', 'pull_tooth_idle_victim', 'pull_tooth_idle_pliers'},
        {'pull_tooth_loop_player', 'pull_tooth_loop_victim', 'pull_tooth_loop_pliers'},
        {'pull_tooth_outro_b_player', 'pull_tooth_outro_b_victim', 'pull_tooth_outro_b_pliers'},
    }
}

Strings = {
    ['attack_left'] = 'Press ~INPUT_CONTEXT~ to attack left',
    ['attack_mid'] = 'Press ~INPUT_CONTEXT~ to attack mid',
    ['attack_right'] = 'Press ~INPUT_CONTEXT~ to attack right',
    ['switch_jerrycan'] = 'Press ~INPUT_CONTEXT~ to switch jerrycan',
    ['switch_pliers'] = 'Press ~INPUT_CONTEXT~ to switch pliers',
    ['tooth_pull'] = 'Press ~INPUT_CONTEXT~ to tooth pull',
    ['tooth_rip'] = 'Press ~INPUT_CONTEXT~ to tooth rip',
    ['blindfold'] = 'Press ~INPUT_CONTEXT~ to use headbag',
    ['cant_blindfold'] = 'You are too far',
    ['police_alert'] = 'Kidnapping alert! Check your gps.',
    ['query_room_busy'] = 'Query room is busy, wait little.',
    ['wait_nextnapping'] = 'You have to wait this long to undress again',
    ['minute'] = 'Minute.',
    ['get_job'] = 'Press ~INPUT_CONTEXT~ to get the job',
    ['finish_job'] = 'Press ~INPUT_CONTEXT~ to finish the job',
    ['get_videorecord'] = 'Press ~INPUT_CONTEXT~  to get video record',
    ['check_videorecord'] = 'Press ~INPUT_CONTEXT~  to check video record',
    ['go_laptop'] = 'Go to laptop for check video record.',
    ['mission_failed'] = 'Mission failed. The kidnapped person is dead.',
    ['mission_failed2'] = 'Mission failed. You moved away from the kidnapped person.',
    ['kidnap_blip'] = 'Someone to be Kidnapped',
    ['boss_blip'] = 'Sell Video Record',
    ['info_1'] = 'I want you to find someone. Check gps. There are a few things you should ask that man.',
    ['info_2'] = 'You can release it after you get the answers you want. You must have the answers.',
    ['info_3'] = 'Dont forget to record the video!',
    ['go_query'] = 'Go to query room.',
    ['start_query'] = 'Press ~INPUT_CONTEXT~ to start questioning',
    ['leave_vehicle'] = 'Press ~INPUT_CONTEXT~ to get out car',
    ['drop_chair'] = 'Press ~INPUT_CONTEXT~ to drop chair',
    ['pour_gasoline'] = 'Press ~INPUT_CONTEXT~ to pour gasoline',
    ['up_chair'] = 'Press ~INPUT_CONTEXT~ to up chair'
}
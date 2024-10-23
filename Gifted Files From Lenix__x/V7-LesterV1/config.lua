Config = {}
local QBCore = exports['qb-core']:GetCoreObject() -->الكور حقك

------------------------------------------------------  V7-ScriptsName  ---------------------------------------------
Config.core = 'qb-core' --اسك الكور حقك

Config.target = "qb-target" --اسم التارقت او العين حقك

------------------------------------------------------  V7-TheEndiTEM  ---------------------------------------------
Config.item_end1 = "gasmask" -- الاغراض الي يسلمها لك لستر في النهاية

Config.item_end2 = "drill" -- الاغراض الي يسلمها لك لستر في النهاية

Config.item_end3=  "thermite"  -- الاغراض الي يسلمها لك لستر في النهاية

------------------------------------------------------  V7-Notfiy  ---------------------------------------------
Config.Notfiy = {
    Activated = false, --  QBCore سيتم تعين أشعارات  False وإذا تم وضع الخيار على -- OKOK سيتم تفعيل أشعارات  true تم وضع الخيار على
    Okok_Notfiy     =  function() return exports['okokNotify']:Alert("ملاحظة", "يوجد بهذي المنطقة ادريل !", 5000, 'info') end,
    Okok_Notfiy1    =  function() return exports['okokNotify']:Alert("success", "لديك الان دريل في حقيبتك", 5000, 'success') end,
    Okok_Notfiy2    =  function() return exports['okokNotify']:Alert("خطأ", "ليس لديك الغرض او لم تكمل المهمة", 5000, 'error') end,
    Okok_Notfiy3    =  function() return exports['okokNotify']:Alert("ملاحظة", "لديك الان سكينة في حقيبتك", 5000, 'info') end,
    Okok_Notfiy4    =  function() return exports['okokNotify']:Alert("ملاحظة", "تم تحديد لك مكان في الخريطة أرجاء الذهاب الى الموقع المحدد", 5000, 'info') end,
    Okok_Notfiy5    =  function() return exports['okokNotify']:Alert("خطأ", " ليس لديك الغرض او لم تكمل المهمة", 5000, 'error') end,
    Okok_Notfiy6    =  function() return exports['okokNotify']:Alert("success","تم تحديد لك مكان في الخريطة ", 5000, 'success') end,
    Okok_Notfiy7    =  function() return exports['okokNotify']:Alert("success","تم تحديد لك مكان في الخريطة ", 5000, 'success') end,
    Okok_Notfiy8    =  function() return exports['okokNotify']:Alert("success","تم اعطائك جميع اغراض سرقة المجوهرات", 5000, 'success') end,
    Okok_Notfiy9    =  function() return exports['okokNotify']:Alert("success", "لديك الان الماسك في حقيبتك", 5000, 'success') end,
}

Config.Notfiy_QBCore_Or_More = { -- يمديك تعدل على الإشعارات او تضيف أشعارات ثانية من هينا او من الي فوق
    Okok_Notfiy     =  function() return QBCore.Functions.Notify("يوجد بهذي المنطقة ادريل !",'success', 3000)end,
    Okok_Notfiy1    =  function() return QBCore.Functions.Notify("لديك الان دريل في حقيبتك", "success", 5000)end,
    Okok_Notfiy2    =  function() return QBCore.Functions.Notify("ليس لديك الغرض او لم تكمل المهمة", "error", 5000)end,
    Okok_Notfiy3    =  function() return QBCore.Functions.Notify("لديك الان سكينة في حقيبتك", "success", 5000)end,
    Okok_Notfiy4    =  function() return QBCore.Functions.Notify("تم تحديد لك مكان في الخريطة أرجاء الذهاب الى الموقع المحدد", "success", 5000)end,
    Okok_Notfiy5    =  function() return QBCore.Functions.Notify("ليس لديك الغرض او لم تكمل المهمة", "error", 5000)end,
    Okok_Notfiy6    =  function() return QBCore.Functions.Notify("تم تحديد لك مكان في الخريطة ", "success", 5000)end,
    Okok_Notfiy7    =  function() return  QBCore.Functions.Notify("تم تحديد لك مكان في الخريطة ", "success", 5000)end,
    Okok_Notfiy8    =  function() return QBCore.Functions.Notify("تم اعطائك جميع اغراض سرقة المجوهرات", "success", 5000)end,
    Okok_Notfiy9    =  function() return QBCore.Functions.Notify("لديك الان الماسك في حقيبتك", "success", 5000)end,
}

------------------------------------------------------  V7-PEDS  ---------------------------------------------

Config['Attackers'] = {
    ['AttackerPeds'] = {
        { coords = vector3(2957.01, 2780.79, 40.71), heading = 211.09, model = 'csb_vincent'}, --لاتلعب فيهم
        { coords = vector3(3016.29, 2764.32, 54.0), heading = 75.09, model = 'csb_vincent'}, --لاتلعب فيهم
        { coords = vector3(2910.11, 2819.18, 53.95), heading = 209.4, model = 'mp_m_bogdangoon'}, --لاتلعب فيهم
        { coords = vector3(2951.06, 2756.33, 43.44), heading = 238.35, model = 'mp_m_bogdangoon'}, --لاتلعب فيهم
        { coords = vector3(2957.64, 2748.42, 43.49), heading = 263.23, model = 'mp_s_m_armoured_01'}, --لاتلعب فيهم
        { coords = vector3(2953.48, 2735.11, 44.42), heading = 358.84, model = 'mp_s_m_armoured_01'}, --لاتلعب فيهم
        { coords = vector3(2950.94, 2673.98, 76.74), heading = 358.41, model = 's_m_m_chemsec_01'}, --لاتلعب فيهم
        { coords = vector3(2904.26, 2734.02, 73.28), heading = 311.43, model = 's_m_m_chemsec_01'}, --لاتلعب فيهم
    },
}
--------------------------------------------------------------------------------------------------------------


--dev by yazeed#5874

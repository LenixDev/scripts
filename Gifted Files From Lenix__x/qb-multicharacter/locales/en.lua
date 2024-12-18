local Translations = {
    ui = {
        -- Main
        male = "ذكر",
        female = "أنثى",
        error_title = "خطأ!",
        characters_header = "اختيار الشخصية",
        characters_count = "شخصيات",
      
        -- Setup Characters
        default_image = 'image/action_dot.gif',
        create_new_character = "إنشاء شخصية جديدة",
        default_right_image = 'image/action_key.png',

        -- Create character
        create_header = "إنشاء الهوية",
        header_detail = "أدخل تفاصيل شخصيتك",
        gender_marker = "علامة الجنس",
        
        missing_information = "لقد كتبت معلومات ناقصة.",
        badword = "لقد استخدمت كلمة غير لائقة، حاول مرة أخرى!",
       
        create_firstname = "الاسم",
        create_lastname = "اللقب",
        create_nationality = "الجنسية",
        create_birthday = "تاريخ الميلاد",

        -- Buttons
        select = "تحديد",
        create = "إبدء قصتك",
        spawn = "أكمل قصتك",
        delete = "حذف",
        cancel = "إلغاء",
        confirm = "تأكيد",
        close = "إغلاق",
    },

    notifications = {
        ["char_deleted"] = "تم حذف الشخصية!",
        ["deleted_other_char"] = "لقد قمت بحذف الشخصية بنجاح ذات هوية المواطن %{citizenid}.",
        ["forgot_citizenid"] = "نسيت إدخال هوية المواطن!",
    },

    commands = {
        -- /deletechar
        ["deletechar_description"] = "حذف شخصية لاعب آخر",
        ["citizenid"] = "هوية المواطن",
        ["citizenid_help"] = "هوية المواطن للشخصية التي تريد حذفها",

        -- Loaded
       
        -- /logout
        ["logout_description"] = "تسجيل الخروج من الشخصية (للإداريين فقط)",

        -- /closeNUI
        ["closeNUI_description"] = "إغلاق نافذة NUI المتعددة"
    },

    misc = {
        ["succes_loaded"] = '^2[qb-core]^7 %{value} تم تحميله بنجاح!',
        ["droppedplayer"] = "لقد تم قطع الاتصال مع QBCore"
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
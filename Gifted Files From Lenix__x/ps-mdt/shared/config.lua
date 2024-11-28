Config = Config or {}

Config.UsingPsHousing = false
Config.UsingDefaultQBApartments = true
Config.OnlyShowOnDuty = false

-- RECOMMENDED Fivemerr Images. DOES NOT EXPIRE. 
-- YOU NEED TO SET THIS UP FOLLOW INSTRUCTIONS BELOW.
-- Documents: https://docs.fivemerr.com/integrations/mdt-scripts/ps-mdt
Config.FivemerrMugShot = true

-- Discord webhook for images. NOT RECOMMENDED, IMAGES EXPIRE.
Config.MugShotWebhook = false
Config.UseCQCMugshot = true

-- Front, Back Side. Use 4 for both sides, we recommend leaving at 1 for default.
Config.MugPhotos = 1

-- If set to true = Fine gets automatically removed from bank automatically charging the player.
-- If set to false = The fine gets sent as an Invoice to their phone and it us to the player to pay for it, can remain unpaid and ignored.
Config.BillVariation = false

-- If set to false (default) = The fine amount is just being removed from the player's bank account
-- If set to true = The fine amount is beeing added to the society account after being removed from the player's bank account
Config.QBBankingUse = false

-- Set up your inventory to automatically retrieve images when a weapon is registered at a weapon shop or self-registered.
-- If you're utilizing lj-inventory's latest version from GitHub, no further modifications are necessary. 
-- However, if you're using a different inventory system, please refer to the "Inventory Edit | Automatic Add Weapons with images" section in ps-mdt's README.
Config.InventoryForWeaponsImages = "qb-inventory"

-- Only compatible with ox_inventory
Config.RegisterWeaponsAutomatically = true

-- Set to true to register all weapons that are added via AddItem in ox_inventory
Config.RegisterCreatedWeapons = true

-- "LegacyFuel", "lj-fuel", "ps-fuel"
Config.Fuel = "cdn-fuel"

-- Google Docs Link
Config.sopLink = {
    ['police'] = 'https://docs.google.com/spreadsheets/d/1wpYoVQhK6K0lvhnBNZTgBGMHOD_l1KmO9GIAxyG1MXw/edit?usp=sharing',
    ['ambulance'] = '',
    ['bcso'] = '',
    ['doj'] = '',
    ['sast'] = '',
    ['sasp'] = '',
    ['doc'] = '',
    ['lssd'] = '',
    ['sapr'] = '',
}

-- Google Docs Link
Config.RosterLink = {
    ['police'] = 'https://docs.google.com/spreadsheets/d/1wpYoVQhK6K0lvhnBNZTgBGMHOD_l1KmO9GIAxyG1MXw/edit?usp=sharing',
    ['ambulance'] = '',
    ['bcso'] = '',
    ['doj'] = '',
    ['sast'] = '',
    ['sasp'] = '',
    ['doc'] = '',
    ['lssd'] = '',
    ['sapr'] = '',	
}

Config.PoliceJobs = {
    ['police'] = true,
    ['lspd'] = true,
    ['bcso'] = true,
    ['sast'] = true,
    ['sasp'] = true,
    ['doc'] = true,
    ['lssd'] = true,
    ['sapr'] = true,
    ['pa'] = true
}

Config.AmbulanceJobs = {
    ['ambulance'] = true,
    ['doctor'] = true
}

Config.DojJobs = {
    ['lawyer'] = true,
    ['judge'] = true
}

-- This is a workaround solution because the qb-menu present in qb-policejob fills in an impound location and sends it to the event. 
-- If the impound locations are modified in qb-policejob, the changes must also be implemented here to ensure consistency.

Config.ImpoundLocations = {
    [1] = vector4(-1129.93, -836.93, 13.62, 126.52),
    [2] = vector4(-482.93, 6024.87, 30.98, 47.18),
    [3] = vector4(1859.52, 3704.47, 33.19, 295.65),
}

-- Support for Wraith ARS 2X. 

Config.UseWolfknightRadar = true
Config.WolfknightNotifyTime = 5000 -- How long the notification displays for in milliseconds (30000 = 30 seconds)
Config.PlateScanForDriversLicense = true -- If true, plate scanner will check if the owner of the scanned vehicle has a drivers license

-- IMPORTANT: To avoid making excessive database queries, modify this config to true 'CONFIG.use_sonorancad = true' setting in the configuration file located at 'wk_wars2x/config.lua'. 
-- Enabling this setting will limit plate checks to only those vehicles that have been used by a player.

Config.LogPerms = {
	['ambulance'] = {
		[4] = true,
	},
	['police'] = {
		[4] = true,
	},
    ['bcso'] = {
		[4] = true,
	},
    ['sast'] = {
		[4] = true,
	},
    ['sasp'] = {
		[4] = true,
	},
    ['sapr'] = {
		[4] = true,
	},
    ['doc'] = {
		[4] = true,
	},
    ['lssd'] = {
		[4] = true,
	},
}

Config.RemoveIncidentPerms = {
	['ambulance'] = {
		[4] = true,
	},
	['police'] = {
		[4] = true,
	},
    ['bcso'] = {
		[4] = true,
	},
    ['sast'] = {
		[4] = true,
	},
    ['sasp'] = {
		[4] = true,
	},
    ['sapr'] = {
		[4] = true,
	},
    ['doc'] = {
		[4] = true,
	},
    ['lssd'] = {
		[4] = true,
	},
}

Config.RemoveReportPerms = {
	['ambulance'] = {
		[4] = true,
	},
	['police'] = {
		[4] = true,
	},
    ['bcso'] = {
		[4] = true,
	},
    ['sast'] = {
		[4] = true,
	},
    ['sasp'] = {
		[4] = true,
	},
    ['sapr'] = {
		[4] = true,
	},
    ['doc'] = {
		[4] = true,
	},
    ['lssd'] = {
		[4] = true,
	},
}

Config.RemoveWeaponsPerms = {
	['ambulance'] = {
		[4] = true,
	},
	['police'] = {
		[4] = true,
	},
    ['bcso'] = {
		[4] = true,
	},
    ['sast'] = {
		[4] = true,
	},
    ['sasp'] = {
		[4] = true,
	},
    ['sapr'] = {
		[4] = true,
	},
    ['doc'] = {
		[4] = true,
	},
    ['lssd'] = {
		[4] = true,
	},
}

Config.PenalCodeTitles = {
    [1] = 'OFFENSES AGAINST PERSONS',
    [2] = 'OFFENSES INVOLVING THEFT',
    [3] = 'OFFENSES INVOLVING FRAUD',
    [4] = 'OFFENSES INVOLVING DAMAGE TO PROPERTY',
    [5] = 'OFFENSES AGAINST PUBLIC ADMINISTRATION',
    [6] = 'OFFENSES AGAINST PUBLIC ORDER',
    [7] = 'OFFENSES AGAINST HEALTH AND MORALS',
    [8] = 'OFFENSES AGAINST PUBLIC SAFETY',
    [9] = 'OFFENSES INVOLVING THE OPERATION OF A VEHICLE',
    [10] = 'OFFENSES INVOLVING THE WELL-BEING OF WILDLIFE',
}

Config.PenalCode = {
    [1] = {
        [1] = {title = 'عصيان موظف حكومي', class = 'مخالفة', id = 'المادة 6001', months = 0, fine = 750, color = 'green', description = 'التجاهل المتعمد لأمر قانوني'},
        [2] = {title = 'السلوك غير المنضبط', class = 'مخالفة', id = 'المادة 6002', months = 0, fine = 250, color = 'green', description = "التصرف بطريقة تخلق حالة خطرة أو مهينة جسديًا من خلال أي فعل لا يخدم أي غرض مشروع للممثل" },
        [3] = {title = 'زعزعة السلام', class = 'مخالفة', id = 'المادة 6003', months = 0, fine = 350, color = 'green', description = "التصرف بطريقة تثير القلاقل والإخلال بالنظام العام"},
        [4] = {title = "الإبلاغ الكاذب", class = 'جنحة', id = 'المادة 6004', months = 10, fine = 750, color = 'green', description = 'اي عن جريمة لم تتحدث'},
        [5] = {title = 'تحرش', class = 'جنحة', id = 'المادة 6005', months = 10, fine = 500, color = 'orange', description = 'الإزعاج المتكرر أو الاعتداءات اللفظية من شخص آخر'},
        [6] = {title = "جنحة عرقلة سير العدالة", class = 'جنحة', id = 'المادة 6006', months = 10, fine = 500, color = 'green', description = "التصرف بطريقة تعيق سير العدالة أو التحقيقات القانونية"},
        [7] = {title = "جناية عرقلة سير العدالة", class = 'جناية', id = 'المادة 6007', months = 15, fine = 900, color = 'green', description = "التصرف بطريقة تعيق سير العدالة أو التحقيقات القانونية أثناء استخدام العنف"},
        [8] = {title = "التحريض على الشغب", class = 'جناية', id = 'المادة 6008', months = 25, fine = 1000, color = 'orange', description = 'التسبب في اضطرابات مدنية بطريقة تحريض مجموعة على إلحاق الضرر بالأشخاص أو الممتلكات'},
        [9] = {title = "التسكع على الممتلكات الحكومية", class = 'مخالفة', id = 'المادة 6009', months = 0, fine = 500, color = 'green', description = "عندما يتواجد شخص ما في الحكومة لفترة طويلة من الزمن"},
        [10] = {title = "العبث", class = 'جنحة', id = 'المادة 6010', months = 10, fine = 500, color = 'green', description = "عندما يتدخل شخص ما عن عمد وعن علم وبشكل غير مباشر في النقاط الرئيسية لتحقيق قانوني"},
        [11] = {title = "العبث بالمركبات", class = 'جنحة', id = 'المادة 6011', months = 15, fine = 750, color = 'green', description = "التدخل المتعمد والمعرفي في الوظيفة العادية للمركبة"},
        [12] = {title = "التلاعب بالأدلة", class = 'جناية', id = 'المادة 6012', months = 20, fine = 1000, color = 'green', description = "التدخل المتعمد والمتعمد في أدلة التحقيق القانوني"},
        [13] = {title = "التلاعب بالشهود", class = 'جناية', id = 'المادة 6013', months = 0, fine = 0, color = 'green', description = "التدريب أو الإكراه المتعمد والمتعمد للشاهد في تحقيق قانوني"},
        [14] = {title = "الفشل في تقديم الهوية", class = 'جنحة', id = 'المادة 6014', months = 15, fine = 1500, color = 'green', description = "اي عدم تقديم الهوية عندما يكون ذلك مطلوبًا قانونًا"},
        [15] = {title = "اليقظة", class = 'جناية', id = 'المادة 6015', months = 30, fine = 1500, color = 'orange', description = "اي الانخراط في إنفاذ القانون مع السلطة القانونية للقيام بذلك"},
        [16] = {title = 'التجمع غير القانوني', class = 'جنحة', id = 'المادة 6016', months = 10, fine = 750, color = 'orange', description = 'عندما تتجمع مجموعة كبيرة في مكان يتطلب الحصول على موافقة مسبقة لذلك'},
        [17] = {title = 'فساد حكومي', class = 'جناية', id = 'المادة 6017', months = 0, fine = 0, color = 'red', description = "اي استخدام المنصب السياسي والسلطة لتحقيق مكاسب شخصية"},
        [18] = {title = "المطاردة", class = 'جناية', id = 'المادة 6018', months = 40, fine = 1500, color = 'orange', description = 'عندما يقوم شخص بمراقبة شخص آخر دون موافقته'},
        [19] = {title = "المعونة والتحريض", class = 'جنحة', id = 'المادة 6019', months = 15, fine = 450, color = 'orange', description = "لمساعدة شخص ما على ارتكاب جريمة أو تشجيعه على ارتكاب جريمة"},
        [20] = {title = "إيواء الهارب", class = 'جنحة', id = 'المادة 6020', months = 10, fine = 1000, color = 'green', description = 'عندما يقوم شخص ما بإخفاء شخص آخر مطلوب من قبل السلطات عن طيب خاطر'},
    },    
    [2] = {
        [1] = {title =  'القيادة في حالة سكر', class = 'جنحة', id = 'المادة 9001', months = 5, fine = 300, color = 'green', description = "قيادة السيارة أثناء تعاطي الكحول"},
        [2] = {title =  "التهرب", class = 'جنحة', id = 'المادة 9002', months = 5, fine = 400, color = 'green', description = "الاختباء أو الهروب من الاحتجاز القانوني"},
        [3] = {title =  "الهروب المتهور", class = 'جناية', id = 'المادة 9003', months = 10, fine = 800, color = 'orange', description = 'الاستهتار بالسلامة والاختباء أو الهروب من الاحتجاز القانوني أثناء'},
        [4] = {title =  "عدم الاستسلام لمركبة الطوارئ", class = 'مخالفة', id = 'المادة 9004', months = 0, fine = 600, color = 'green', description = 'عدم إفساح المجال لمركبات الطوارئ'},
        [5] = {title =  "عدم الالتزام بجهاز التحكم في حركة المرور", class = 'مخالفة', id = 'المادة 9005', months = 0, fine = 150, color = 'green', description = 'عدم اتباع وسائل السلامة على الطريق'},
        [6] = {title =  "مركبة غير وظيفية", class = 'مخالفة', id = 'المادة 9006', months = 0, fine = 75, color = 'green', description = "امتلاك مركبة لم تعد صالحة للاستخدام على الطريق"},
        [7] = {title =  "القيادة المتهورة", class = 'مخالفة', id = 'المادة 9007', months = 0, fine = 300, color = 'green', description = "القيادة بطريقة تتجاهل السلامة دون علم"},
        [8] = {title =  'القيادة المتهورة', class = 'جنحة', id = 'المادة 9008', months = 10, fine = 750, color = 'orange', description = "القيادة بطريقة تتجاهل السلامة عمدًا"},
        [9] = {title =  "السرعة من الدرجة الثالثة", class = 'مخالفة', id = 'المادة 9009', months = 0, fine = 225, color = 'green', description = 'السرعة 15 فوق الحد الأقصى'},
        [10] = {title = "السرعة من الدرجة الثانية", class = 'مخالفة', id = 'المادة 9010', months = 0, fine = 450, color = 'green', description = "السرعة 35 فوق الحد الأقصى"},
        [11] = {title = "السرعة من الدرجة الأولى", class = 'مخالفة', id = 'المادة 9011', months = 0, fine = 750, color = 'green', description = "السرعة 50 فوق الحد الأقصى"},
        [12] = {title = "التشغيل غير المرخص للمركبة", class = 'مخالفة', id = 'المادة 9012', months = 0, fine = 500, color = 'green', description = "تشغيل مركبة بدون ترخيص مناسب"},
        [13] = {title = "الانعطاف غير القانوني", class = 'مخالفة', id = 'المادة 9013', months = 0, fine = 75, color = 'green', description = "الدوران على شكل حرف U في الأماكن المحظورة"},
        [14] = {title = "المرور غير القانوني", class = 'مخالفة', id = 'المادة 9014', months = 0, fine = 300, color = 'green', description = "تجاوز المركبات الأخرى بطريقة محظورة"},
        [15] = {title = "الفشل في الحفاظ على المسار" , class = 'مخالفة', id = 'المادة 9015', months = 0, fine = 300, color = 'green', description = 'عدم البقاء في المسار الصحيح مع السيارة'},
        [16] = {title = "منعطف غير قانوني", class = 'مخالفة', id = 'المادة 9016', months = 0, fine = 150, color = 'green', description = "أداء الدور حيث يحظر"},
        [17] = {title = "الفشل في التوقف", class = 'مخالفة', id = 'المادة 9017', months = 0, fine = 600, color = 'green', description = "عدم التوقف للتوقف القانوني أو جهاز المرور"},
        [18] = {title = "وقوف السيارات غير المصرح به", class = 'مخالفة', id = 'المادة 9018', months = 0, fine = 300, color = 'green', description = 'إيقاف السيارة في مكان يتطلب موافقة أي شخص'},
        [19] = {title = "اضرب واهرب", class = 'جنحة', id = 'المادة 9019', months = 10, fine = 500, color = 'green', description = 'صدم شخص آخر أو مركبة أخرى والفرار من الموقع'},
        [20] = {title = "القيادة بدون مصابيح أمامية أو إشارات", class = 'مخالفة', id = 'المادة 9020', months = 0, fine = 300, color = 'green', description = "تشغيل مركبة بدون أضواء وظيفية"},
        [21] = {title = 'سباق الشوارع', class = 'جناية', id = 'المادة 9021', months = 15, fine = 1500, color = 'green', description = "تشغيل المركبات الآلية في المسابقة"},
        [22] = {title = "القيادة بدون ترخيص مناسب", class = 'جناية', id = 'المادة 9022', months = 20, fine = 1500, color = 'orange', description = "عدم الحصول على ترخيص ساري المفعول عند تشغيل الطائرة"},
        [23] = {title = "الاستخدام غير القانوني للمركبة الآلية", class = 'جنحة', id = 'المادة 9023', months = 10, fine = 750, color = 'green', description = "استخدام السيارة بدون سبب مشروع"},
    },       
    [3] = {
        [1] = {title = 'اشتباك بالايدي', class = 'جنحة', id = 'المادة 1001', months = 7, fine = 500, color = 'green', description = 'عندما يتسبب شخص عن قصد في الاشتباك الجسدي مع شخص آخر (بدون سلاح)'},
        [2] = {title = 'تعدي', class = 'جنحة', id = 'المادة 1002', months = 15, fine = 850, color = 'orange', description = 'إذا تسبب شخص عن قصد في إصابة شخص آخر (بدون سلاح)'},
        [3] = {title = 'اعتداء غير مقصود', class = 'جناية', id = 'المادة 1003', months = 20, fine = 1250, color = 'orange', description = 'عندما يتسبب شخص عن غير قصد وبشكل متهور في إصابة جسدية لآخر نتيجة المواجهة ويتسبب في إصابة جسدية'},
        [4] = {title = 'الاعتداء بالسلاح', class = 'جناية', id = 'المادة 1004', months = 30, fine = 3750, color = 'red', description = 'عندما يتسبب شخص عن قصد أو عن غير قصد في إصابة جسدية لشخص آخر ويتسبب في إصابة جسدية خطيرة أو يستخدم أو يعرض سلاحًا مميتًا'},
        [5] = {title = 'القتل غير العمد', class = 'جناية', id = 'المادة 1005', months = 60, fine = 7500, color = 'red', description = 'عندما يتسبب شخص عن غير قصد أو باستهتار في وفاة شخص آخر'},
        [6] = {title = 'قتل بالمركبة', class = 'جناية', id = 'المادة 1006', months = 75, fine = 7500, color = 'red', description = 'عندما يتسبب شخص عن غير قصد أو باستهتار في وفاة شخص آخر بمركبته'},
        [7] = {title = 'محاولة قتل مدني', class = 'جناية', id = 'المادة 1007', months = 50, fine = 7500, color = 'red', description = 'عندما يقوم مواطن بمهاجمة مدني عمدًا بقصد القتل'},
        [8] = {title = 'جريمة قتل من الدرجة الثانية', class = 'جناية', id = 'المادة 1008', months = 100, fine = 15000, color = 'red', description = 'القتل غير المتعمد أو المخطط له. حالة لا ينوي فيها القاتل إلا إلحاق أذى جسدي خطير'},
        --[9] = {title = 'ملحق لجريمة قتل من الدرجة الثانية', class = 'جناية', id = 'المادة 1009', months = 50, fine = 5000, color = 'red', description = 'التواجد أو المشاركة في فعل مسؤولية الحكومية'},
        [9] = {title = 'جريمة قتل من الدرجة الأولى', class = 'جناية', id = 'المادة 1009', months = 30, fine = 2500, color = 'red', description = 'أي قتل يكون عمداً مع سبق الإصرار والترصد.'},
        [10] = {title = 'ملحق لجريمة قتل من الدرجة الأولى', class = 'جناية', id = 'المادة 1010', months = 0, fine = 0, color = 'red', description = 'اي المشاركة  في اي عمل اجرامي مع اسباقية الاصرار'},
        [11] = {title = 'قتل احد الموظفين الحكوميين', class = 'جناية', id = 'المادة 1011', months = 0, fine = 0, color = 'red', description = 'أي قتل عمد يقع على موظف حكومي (شرطة ,وزارة الصحة,وزارة العدل....الخ)'},
        [12] = {title = 'الاعتداء على احد الموظفين الحكوميين', class = 'جناية', id = 'المادة 1012', months = 65, fine = 10000, color = 'red', description = 'أي اعتداءات تتم على موظف حكومي بقصد التسبب في القتل'},
        --[13] = {title = 'قتل احد الموظفين الحكوميين' , class = 'جناية', id = 'المادة 1013', months = 0, fine = 0, color = 'red', description = 'اي المشاركة  في اي عمل اجرامي مع اسباقية الاصرار'},
        [13] = {title = 'الحبس غير القانوني', class = 'جنحة', id = 'المادة 1014', months = 10, fine = 600, color = 'green', description = 'اي أخذ شخص آخر ضد إرادته واحتجازه لفترة طويلة من الزمن'},
        [14] = {title = 'خطف', class = 'جناية', id = 'المادة 1015', months = 15, fine = 900, color = 'orange', description = 'اي أخذ شخص آخر ضد إرادته لفترة قصيرة من الزمن'},
        --17] = {title = 'ملحق للاختطاف', class = 'جناية', id = 'المادة 1017', months = 7, fine = 450, color = 'orange', description = 'اي المشاركة  في اي عمل اجرامي مع اسباقية الاصرار'},
        [15] = {title = 'محاولة اختطاف', class = 'جناية', id = 'المادة 1016', months = 10, fine = 450, color = 'orange', description = 'اي محاولة أخذ شخص ما ضد إرادته'},
        --[19] = {title = 'Hostage Taking', class = 'جناية', id = 'المادة 1019', months = 20, fine = 1200, color = 'orange', description = 'The act of taking another against their will for personal gain'},
        --[20] = {title = 'Accessory to Hostage Taking', class = 'جناية', id = 'المادة 1020', months = 10, fine = 600, color = 'orange', description = 'اي المشاركة  في اي عمل اجرامي مع اسباقية الاصرار'},
        [16] = {title = 'الحبس غير القانوني لموظف حكومي.', class = 'جناية', id = 'المادة 1017', months = 25, fine = 4000, color = 'orange', description = 'اي أخذ موظف حكومي ضد إرادته لفترة طويلة من الزمن'},
        [17] = {title = 'التهديدات الجنائية', class = 'جنحة', id = 'المادة 1018', months = 5, fine = 500, color = 'orange', description = 'اي بيان نية ارتكاب جريمة ضد شخص آخر'},
        [18] = {title = 'تهور خطر', class = 'جنحة', id = 'المادة 1019', months = 10, fine = 1000, color = 'orange', description = 'اي تجاهل سلامة شخص آخر قد يعرضه لخطر الموت أو الإصابة الجسدية'},
        [19] = {title = 'إطلاق النار المتعلق بالعصابة', class = 'جناية', id = 'المادة 1020', months = 30, fine = 2500, color = 'red', description = 'اي الذي يتم فيه إطلاق السلاح الناري فيما يتعلق بنشاط العصابة'},
        --[25] = {title = 'Cannibalism', class = 'جناية', id = 'المادة 1025', months = 0, fine = 0, color = 'red', description = 'The act in which a persons consumes the flesh of another willingly'},
        [20] = {title = 'تعذيب', class = 'جناية', id = 'المادة 1021', months = 40, fine = 4500, color = 'red', description = 'اي إلحاق الأذى بالآخرين لانتزاع معلومات أو للتمتع الذاتي'},
    },
    [4] = {
        [1] = {title = 'السرقة الصغرى', class = 'مخالفة', id = 'المادة 2001', months = 0, fine = 250, color = 'green', description = 'سرقة الممتلكات بمبلغ أقل من 50 دولارا'},
        [2] = {title = 'السرقة الكبرى', class = 'جنحة', id = 'المادة 2002', months = 10, fine = 600, color = 'green', description = 'سرقة الممتلكات التي تزيد قيمتها عن 700 دولارا'},
        [3] = {title = 'سرقة مركبة فئة أ', class = 'جناية', id = 'المادة 2003', months = 15, fine = 900, color = 'green', description = 'اي سرقة مركبة مملوكة للغير دون إذن'},
        [4] = {title = 'سرقة مركبة فئة ب', class = 'جناية', id = 'المادة 2004', months = 35, fine = 3500, color = 'green', description = 'اي سرقة مركبة مملوكة لشخص آخر دون إذن وهو مسلح'},
        [5] = {title = 'سرقة مركبة', class = 'جناية', id = 'المادة 2005', months = 30, fine = 2000, color = 'orange', description = 'قيام شخص بأخذ مركبة بالقوة من ركابها'},
        [6] = {title = 'السطو', class = 'جنحة', id = 'المادة 2006', months = 10, fine = 500, color = 'green', description = 'اي الدخول إلى مبنى بطريقة غير مشروعة بقصد ارتكاب جريمة, وخاصة السرقة.'},
        [7] = {title = 'سرقة ممتلكات خاصة', class = 'جناية', id = 'المادة 2007', months = 25, fine = 2000, color = 'green', description = 'اي أخذ الممتلكات بشكل غير قانوني من شخص أو مكان بالقوة أو التهديد باستخدام القوة'},
        [8] = {title = 'ملحق للسرقة', class = 'جناية', id = 'المادة 2008', months = 12, fine = 1000, color = 'green', description = 'اي المشاركة  في اي عمل اجرامي مع اسباقية الاصرار'},
        [9] = {title = 'محاولة سرقة', class = 'جناية', id = 'المادة 2009', months = 20, fine = 1000, color = 'green', description = 'اي محاولة الاستيلاء بشكل غير قانوني على شخص أو مكان بالقوة أو التهديد باستخدام القوة'},
        [10] = {title = 'سطو مسلح', class = 'جناية', id = 'المادة 2010', months = 30, fine = 3000, color = 'orange', description = 'اي الاستيلاء على الممتلكات بشكل غير قانوني من شخص أو مكان بالقوة أو التهديد باستخدام القوة أثناء السلاح'},
        [11] = {title = 'ملحق للسطو المسلح', class = 'جناية', id = 'المادة 2011', months = 15, fine = 1500, color = 'orange', description = 'اي المشاركة  في اي عمل اجرامي مع اسباقية الاصرار'},
        [12] = {title = 'محاولة سطو مسلح', class = 'جناية', id = 'المادة 2012', months = 25, fine = 1500, color = 'orange', description = 'اي محاولة الاستيلاء بشكل غير قانوني على شخص أو مكان بالقوة أو التهديد باستخدام القوة أثناء السلاح'},
        [13] = {title = 'السرقة الكبرى', class = 'جناية', id = 'المادة 2013', months = 45, fine = 7500, color = 'orange', description = 'سرقة الممتلكات الشخصية التي تزيد قيمتها عن المبلغ المحدد قانونا'},
        [14] = {title = 'حيازة العملة غير القانونية', class = 'جنحة', id = 'المادة 2014', months = 10, fine = 750, color = 'green', description = 'حيازة عملة مسروقة'},
        [15] = {title = 'حيازة المواد الصادرة عن الحكومة', class = 'جنحة', id = 'المادة 2015', months = 15, fine = 1000, color = 'green', description = 'حيازة العناصر التي لا يمكن الحصول عليها إلا من قبل موظفي الحكومة'},
        [16] = {title = 'حيازة الأشياء المستخدمة في ارتكاب الجريمة', class = 'جنحة', id = 'المادة 2016', months = 10, fine = 500, color = 'green', description = 'حيازة أشياء سبق استخدامها في ارتكاب الجرائم'},
        [17] = {title = 'بيع الأشياء المستخدمة في ارتكاب الجريمة', class = 'جناية', id = 'المادة 2017', months = 15, fine = 1000, color = 'orange', description = 'اي بيع أشياء سبق استخدامها في ارتكاب الجرائم'},
        [18] = {title = 'عملية سرقة طائرة', class = 'جناية', id = 'المادة 2018', months = 20, fine = 1000, color = 'green', description = 'عملية سرقة طائرة'},
    },
    [5] = {
        [1] =  {title = "جنحة حيازة الماريجوانا", class = 'جنحة', id = 'المادة 7001', months = 5, fine = 250, color = 'green', description = "حيازة كمية من مادة الماريجوانا بمبلغ أقل من الـ 4 أقراص"},
        [2] =  {title = "جريمة تصنيع الماريجوانا", class = 'جناية', id = 'المادة 7002', months = 15, fine = 1000, color = 'red', description = "بحوزة كمية من مادة الماريجوانا ناتجة عن التصنيع"},
        [3] =  {title = "زراعة الماريجوانا أ", class = 'جنحة', id = 'المادة 7003', months = 10, fine = 750, color = 'green', description = 'حيازة 4 نباتات ماريجوانا أو أقل'},
        [4] =  {title = "زراعة الماريجوانا ب", class = 'جناية', id = 'المادة 7004', months = 30, fine = 1500, color = 'orange', description = 'حيازة 5 نباتات ماريجوانا أو أكثر'},
        [5] =  {title = "حيازة الماريجوانا بقصد توزيعها", class = 'جناية', id = 'المادة 7005', months = 30, fine = 3000, color = 'orange', description = '"بحوزة كمية من مادة الماريجوانا بغرض التوزيع'},
        [6] =  {title = "جنحة حيازة الكوكايين", class = 'جنحة', id = 'المادة 7006', months = 7, fine = 500, color = 'green', description = 'حيازة الكوكايين بكمية صغيرة عادة للاستخدام الشخصي'},
        [7] =  {title = "جريمة تصنيع وحيازة الكوكايين", class = 'جناية', id = 'المادة 7007', months = 25, fine = 1500, color = 'red', description = "بحوزة كمية من مادة الكوكايين الداخلة في تصنيعها"},
        [8] =  {title = "حيازة الكوكايين بقصد توزيعه", class = 'جناية', id = 'المادة 7008', months = 35, fine = 4500, color = 'orange', description = '"حيازة كمية من مادة الكوكايين بغرض التوزيع'},
        [9] =  {title = "جنحة حيازة مادة الميثامفيتامين", class = 'جنحة', id = 'المادة 7009', months = 7, fine = 500, color = 'green', description = 'حيازة الميثامفيتامين بكمية صغيرة عادة للاستخدام الشخصي'},
        [10] = {title = "جريمة تصنيع وحيازة مادة الميثامفيتامين", class = 'جناية', id = 'المادة 7010', months = 25, fine = 1500, color = 'red', description = 'بحوزة كمية من مادة الميثامفيتامين ناتجة عن التصنيع'},
        [11] = {title = "حيازة مادة الميثامفيتامين بقصد توزيعها", class = 'جناية', id = 'المادة 7011', months = 35, fine = 4500, color = 'orange', description = '"بحوزة كمية من مادة الميثامفيتامين بغرض التوزيع'},
        [12] = {title = "جنحة حيازة الأوكسي/الفيكودين", class = 'جنحة', id = 'المادة 7012', months = 7, fine = 500, color = 'green', description = 'حيازة مادة الأوكسي/الفيكودين بكمية قليلة عادة للاستخدام الشخصي دون وصفة طبية'},
        [13] = {title = "جريمة تصنيع حيازة الأوكسي/الفيكودين", class = 'جناية', id = 'المادة 7013', months = 25, fine = 1500, color = 'red', description = '"حيازة كمية من مادة الأوكسي/الفيكودين داخلة في التصنيع'},
        [14] = {title = "جناية حيازة الأوكسي/الفيكودين بقصد التوزيع", class = 'جناية', id = 'المادة 7014', months = 35, fine = 4500, color = 'orange', description = '"حيازة كمية من مادة الأوكسي/الفيكودين بغرض التوزيع'},
        [15] = {title = "جنحة حيازة عقار النشوة", class = 'جنحة', id = 'المادة 7015', months = 7, fine = 500, color = 'green', description = 'حيازة النشوة بكمية قليلة عادة للاستخدام الشخصي'},
        [16] = {title = "جناية تصنيع حيازة عقار النشوة", class = 'جناية', id = 'المادة 7016', months = 25, fine = 1500, color = 'red', description = "حيازة كمية من النشوة التي هي من التصنيع"},
        [17] = {title = "حيازة النشوة بقصد توزيعها", class = 'جناية', id = 'المادة 7017', months = 35, fine = 4500, color = 'orange', description = 'The possession of a quantity of ecstasy for distribution'},
        [18] = {title = "جنحة حيازة الأفيون", class = 'جنحة', id = 'المادة 7018', months = 7, fine = 500, color = 'green', description = 'حيازة الأفيون بكمية صغيرة عادة للاستخدام الشخصي'},
        [19] = {title = "جريمة تصنيع حيازة الأفيون" , class = 'جناية', id = 'المادة 7019', months = 25, fine = 1500, color = 'red', description = "حيازة كمية من مادة الأفيون ناتجة عن التصنيع"},
        [20] = {title = "حيازة الأفيون بقصد توزيعه", class = 'جناية', id = 'المادة 7020', months = 35, fine = 4500, color = 'orange', description = '"حيازة كمية من مادة الأفيون بغرض التوزيع'},
        [21] = {title = "جنحة حيازة أديرال", class = 'جنحة', id = 'المادة 7021', months = 7, fine = 500, color = 'green', description = 'حيازة الأديرال بكمية صغيرة عادة للاستخدام الشخصي دون وصفة طبية'},
        [22] = {title = "جريمة تصنيع حيازة أديرال", class = 'جناية', id = 'المادة 7022', months = 25, fine = 1500, color = 'red', description = "حيازة كمية من مادة الأديرال ناتجة عن التصنيع"},
        [23] = {title = "حيازة عقار أديرال بقصد التوزيع", class = 'جناية', id = 'المادة 7023', months = 35, fine = 4500, color = 'orange', description = "حيازة كمية من مادة الأديرال للتوزيع"},
        [24] = {title = "جنحة حيازة زاناكس", class = 'جنحة', id = 'المادة 7024', months = 7, fine = 500, color = 'green', description = 'حيازة عقار الزاناكس بكمية صغيرة عادة للاستخدام الشخصي دون وصفة طبية'},
        [25] = {title = "جريمة تصنيع حيازة عقار الزاناكس", class = 'جناية', id = 'المادة 7025', months = 25, fine = 1500, color = 'red', description = "بحوزة كمية من مادة الزاناكس ناتجة عن التصنيع"},
        [26] = {title = "حيازة عقار زاناكس بقصد التوزيع", class = 'جناية', id = 'المادة 7026', months = 35, fine = 4500, color = 'orange', description = "حيازة كمية من مادة الزاناكس للتوزيع"},
        [27] = {title = "جنحة حيازة الشرومز", class = 'جنحة', id = 'المادة 7027', months = 7, fine = 500, color = 'green', description = 'حيازة الفطر بكمية صغيرة عادة للاستخدام الشخصي'},
        [28] = {title = "جريمة تصنيع حيازة الشمندر" , class = 'جناية', id = 'المادة 7028', months = 25, fine = 1500, color = 'red', description = "حيازة كمية من الشروم من التصنيع"},
        [29] = {title = "حيازة الفطر بقصد التوزيع", class = 'جناية', id = 'المادة 7029', months = 35, fine = 4500, color = 'orange', description = "حيازة كمية من الشروم بغرض التوزيع"},
        [30] = {title = "جنحة حيازة العجاف", class = 'جنحة', id = 'المادة 7030', months = 7, fine = 500, color = 'green', description = 'حيازة العجاف بكمية صغيرة عادة للاستخدام الشخصي'},
        [31] = {title = "جريمة تصنيع حيازة العجاف", class = 'جناية', id = 'المادة 7031', months = 25, fine = 1500, color = 'red', description = "حيازة كمية من العجاف تكون من التصنيع"},
        [32] = {title = "حيازة العجاف بقصد التوزيع", class = 'جناية', id = 'المادة 7032', months = 35, fine = 4500, color = 'orange', description = "حيازة كمية من العجاف للتوزيع"},
        [33] = {title = "بيع مادة خاضعة للرقابة", class = 'جنحة', id = 'المادة 7033', months = 10, fine = 1000, color = 'green', description = 'بيع مادة خاضعة لرقابة القانون'},
        [34] = {title = 'تهريب المخدرات', class = 'جناية', id = 'المادة 7034', months = 0, fine = 0, color = 'red', description = "حركة المخدرات غير المشروعة على نطاق واسع"},
        [35] = {title = "تدنيس جثة بشرية" , class = 'جناية', id = 'المادة 7035', months = 20, fine = 1500, color = 'orange', description = 'عندما يقوم شخص ما بإيذاء أو إزعاج أو إتلاف بقايا شخص آخر'},
        [36] = {title = 'تسمم عامة', class = 'مخالفة', id = 'المادة 7036', months = 0, fine = 500, color = 'green', description = 'عندما يكون شخص ما في حالة سكر فوق الحد القانوني في الأماكن العامة'},
        [37] = {title = 'فساد عام', class = 'جنحة', id = 'المادة 7037', months = 10, fine = 750, color = 'green', description = "من تعرض لنفسه بطريقة مخلة بالآداب العامة"},
    },    
    [6] = {
        [1] = {title =  "الحيازة الإجرامية لسلاح من الفئة أ", class = 'جناية', id = 'المادة 8001', months = 10, fine = 500, color = 'green', description = 'حيازة سلاح ناري من الفئة (أ) دون ترخيص'},
        [2] = {title =  "الحيازة الإجرامية لسلاح من الفئة ب", class = 'جناية', id = 'المادة 8002', months = 15, fine = 1000, color = 'green', description = 'حيازة سلاح ناري من الفئة ب دون ترخيص'},
        [3] = {title =  "الحيازة الإجرامية لسلاح من الفئة ج", class = 'جناية', id = 'المادة 8003', months = 30, fine = 3500, color = 'green', description = 'حيازة سلاح ناري من الفئة C دون ترخيص'},
        [4] = {title =  "الحيازة الإجرامية لسلاح من الفئة د", class = 'جناية', id = 'المادة 8004', months = 25, fine = 1500, color = 'green', description = 'حيازة سلاح ناري من الفئة د دون ترخيص'},
        [5] = {title =  "البيع الإجرامي للأسلحة من الفئة أ", class = 'جناية', id = 'المادة 8005', months = 15, fine = 1000, color = 'orange', description = 'عملية بيع سلاح ناري من الفئة أ دون ترخيص'},
        [6] = {title =  "البيع الإجرامي للأسلحة من الفئة ب", class = 'جناية', id = 'المادة 8006', months = 20, fine = 2000, color = 'orange', description = 'عملية بيع سلاح ناري من الفئة ب دون ترخيص'},
        [7] = {title =  "البيع الإجرامي للأسلحة من الفئة ج", class = 'جناية', id = 'المادة 8007', months = 35, fine = 7000, color = 'orange', description = 'عملية بيع سلاح ناري من الفئة C بدون ترخيص'},
        [8] = {title =  "البيع الإجرامي للأسلحة من الفئة د", class = 'جناية', id = 'المادة 8008', months = 30, fine = 3000, color = 'orange', description = 'عملية بيع سلاح ناري من الفئة D بدون ترخيص'},
        [9] = {title =  "الاستخدام الإجرامي للسلاح", class = 'جنحة', id = 'المادة 8009', months = 10, fine = 450, color = 'orange', description = 'Use of a weapon while in commission of a crime'},
        [10] = {title = "حيازة تعديلات غير قانونية على الأسلحة النارية", class = 'جنحة', id = 'المادة 8010', months = 10, fine = 300, color = 'green', description = 'حيازة تعديلات على الأسلحة النارية بشكل غير قانوني'},
        [11] = {title = "تهريب الأسلحة", class = 'جناية', id = 'المادة 8011', months = 0, fine = 0, color = 'red', description = 'نقل كمية كبيرة من الأسلحة من نقطة إلى أخرى'},
        [12] = {title = "التلويح بالسلاح", class = 'جنحة', id = 'المادة 8012', months = 15, fine = 500, color = 'orange', description = "عملية جعل السلاح الناري مرئيًا عمدًا"},
        [13] = {title = "التمرد", class = 'جناية', id = 'المادة 8013', months = 0, fine = 0, color = 'red', description = "محاولة الإطاحة بالحكومة بالعنف"},
        [14] = {title = "التحليق في المجال الجوي المحظور", class = 'جناية', id = 'المادة 8014', months = 20, fine = 1500, color = 'green', description = "الطيارون والطائرات في المجال الجوي الخاضع لسيطرة الحكومة"},
        [15] = {title = "المشي على الأقدام", class = 'مخالفة', id = 'المادة 8015', months = 0, fine = 150, color = 'green', description = 'عبور الطريق بطريقة تشكل خطورة على المركبات الآلية'},
        [16] = {title = "الاستخدام الإجرامي للمتفجرات", class = 'جناية', id = 'المادة 8016', months = 30, fine = 2500, color = 'orange', description = "استخدام المتفجرات لارتكاب جريمة"},
    },    
    [7] = {
        [1] = {title = 'رشوة موظف حكومي', class = 'جناية', id = 'المادة 5001', months = 20, fine = 3500, color = 'green', description = 'استخدام الأموال أو الخدمات أو الممتلكات لكسب تأييد مسؤول حكومي'},
        [2] = {title = ' لبس الأقنعة', class = 'مخالفة', id = 'المادة 5002', months = 0, fine = 750, color = 'green', description = 'ارتداء القناع في منطقة محظورة'},
        [3] = {title = 'حيازة مواد محظورة في منشأة حكومية', class = 'جناية', id = 'المادة 5003', months = 25, fine = 1000, color = 'green', description = 'حيازة أشياء غير قانونية أثناء وجودك داخل مبنى حكومي'},
        [4] = {title = 'الحيازة الجنائية للممتلكات المسروقة', class = 'جنحة', id = 'المادة 5004', months = 10, fine = 500, color = 'green', description = 'حيازة أشياء مسروقة بعلم أو بغير علم'},
        [5] = {title = 'الهروب', class = 'جناية', id = 'المادة 5005', months = 10, fine = 450, color = 'green', description = 'اي ترك الاحتجاز عمدًا وعن علم أثناء الاعتقال أو الاحتجاز أو السجن بشكل قانوني'},
        [6] = {title = 'الهروب من السجن', class = 'جناية', id = 'المادة 5006', months = 30, fine = 2500, color = 'orange', description = 'إجراء مغادرة عهدة الدولة من منشأة احتجاز تابعة للولاية أو المقاطعة'},
        [7] = {title = 'ملحق لهروب من السجن', class = 'جناية', id = 'المادة 5007', months = 25, fine = 2000, color = 'orange', description = 'اي المشاركة  في اي عمل اجرامي مع اسباقية الاصرار'},
        [8] = {title = 'محاولة الهروب من السجن', class = 'جناية', id = 'المادة 5008', months = 20, fine = 1500, color = 'orange', description = 'محاولة الهروب المتعمدة من منشأة احتجاز تابعة للولاية أو المقاطعة'},
        [9] = {title = 'شهادة زور', class = 'جناية', id = 'المادة 5009', months = 0, fine = 0, color = 'green', description = 'اي قول الكذب مع الالتزام قانوناً بقول الحقيقة'},
        [10] = {title = 'انتهاك أمر تقييديr', class = 'جناية', id = 'المادة 5010', months = 20, fine = 2250, color = 'green', description = 'أمرت المحكمة بالتعدي المتعمد والمعرفي على وثائق الحماية'},
        [11] = {title = 'الاختلاس', class = 'جناية', id = 'المادة 5011', months = 45, fine = 10000, color = 'green', description = 'النقل المتعمد للأموال من الحسابات المصرفية غير الشخصية إلى الحسابات المصرفية الشخصية لتحقيق مكاسب شخصية'},
        [12] = {title = 'ممارسة غير قانونية', class = 'جناية', id = 'المادة 5012', months = 15, fine = 1500, color = 'orange', description = 'إجراء أداء خدمة دون الحصول على ترخيص وموافقة قانونية مناسبة'},
        [13] = {title = 'إساءة استخدام أنظمة الطوارئ', class = 'مخالفة', id = 'المادة 5013', months = 0, fine = 600, color = 'orange', description = 'استخدام معدات الطوارئ الحكومية في غير الأغراض المخصصة لها'},
        [14] = {title = 'مؤامرة', class = 'جنحة', id = 'المادة 5014', months = 10, fine = 450, color = 'green', description = 'اي التخطيط لجريمة ولكن لم يتم ارتكاب الجريمة بعد'},
        [15] = {title = 'انتهاك أمر المحكمة', class = 'جنحة', id = 'المادة 5015', months = 0, fine = 0, color = 'orange', description = 'التعدي على أمرت المحكمة التوثيق'},
        [16] = {title = 'فشل في الظهور', class = 'جنحة', id = 'المادة 5016', months = 0, fine = 0, color = 'orange', description = 'عندما لا يقوم شخص ملزم قانونًا بالمثول أمام المحكمة'},
        [17] = {title = 'ازدراء المحكمة', class = 'جناية', id = 'المادة 5017', months = 0, fine = 0, color = 'orange', description = 'اي عدم السماح لموظفيي نالحكوميين باحتجازك بشكل سلمي'},
        [18] = {title = 'مقاومة الاعتقال', class = 'جنحة', id = 'المادة 5018', months = 5, fine = 300, color = 'orange', description = 'اي عدم السماح لضباط السلام باحتجازك عن طيب خاطر'},
    },    
    [8] = {
        [1] = {title = 'انتحال شخصية', class = 'جنحة', id = 'المادة 3001', months = 15, fine = 1250, color = 'green', description = 'إجراء تعريف زائف كشخص آخر للخداع'},
        [2] = {title = 'انتحال صفة موظف حكومي', class = 'جناية', id = 'المادة 3002', months = 25, fine = 2750, color = 'green', description = 'العمل على تعريف زائف كموظف حكومي للخداع'},
        [3] = {title = 'انتحال صفة القاضي', class = 'جناية', id = 'المادة 3003', months = 0, fine = 0, color = 'green', description = 'عمل التعريف زورا كقاضي للخداع'},
        [4] = {title = 'حيازة الهوية المسروقة', class = 'جنحة', id = 'المادة 3004', months = 10, fine = 750, color = 'green', description = "الحيازة على هوية شخص آخر دون موافقة"},
        [5] = {title = 'حيازة الهوية الحكومية المسروقة', class = 'جنحة', id = 'المادة 3005', months = 20, fine = 2000, color = 'green', description = 'الحيازة على هوية موظف حكومي دون موافقته'},
        [6] = {title = 'ابتزاز', class = 'جناية', id = 'المادة 3006', months = 20, fine = 900, color = 'orange', description = 'التهديد أو التسبب في ضرر لشخص أو ممتلكات لتحقيق مكاسب مالية'},
        [7] = {title = 'احتيال', class = 'جنحة', id = 'المادة 3007', months = 10, fine = 450, color = 'green', description = 'اي خداع  شخص آخر لتحقيق مكاسب مالية'},
        [8] = {title = 'تزوير', class = 'جنحة', id = 'المادة 3008', months = 15, fine = 750, color = 'green', description = 'تزوير الوثائق القانونية لتحقيق مكاسب شخصية'},
        [9] = {title = 'غسيل أموال', class = 'جناية', id = 'المادة 3009', months = 0, fine = 0, color = 'red', description = 'تجهيز الأموال المسروقة للعملة القانونية'},
        [10] = {title = 'الهروب دون الدفع', class = 'جناية', id = 'المادة 3010', months = 0, fine = 500, color = 'green', description = 'اي مغادرة مؤسسة دون دفع ثمن الخدمة المقدمة'},
    },
    [9] = {
        [1] = {title = 'التعدي على ممتلكات الغير', class = 'جنحة', id = 'المادة 4001', months = 10, fine = 450, color = 'green', description = 'أن يكون الشخص داخل حدود مكان لا يسمح له قانونًا بالتواجد فيه'},
        [2] = {title = 'جريمة التعدي على ممتلكات الغير', class = 'جناية', id = 'المادة 4002', months = 15, fine = 1500, color = 'green', description = 'أن يقوم شخص ما بالدخول بشكل متكرر إلى حدود موقع لا يسمح له قانونًا بالدخول إليه مع علمه بذلك'},
        [3] = {title = 'حريق متعمد', class = 'جناية', id = 'المادة 4003', months = 15, fine = 1500, color = 'orange', description = 'الاستخدام في حالة الحريق والمسرعات سوف يؤدي إلى تدمير أو إيذاء أو التسبب في وفاة شخص أو ممتلكات بشكل ضار'},
        [4] = {title = 'التخريب', class = 'مخالفة', id = 'المادة 4004', months = 0, fine = 300, color = 'green', description = 'التدمير المتعمد للممتلكات'},
        [5] = {title = 'تخريب الممتلكات الحكومية', class = 'جناية', id = 'المادة 4005', months = 20, fine = 1500, color = 'green', description = 'التدمير المتعمد للممتلكات الحكومية'},
        --[6] = {title = 'رمي القمامة', class = 'مخالفة', id = 'المادة 4006', months = 0, fine = 200, color = 'green', description = 'The willful discard of refuse into to open and not in designated bin'},
    },
    [10] = {
        [1] = {title = "الصيد في المناطق المحظورة", class = 'مخالفة', id = 'المادة 10001', months = 0, fine = 450, color = 'green', description = "حصاد الصيد في المناطق التي يمنع فيها ذلك"},
        [2] = {title = "الصيد غير المرخص", class = 'مخالفة', id = 'المادة 10002', months = 0, fine = 450, color = 'green', description = 'حصاد اللعبة بدون ترخيص مناسب'},
        [3] = {title = 'القسوة على الحيوان', class = 'جنحة', id = 'المادة 10003', months = 10, fine = 450, color = 'green', description = "الإساءة إلى الحيوان بعلم أو بغير علم"},
        [4] = {title = "الصيد بسلاح غير سلاح الصيد", class = 'جنحة', id = 'المادة 10004', months = 10, fine = 750, color = 'green', description = "استخدام سلاح غير منصوص عليه قانونًا أو لم يتم تصنيعه لاستخدامه في صيد الطرائد البرية"},
        [5] = {title = "الصيد خارج ساعات الصيد", class = 'مخالفة', id = 'المادة 10005', months = 0, fine = 750, color = 'green', description = "حصاد الحيوانات خارج الوقت المحدد لذلك"},
        [6] = {title = "الصيد الجائر", class = 'جنحة', id = 'المادة 10006', months = 10, fine = 1000, color = 'green', description = 'أخذ أكثر من القدر المحدد قانونًا من اللعبة'},
        [7] = {title = "الصيد الجائر", class = 'جناية', id = 'المادة 10007', months = 20, fine = 1250, color = 'red', description = "حصاد حيوان مُدرج على أنه غير قابل للحصاد قانونيًا"},
    }
}

Config.AllowedJobs = {}
for index, value in pairs(Config.PoliceJobs) do
    Config.AllowedJobs[index] = value
end
for index, value in pairs(Config.AmbulanceJobs) do
    Config.AllowedJobs[index] = value
end
for index, value in pairs(Config.DojJobs) do
    Config.AllowedJobs[index] = value
end

Config.ColorNames = {
    [0] = "Metallic Black",
    [1] = "Metallic Graphite Black",
    [2] = "Metallic Black Steel",
    [3] = "Metallic Dark Silver",
    [4] = "Metallic Silver",
    [5] = "Metallic Blue Silver",
    [6] = "Metallic Steel Gray",
    [7] = "Metallic Shadow Silver",
    [8] = "Metallic Stone Silver",
    [9] = "Metallic Midnight Silver",
    [10] = "Metallic Gun Metal",
    [11] = "Metallic Anthracite Grey",
    [12] = "Matte Black",
    [13] = "Matte Gray",
    [14] = "Matte Light Grey",
    [15] = "Util Black",
    [16] = "Util Black Poly",
    [17] = "Util Dark silver",
    [18] = "Util Silver",
    [19] = "Util Gun Metal",
    [20] = "Util Shadow Silver",
    [21] = "Worn Black",
    [22] = "Worn Graphite",
    [23] = "Worn Silver Grey",
    [24] = "Worn Silver",
    [25] = "Worn Blue Silver",
    [26] = "Worn Shadow Silver",
    [27] = "Metallic Red",
    [28] = "Metallic Torino Red",
    [29] = "Metallic Formula Red",
    [30] = "Metallic Blaze Red",
    [31] = "Metallic Graceful Red",
    [32] = "Metallic Garnet Red",
    [33] = "Metallic Desert Red",
    [34] = "Metallic Cabernet Red",
    [35] = "Metallic Candy Red",
    [36] = "Metallic Sunrise Orange",
    [37] = "Metallic Classic Gold",
    [38] = "Metallic Orange",
    [39] = "Matte Red",
    [40] = "Matte Dark Red",
    [41] = "Matte Orange",
    [42] = "Matte Yellow",
    [43] = "Util Red",
    [44] = "Util Bright Red",
    [45] = "Util Garnet Red",
    [46] = "Worn Red",
    [47] = "Worn Golden Red",
    [48] = "Worn Dark Red",
    [49] = "Metallic Dark Green",
    [50] = "Metallic Racing Green",
    [51] = "Metallic Sea Green",
    [52] = "Metallic Olive Green",
    [53] = "Metallic Green",
    [54] = "Metallic Gasoline Blue Green",
    [55] = "Matte Lime Green",
    [56] = "Util Dark Green",
    [57] = "Util Green",
    [58] = "Worn Dark Green",
    [59] = "Worn Green",
    [60] = "Worn Sea Wash",
    [61] = "Metallic Midnight Blue",
    [62] = "Metallic Dark Blue",
    [63] = "Metallic Saxony Blue",
    [64] = "Metallic Blue",
    [65] = "Metallic Mariner Blue",
    [66] = "Metallic Harbor Blue",
    [67] = "Metallic Diamond Blue",
    [68] = "Metallic Surf Blue",
    [69] = "Metallic Nautical Blue",
    [70] = "Metallic Bright Blue",
    [71] = "Metallic Purple Blue",
    [72] = "Metallic Spinnaker Blue",
    [73] = "Metallic Ultra Blue",
    [74] = "Metallic Bright Blue",
    [75] = "Util Dark Blue",
    [76] = "Util Midnight Blue",
    [77] = "Util Blue",
    [78] = "Util Sea Foam Blue",
    [79] = "Uil Lightning blue",
    [80] = "Util Maui Blue Poly",
    [81] = "Util Bright Blue",
    [82] = "Matte Dark Blue",
    [83] = "Matte Blue",
    [84] = "Matte Midnight Blue",
    [85] = "Worn Dark blue",
    [86] = "Worn Blue",
    [87] = "Worn Light blue",
    [88] = "Metallic Taxi Yellow",
    [89] = "Metallic Race Yellow",
    [90] = "Metallic Bronze",
    [91] = "Metallic Yellow Bird",
    [92] = "Metallic Lime",
    [93] = "Metallic Champagne",
    [94] = "Metallic Pueblo Beige",
    [95] = "Metallic Dark Ivory",
    [96] = "Metallic Choco Brown",
    [97] = "Metallic Golden Brown",
    [98] = "Metallic Light Brown",
    [99] = "Metallic Straw Beige",
    [100] = "Metallic Moss Brown",
    [101] = "Metallic Biston Brown",
    [102] = "Metallic Beechwood",
    [103] = "Metallic Dark Beechwood",
    [104] = "Metallic Choco Orange",
    [105] = "Metallic Beach Sand",
    [106] = "Metallic Sun Bleeched Sand",
    [107] = "Metallic Cream",
    [108] = "Util Brown",
    [109] = "Util Medium Brown",
    [110] = "Util Light Brown",
    [111] = "Metallic White",
    [112] = "Metallic Frost White",
    [113] = "Worn Honey Beige",
    [114] = "Worn Brown",
    [115] = "Worn Dark Brown",
    [116] = "Worn straw beige",
    [117] = "Brushed Steel",
    [118] = "Brushed Black steel",
    [119] = "Brushed Aluminium",
    [120] = "Chrome",
    [121] = "Worn Off White",
    [122] = "Util Off White",
    [123] = "Worn Orange",
    [124] = "Worn Light Orange",
    [125] = "Metallic Securicor Green",
    [126] = "Worn Taxi Yellow",
    [127] = "police car blue",
    [128] = "Matte Green",
    [129] = "Matte Brown",
    [130] = "Worn Orange",
    [131] = "Matte White",
    [132] = "Worn White",
    [133] = "Worn Olive Army Green",
    [134] = "Pure White",
    [135] = "Hot Pink",
    [136] = "Salmon pink",
    [137] = "Metallic Vermillion Pink",
    [138] = "Orange",
    [139] = "Green",
    [140] = "Blue",
    [141] = "Mettalic Black Blue",
    [142] = "Metallic Black Purple",
    [143] = "Metallic Black Red",
    [144] = "Hunter Green",
    [145] = "Metallic Purple",
    [146] = "Metaillic V Dark Blue",
    [147] = "MODSHOP BLACK1",
    [148] = "Matte Purple",
    [149] = "Matte Dark Purple",
    [150] = "Metallic Lava Red",
    [151] = "Matte Forest Green",
    [152] = "Matte Olive Drab",
    [153] = "Matte Desert Brown",
    [154] = "Matte Desert Tan",
    [155] = "Matte Foilage Green",
    [156] = "DEFAULT ALLOY COLOR",
    [157] = "Epsilon Blue",
    [158] = "Unknown",
}

Config.ColorInformation = {
    [0] = "black",
    [1] = "black",
    [2] = "black",
    [3] = "darksilver",
    [4] = "silver",
    [5] = "bluesilver",
    [6] = "silver",
    [7] = "darksilver",
    [8] = "silver",
    [9] = "bluesilver",
    [10] = "darksilver",
    [11] = "darksilver",
    [12] = "matteblack",
    [13] = "gray",
    [14] = "lightgray",
    [15] = "black",
    [16] = "black",
    [17] = "darksilver",
    [18] = "silver",
    [19] = "utilgunmetal",
    [20] = "silver",
    [21] = "black",
    [22] = "black",
    [23] = "darksilver",
    [24] = "silver",
    [25] = "bluesilver",
    [26] = "darksilver",
    [27] = "red",
    [28] = "torinored",
    [29] = "formulared",
    [30] = "blazered",
    [31] = "gracefulred",
    [32] = "garnetred",
    [33] = "desertred",
    [34] = "cabernetred",
    [35] = "candyred",
    [36] = "orange",
    [37] = "gold",
    [38] = "orange",
    [39] = "red",
    [40] = "mattedarkred",
    [41] = "orange",
    [42] = "matteyellow",
    [43] = "red",
    [44] = "brightred",
    [45] = "garnetred",
    [46] = "red",
    [47] = "red",
    [48] = "darkred",
    [49] = "darkgreen",
    [50] = "racingreen",
    [51] = "seagreen",
    [52] = "olivegreen",
    [53] = "green",
    [54] = "gasolinebluegreen",
    [55] = "mattelimegreen",
    [56] = "darkgreen",
    [57] = "green",
    [58] = "darkgreen",
    [59] = "green",
    [60] = "seawash",
    [61] = "midnightblue",
    [62] = "darkblue",
    [63] = "saxonyblue",
    [64] = "blue",
    [65] = "blue",
    [66] = "blue",
    [67] = "diamondblue",
    [68] = "blue",
    [69] = "blue",
    [70] = "brightblue",
    [71] = "purpleblue",
    [72] = "blue",
    [73] = "ultrablue",
    [74] = "brightblue",
    [75] = "darkblue",
    [76] = "midnightblue",
    [77] = "blue",
    [78] = "blue",
    [79] = "lightningblue",
    [80] = "blue",
    [81] = "brightblue",
    [82] = "mattedarkblue",
    [83] = "matteblue",
    [84] = "matteblue",
    [85] = "darkblue",
    [86] = "blue",
    [87] = "lightningblue",
    [88] = "yellow",
    [89] = "yellow",
    [90] = "bronze",
    [91] = "yellow",
    [92] = "lime",
    [93] = "champagne",
    [94] = "beige",
    [95] = "darkivory",
    [96] = "brown",
    [97] = "brown",
    [98] = "lightbrown",
    [99] = "beige",
    [100] = "brown",
    [101] = "brown",
    [102] = "beechwood",
    [103] = "beechwood",
    [104] = "chocoorange",
    [105] = "yellow",
    [106] = "yellow",
    [107] = "cream",
    [108] = "brown",
    [109] = "brown",
    [110] = "brown",
    [111] = "white",
    [112] = "white",
    [113] = "beige",
    [114] = "brown",
    [115] = "brown",
    [116] = "beige",
    [117] = "steel",
    [118] = "blacksteel",
    [119] = "aluminium",
    [120] = "chrome",
    [121] = "wornwhite",
    [122] = "offwhite",
    [123] = "orange",
    [124] = "lightorange",
    [125] = "green",
    [126] = "yellow",
    [127] = "blue",
    [128] = "green",
    [129] = "brown",
    [130] = "orange",
    [131] = "white",
    [132] = "white",
    [133] = "darkgreen",
    [134] = "white",
    [135] = "pink",
    [136] = "pink",
    [137] = "pink",
    [138] = "orange",
    [139] = "green",
    [140] = "blue",
    [141] = "blackblue",
    [142] = "blackpurple",
    [143] = "blackred",
    [144] = "darkgreen",
    [145] = "purple",
    [146] = "darkblue",
    [147] = "black",
    [148] = "purple",
    [149] = "darkpurple",
    [150] = "red",
    [151] = "darkgreen",
    [152] = "olivedrab",
    [153] = "brown",
    [154] = "tan",
    [155] = "green",
    [156] = "silver",
    [157] = "blue",
    [158] = "black",
}

Config.ClassList = {
    [0] = "Compact",
    [1] = "Sedan",
    [2] = "SUV",
    [3] = "Coupe",
    [4] = "Muscle",
    [5] = "Sport Classic",
    [6] = "Sport",
    [7] = "Super",
    [8] = "Motorbike",
    [9] = "Off-Road",
    [10] = "Industrial",
    [11] = "Utility",
    [12] = "Van",
    [13] = "Bike",
    [14] = "Boat",
    [15] = "Helicopter",
    [16] = "Plane",
    [17] = "Service",
    [18] = "Emergency",
    [19] = "Military",
    [20] = "Commercial",
    [21] = "Train"
}

function GetJobType(job)
	if Config.PoliceJobs[job] then
		return 'police'
	elseif Config.AmbulanceJobs[job] then
		return 'ambulance'
	elseif Config.DojJobs[job] then
		return 'doj'
	else
		return nil
	end
end

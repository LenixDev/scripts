local Translations = {
    error = {
        no_vehicles = 'لا يوجد مركبات في هذا المكان!',
        not_depot = 'مركبتك ليست في المستودع',
        not_owned = 'لا يمكن تخزين هذه المركبة',
        not_correct_type = 'لا يمكنك تخزين هذا النوع من المركبات هنا',
        not_enough = 'لا يوجد مال كافي',
        no_garage = 'لا شيء',
        vehicle_occupied = 'لا يمكنك إخراج هاذه المركبة لأن هاذا المكان مزدحم',
        vehicle_not_tracked = 'تعذر تعقب المركبة',
        no_spawn = 'المنطقة مزدحمة جدًا'
    },
    success = {
        vehicle_parked = 'تم تخزين المركبة',
        vehicle_tracked = 'تم تعقب المركبة',
    },
    status = {
        out = 'خارج',
        garaged = 'تم التخزين',
        impound = 'مصادرة من قبل الشرطة',
        house = 'منزل',
    },
    info = {
        car_e = 'المرآب',
        sea_e = 'مرفأ القوارب',
        air_e = 'الجناح',
        rig_e = 'موقف الحفر',
        depot_e = 'المستودع',
        house_garage = 'مرآب المنزل',
    }
}

if GetConvar('qb_locale', 'en') == 'ar' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
local Translations = {
    store = {
        barber = " Barber Shop ",
        surgeon = "Plastic Surgeon",
        clothing = " Clothing Store ",
        outfitchanger = "مغير الطقم"
    },

    outfits = {
        roomOutfits = " الطقم الجاهز",
        myOutfits = "الطقم الخاص بي",
        character = "الملابس",
        accessoires = "الاكسسوارات"
    },

    menu = {
        hair = "الشعر",
        character = "الملابس",
        accessoires = "الاكسسوارات",
        features = "الشكل"
    },

    ui = {
        select = "اختيار",
        delete = "حذف",
        select_outfit = "حدد الزي",
        player_model = "نوع اللاعب",
        model = "النوع",
        mother = " الام",
        father = " الاب",
        texture = "الصنف",
        type = "نوع",
        item = "العنصر",
        skin_color = "لون البشرة",
        parent_mixer = "ملامح الوالدين",
        shape_mix = "ملامح الوجه ",
        skin_mix = "لون البشرة",
        arms = "اليدين",
        undershirt = "القميص داخلي",
        color = "اللون",
        jacket = "الجاكيت",
        vests = "الدرع",
        decals = "الشارات",
        acessory = "اكسسوارات الرقبة",
        bags = "الحقيبة",
        pants = "السروال",
        shoes = "الحذاء",
        eye_color = "لون العين",
        moles = "الشامات/النمش",
        opacity = "العتامة",
        nose_width = "عرض الانف",
        width = "العرض",
        nose_peak_height = "ارتفاع ذروة الأنف",
        height = "الارتفاع",
        nose_peak_length = "طول ذروة الأنف",
        length = "الطول",
        nose_bone_height = "ارتفاع عظام الأنف",
        nose_peak_lowering = "خفض ذروة الأنف",
        lowering = "الانخفاض",
        nose_bone_twist = "إلتواء عظم الأنف",
        twist = "إلتواء",
        eyebrow_height = "ارتفاع الحاجب",
        eyebrow_depth = "عمق الحاجب",
        depth = "عمق",
        cheeks_height = "ارتفاع الخدود",
        cheeks_width = "عرض الخدود",
        cheeks_depth = "عمق الخدين",
        eyes_opening = "فتحة العيون",
        opening = "الفتحة",
        lips_thickness = "سماكة الشفاه",
        thickness = "السماكة",
        jaw_bone_width = "عرض عظم الفك",
        jaw_bone_length = "طول عظم الفك",
        chin_height = "ارتفاع عظم الذقن",
        chin_width = "عرض عظم الذقن",
        butt_chin  ="بعقب الذقن",
        size = "مقاس",
        neck_thickness = "سماكة الرقبة",
        ageing = "شيخوخة",
        hair = "شعر",
        eyebrow = "الحواجب",
        facial_hair = "اللحية",
        lipstick = "أحمر الشفاه",
        blush = "احمر خدود",
        makeup = "ماكياج",
        mask = "أقنعة",
        hat = "القبعات",
        glasses = "نظارات",
        ear_accessories = "إكسسوارات الأذن",
        watch = "ساعات",
        bracelet = "الأساور",
        btn_confirm = "تأكيد",
        btn_cancel = "الغاء",
        btn_saveOutfit = "حفظ الملابس",
        outfit_name = "اسم الملابس"
    },

    notify = {
        error_bracelet = " ! لا يمكنك إزالة سوار الكاحل الخاص بك",
        info_deleteOutfit = "الملابس الخاصة بك %{outfit} لقد قمت بحذف  "
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
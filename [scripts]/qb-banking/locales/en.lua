local Translations = {
    success = {
        withdraw = 'تم السحب بنجاح',
        deposit = 'تم الإيداع بنجاح',
        transfer = 'تم التحويل بنجاح',
        account = 'تم إنشاء حساب',
        rename = 'تم تغيير اسم الحساب',
        delete = 'تم حذف الحساب',
        userAdd = 'تم اضافة مستخدم',
        userRemove = 'تم ازالة مستخدم',
        card = 'تم انئاء بطاقة',
    },
    error = {
        error = 'حدث خطأ ما',
        access = 'لا يمكن فعل ذلك ',
        account = 'لم يتم العثور على الحساب',
        accounts = 'تم إنشاء الحد الأقصى للحسابات',
        user = 'تمت إضافة المستخدم بالفعل',
        noUser = ' لم يتم العثور على المستخدم',
        money = 'ليس لديك بما يكفي من المال',
        pin = 'كلمة السر خاطئا',
        card = 'انت لا تحمل اي بطاقة مصرف',
    },
    progress = {
        atm = 'دخول الحساب',
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

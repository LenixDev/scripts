local Translations = {
    error = {
        negative = 'هل تحاول بيع كمية سالبة؟',
        no_melt = 'لم تعطيني أي شيء لإذابته...',
        no_items = 'ليس لديك ما يكفي من العناصر',
        inventory_full = 'المخزون ممتلئ جدًا لاستلام جميع العناصر الممكنة. حاول التأكد من أن المخزون غير ممتلئ في المرة القادمة. العناصر المفقودة: %{value}'
    },
    success = {
        sold = 'لقد بعت %{value} × %{value2} مقابل $%{value3}',
        items_received = 'لقد استلمت %{value} × %{value2}',
    },
    info = {
        title = 'دكان الرهن',
        subject = 'إذابة العناصر',
        message = 'لقد أنهينا إذابة العناصر الخاصة بك. يمكنك القدوم لاستلامها في أي وقت.',
        open_pawn = 'افتح دكان الرهن',
        sell = 'بيع العناصر',
        sell_pawn = 'بيع العناصر لدكان الرهن',
        melt = 'إذابة العناصر',
        melt_pawn = 'افتح محل الإذابة',
        melt_pickup = 'استلام العناصر المذابة',
        pawn_closed = 'دكان الرهن مغلق. تعال بين %{value}:00 صباحًا - %{value2}:00 مساءً',
        sell_items = 'سعر البيع $%{value}',
        back = '⬅ العودة',
        melt_item = 'إذابة %{value}',
        max = 'أقصى كمية %{value}',
        submit = 'إذابة',
        melt_wait = 'امنحني %{value} دقيقة وسأقوم بإذابة الأشياء الخاصة بك',
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

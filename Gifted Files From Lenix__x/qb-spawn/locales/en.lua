local Translations = {
    ui = {
        last_location = "أخر موقع",
        confirm = "تأكيد",
        where_would_you_like_to_start = "أين تود النزول",
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

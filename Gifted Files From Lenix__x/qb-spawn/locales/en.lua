local Translations = {
    ui = {
        last_location = "اخر موقع",
        confirm = "تأكيد",
        where_would_you_like_to_start = "اين تريد البدء",
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})

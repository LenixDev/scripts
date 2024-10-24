local Translations = {
    info = {
        open_shop = '[E] Shop',
        sell_chips = '[E] Sell Chips'
    },
    error = {
        missing_license = 'تحتاج الى  رخصة سلاح لبعض المنتجات',

    },
    success = {
        dealer_verify = 'The dealer verifies your license'
    },
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
local Translations = {
    error = {
        incorrect = 'Girilen şifre doğru değil!',
        wrong = 'Bir şeyler yanlış gitti!',
        passmismatch = 'Parolalar eşleşmiyor!',
    },
    success = {
        changed = 'Şifre değiştirildi!',
    },
    target = {
        label = 'Depoyu Aç'
    },
    menu = {
        stash = 'Depo',
        stashtxt = 'Çete deposunu aç',
        close = '❌ Kapat',
        ogs = 'Çete deposunu aç',
        ogstxt = 'Normal depoyu aç',
        oss = 'Güvenli depoyu aç',
        osstxt = 'Güvenli çete deposunu aç',
        csp = 'Güvenli depo şifresini değiştir',
        csptxt = 'Güvenli depo şifresini değiştir',
        np = 'Yeni şifre (default:1234)',
        rtp = 'İkinci şifre',
        cpf = 'Şifreyi Değiştir',
        cpftext = 'Değiştir',
        pf = 'Şifre',
        pftext = 'Aç',
        pftext2 = 'Şifre'
    },
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
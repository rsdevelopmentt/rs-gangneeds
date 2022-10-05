local Translations = {
    error = {
        incorrect = 'Ingevoerde wachtwoord is niet correct!',
        wrong = 'Er is iets misgegaan!',
        passmismatch = 'Wachtwoord komt niet overeen!',
    },
    success = {
        changed = 'Wachtwoord is verandert!',
    },
    target = {
        label = 'Open Stash'
    },
    menu = {
        stash = 'Stash',
        stashtxt = 'Open bende stash',
        close = '❌ Sluiten',
        ogs = 'Open Bende Stash',
        ogstxt = 'Open het algemene bende stash',
        oss = 'Open Veilige Stash',
        osstxt = 'Open je veilige bende stash',
        csp = 'Verander Wachtwoord',
        csptxt = 'Verander veilige stash wachtwoord',
        np = 'Nieuw Wachtwoord',
        rtp = 'Herhaal Wachtwoord',
        cpf = 'Verander Wachtwoord voor',
        cpftext = 'VERANDER',
        pf = 'Wachtwoord voor',
        pftext = 'OPEN',
        pftext2 = 'Wachtwoord'
    },
}

if GetConvar('qb_locale', 'en') == 'nl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end

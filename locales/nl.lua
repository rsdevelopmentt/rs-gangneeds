local Translations = {
    error = {
        incorrect = 'Entered password is not correct!',
        wrong = 'Something went wrong!',
        passmismatch = 'Passwords does not match!',
    },
    success = {
        changed = 'Password has been changed!',
    },
    target = {
        label = 'Open Stash'
    },
    menu = {
        stash = 'Stash',
        stashtxt = 'Open gang stashes',
        close = '❌ Close',
        ogs = 'Open Gang Stash',
        ogstxt = 'Open your default gang stash',
        oss = 'Open Safe Stash',
        osstxt = 'Open your safe gang stash',
        csp = 'Change Safe Pass',
        csptxt = 'Change safe stash password',
        np = 'New Password',
        rtp = 'Retype Password',
        cpf = 'Change Password for',
        cpftext = 'CHANGE',
        pf = 'Password for',
        pftext = 'OPEN',
        pftext2 = 'Password'
    },
}

if GetConvar('qb_locale', 'en') == 'nl' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
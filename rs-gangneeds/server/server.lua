local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback("rs-gangneeds:server:checkPass", function(source, cb, gang, pass)
    if Config.Debug then print("Checking Gang : "..gang.." With Password : "..pass) end
    MySQL.single('SELECT * FROM gangstash WHERE gangname = ?', {gang}, function(gangexist)
        if gangexist then
            if Config.Debug then print("Gang : "..gang.." Exist, Checking pass : "..pass) end
            MySQL.single('SELECT pass FROM gangstash WHERE gangname = ?', {gang}, function(gotpass)
                if gotpass.pass == pass then
                    if Config.Debug then print("Check passed for Gang : "..gang.." with pass : "..gotpass.pass.." given pass : "..pass) end
                    cb(true)
                else
                    if Config.Debug then print("Check failed for Gang : "..gang.." with pass : "..gotpass.pass.." given pass : "..pass) end
                    cb(false)
                end
            end)
        else
            if Config.Debug then print("Gang "..gang.." doesnt exist, it's being created in database") end
            MySQL.insert('INSERT INTO gangstash (gangname) VALUES (?)', {gang}, function(id)
                if Config.Debug then print("Gang "..gang.." created in database") end
                MySQL.single('SELECT pass FROM gangstash WHERE gangname = ?', {gang}, function(gotpass)
                    if Config.Debug then print("Gang "..gang.." password "..gotpass.pass) end
                    if gotpass.pass == pass then
                        if Config.Debug then print("matched Gang : "..gang.." Password : "..gotpass.pass.." With Given Password : "..pass) end
                        cb(true)
                    else
                        if Config.Debug then print("Mismatched Gang : "..gang.." Password : "..gotpass.pass.." With Given Password : "..pass) end
                        cb(false)
                    end
                end)
            end)
        end
    end)
end)

QBCore.Functions.CreateCallback("rs-gangneeds:server:changePass", function(source,cb,gang,pass) 
    MySQL.update('UPDATE gangstash SET pass = ? WHERE gangname = ?', {pass, gang}, function(id)
        if Config.Debug then print("Gang "..gang.." updated with pass :"..pass) end
        MySQL.single('SELECT pass FROM gangstash WHERE gangname = ?', {gang}, function(gotpass)
            if Config.Debug then print("Gang "..gang.." password "..gotpass.pass) end
            if gotpass.pass == pass then
                if Config.Debug then print("matched Gang : "..gang.." Password : "..gotpass.pass.." With Given Password : "..pass) end
                cb(true)
            else
                if Config.Debug then print("Mismatched Gang : "..gang.." Password : "..gotpass.pass.." With Given Password : "..pass) end
                cb(false)
            end
        end)
    end)
end)
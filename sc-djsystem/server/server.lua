ESX.RegisterServerCallback('scriptify_executeDJmenu', function(cb, source, input_one, input_two, input_three)
    local source  = _source
    local xPlayer = ESX.GetPlayerFromId(source)
    local tokenizer = Config.TokenizerToken
    TriggerClientEvent('scriptify_play_music', -1, input_one, input_two, input_three, tokenizer)
end)

ESX.RegisterServerCallback('scriptify_destoryMusic', function(cb, source)
    local source  = _source
    local xPlayer = ESX.GetPlayerFromId(source)
    local tokenizer = Config.TokenizerToken
    TriggerClientEvent('scriptify_destoryMusic', -1, tokenizer)
end)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local charm = require(ReplicatedStorage.Shared.Packages.charm)

type PlayerData = {
    points: number,
    kills: number,
    deaths: number,
    killStreak: number,
    bestKillStreak: number,
}
type PlayerDataMap = {
    [string]: PlayerData
}
  
local datastore = {
    players = charm.atom({}) :: charm.Atom<PlayerDataMap>,
}
  
local function getPlayerData(id: string): PlayerData?
    return datastore.players()[id]
end
local function setPlayerData(id, playerData)
    datastore.players(function(state)
        local newState = table.clone(state)
        newState[id] = playerData
        return newState
    end)
end
local function deletePlayerData(id)
    datastore.players(function(state)
        local newState = table.clone(state)
        newState[id] = nil
        return newState
    end)
end
local function updatePlayerData(id, updater)
    datastore.players(function(state)
        local newState = table.clone(state)
        newState[id] = updater(newState[id])
        return newState
    end)
end
return {
    getPlayerData = getPlayerData,
    setPlayerData = setPlayerData,
    deletePlayerData = deletePlayerData,
    updatePlayerData = updatePlayerData,
    datastore = datastore
}
-- In datastore.luau
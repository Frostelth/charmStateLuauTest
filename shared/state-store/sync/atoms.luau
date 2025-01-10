local ReplicatedStorage = game:GetService("ReplicatedStorage")
local flattenatoms = require(ReplicatedStorage.Shared["state-store"].sync.utils["flatten-atoms"])
local datastore = require(ReplicatedStorage.Shared["state-store"].datastore).datastore

return {atoms = flattenatoms({players = datastore.players})} 


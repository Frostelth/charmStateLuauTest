--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local charmsync = require(ReplicatedStorage.Shared.Packages["charm-sync"])
local remotes = require(ReplicatedStorage.Shared.remotes)
local atoms = require(ReplicatedStorage.Shared["state-store"].sync.atoms)

local atomsObject = {}
for key, value in pairs(atoms.atoms) do
  atomsObject[key] = function() return value end
end


local syncer = charmsync.server({
	atoms = atomsObject,     -- A dictionary of the atoms to sync, matching the client's
	interval = 60,            -- The minimum interval between state updates
	preserveHistory = false, -- Whether to send a full history of changes made to the atoms (slower)
	serializeArrays = true,  -- Safety measures for arrays, should be false when using ByteNet or Zap
})

syncer:connect(function(player, ...)
	remotes.sync:fire(player, ...)
end)

-- Sends the initial state to a player upon request. This should fire when a
-- player joins the game.
remotes.init:connect(function(player)
	syncer:hydrate(player)
end)
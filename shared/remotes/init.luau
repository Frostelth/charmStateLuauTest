--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local charmsync = require(ReplicatedStorage.Shared.Packages["charm-sync"])
local Remo = require(ReplicatedStorage.Shared.Packages.remo)
type SyncPayload = charmsync.SyncPayload
type Remotes = {
	sync: Remo.ServerToClient<SyncPayload>,
	init: Remo.ClientToServer<>,
}

local remotes: Remotes = Remo.createRemotes({
	client = Remo.remote(),
	init = Remo.remote(),
})

return remotes
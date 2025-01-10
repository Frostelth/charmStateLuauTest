local ReplicatedStorage = game:GetService("ReplicatedStorage")
type AtomMap = { [string]: any }

-- Define the NestedAtomMap type
type NestedAtomMap = { [string]: AtomMap }

-- Define the FlattenNestedAtoms type
type FlattenNestedAtoms<T> = { [string]: any }

-- Function to flatten atoms
-- Assigns unique prefixes to each atom and flattens them into a single map.
-- Should be passed to Charm's Sync API.
local function flattenAtoms<T>(maps: NestedAtomMap): FlattenNestedAtoms<T>
	local flattened = {} :: FlattenNestedAtoms<NestedAtomMap>

	for prefix, map in pairs(maps) do
		for key, atom in pairs(map) do
			flattened[prefix .. "/" .. key] = atom
		end
	end

	return flattened
end

return flattenAtoms
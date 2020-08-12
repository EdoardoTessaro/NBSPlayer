side = "back"
local modem = peripheral.wrap(side) --identify note blocks
local peripherals = modem.getNamesRemote()
local nperipherals = #peripherals

function play(filename, tempo)
  local idx = 1
  local f = fs.open(filename, "r")
  local lines = {}
  for line in f.readLine do
    lines[#lines+1] = line
  end
  
  l=1
  while l<#lines do
    if lines[l] ~= "X" then
      print(lines[l].." "..lines[l+1])
      instr = tonumber(lines[l])
      l = l+1
      key = tonumber(lines[l])
      note = { instr, key }
      msg = textutils.serialize(note)
      modem.transmit(idx, nperipherals, msg)
      idx = idx % nperipherals + 1
    else
      sleep(1/tempo)
    end
    l = l+1
  end

  f.close()
end

play("turkish_march.rnb", 5)
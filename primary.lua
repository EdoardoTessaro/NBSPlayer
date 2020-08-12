side = "back"
rednet.open(side)
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
  l = 0
  while true do
    if line ~= "X\n" then
      instr = tonomber(line)
      key = tonomber(line)
      note = { instr, key }
      msg = textutils.serialize(note)
      rednet.send(peripherals[idx], msg)
      idx = idx % nperipherals + 1
    else
      sleep(1/tempo)
    end
  end

  f.close()
end

play("turkish_march.rnb", 5)
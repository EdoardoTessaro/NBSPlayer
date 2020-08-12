id = fs.open("id", "r").readAll()
monitor_side = "bottom"
modem = peripheral.wrap(monitor_side)
rednet.open(monitor_side)
modem.open(id)
rs.setAnalogOutput("top", 0)
rs.setAnalogOutput("back", 0)
print("Ready to play")
while true do
    --id, msg = rednet.receive()
    local e,ms,sc,rc,msg,d = os.pullEvent("modem_message")
    print(msg)
    local note = textutils.unserialize(msg)
    local instr = note[0]
    local pitch = note[1]
    rs.setAnalogOutput("front", instr)
    rs.setAnalogOutput("top", pitch%16)
    rs.setAnalogOutput("back", math.floor(pitch/16))
end
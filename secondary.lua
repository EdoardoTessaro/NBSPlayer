id = 1
monitor_side = "bottom"
m = peripheral.wrap(monitor_side)
rednet.open(monitor_side)
rs.setAnalogOutput("top", 0)
rs.setAnalogOutput("back", 0)
print("Ready to play")
while true do
    --id, msg = rednet.receive()
    local msgs = {os.pullEvent("modem_message")}
    for i, msg in pairs(msgs) do
        print(msg)
    end
    local note = textutils.unserialize(msg)
    local instr = note[0]
    local pitch = note[1]
    rs.setAnalogOutput("front", instr)
    rs.setAnalogOutput("top", pitch%16)
    rs.setAnalogOutput("back", math.floor(pitch/16))
    sleep(0.05)
end
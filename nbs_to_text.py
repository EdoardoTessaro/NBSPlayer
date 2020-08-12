#See https://www.stuffbydavid.com/mcnbs/format for documentation

def getInt(bytes, f):
    return int.from_bytes(f.read(bytes), "little")

def getString(f):
    length = getInt(4, f)
    return f.read(length).decode("utf-8")

#song_path = input("Song path: ")
song_path = "turkish_march.nbs"
out_path = "turkish_march.rnb"
nbs = open(song_path, "rb")
rnb = open(out_path, "w")

# HEADER
song_length = getInt(2, nbs)
song_height = getInt(2, nbs)
song_name = getString(nbs)
song_author = getString(nbs)
original_song_author = getString(nbs)
description = getString(nbs)
tempo = getInt(2, nbs)/100
auto_saving = getInt(1, nbs)
auto_saving_duration = getInt(1, nbs)
time_signature = getInt(1, nbs)
minutes_spent = getInt(4, nbs)
left_clicks = getInt(4, nbs)
right_clicks = getInt(4, nbs)
blocks_added = getInt(4, nbs)
blocks_removed = getInt(4, nbs)
midi_file_name = getString(nbs)

print(song_name)

# NOTES
tick = -1
jumps = 0
song_height = 0
while True:
    jumps = getInt(2, nbs)
    if jumps == 0:
        break
    tick += jumps
    for i in range(jumps):
        rnb.write("X\n")
    layer = -1
    height = 0
    while True:
        jumps = getInt(2, nbs)
        if(jumps == 0):
            break
        height += 1
        layer += jumps
        inst = getInt(1, nbs)
        key = getInt(1, nbs)
        if key >= 33 and key <= 56:
            rnb.write(str(inst) + "\n" + str(key) +"\n")
        elif key == 57:
            print("WARNING: High F# note detected")
    song_height = max(song_height, height)

print("Song height:", song_height)

nbs.close()
rnb.close()
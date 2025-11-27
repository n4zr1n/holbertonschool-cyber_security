#!/usr/bin/env python3
import os
import sys
import re
import ctypes
import subprocess
import time

def usage():
    print("Usage: read_write_heap.py ./program search_string replace_string")
    sys.exit(1)

if len(sys.argv) != 4:
    usage()

binary = sys.argv[1]
search = sys.argv[2].encode()
replace = sys.argv[3].encode()

if len(replace) > len(search):
    print("Error: replace_string cannot be longer than search_string")
    usage()

# Start the program as a child
print(f"[+] Launching {binary}...")
proc = subprocess.Popen([binary])

pid = proc.pid
print(f"[+] Child pid = {pid}")

time.sleep(1)  # give program time to allocate heap

# ptrace attach WILL succeed because this is our child
libc = ctypes.CDLL("libc.so.6")
PTRACE_ATTACH = 16
PTRACE_DETACH = 17

print("[+] Attaching with ptrace...")
if libc.ptrace(PTRACE_ATTACH, pid, None, None) != 0:
    print("[-] ptrace attach failed (unexpected)")
    sys.exit(1)

os.waitpid(pid, 0)

# Find heap
maps = open(f"/proc/{pid}/maps").readlines()
heap_start = heap_end = None
for line in maps:
    if "[heap]" in line:
        m = re.match(r"([0-9a-f]+)-([0-9a-f]+)", line)
        heap_start = int(m.group(1), 16)
        heap_end = int(m.group(2), 16)
        break

print(f"[+] Heap region: {hex(heap_start)} - {hex(heap_end)}")

# Open mem
mem = open(f"/proc/{pid}/mem", "r+b", buffering=0)
mem.seek(heap_start)
heap = mem.read(heap_end - heap_start)

idx = heap.find(search)
if idx == -1:
    print("[-] String not found")
else:
    addr = heap_start + idx
    print(f"[+] Found at {hex(addr)}")

    mem.seek(addr)
    mem.write(replace + b"\x00" * (len(search) - len(replace)))
    print(f"[+] Replaced with {replace.decode()}")

# detach
libc.ptrace(PTRACE_DETACH, pid, None, None)

print("[+] Done. Press Ctrl+C to stop program.")
proc.wait()

#!/usr/bin/env python3
import sys
import os
import re

def usage_error(msg=""):
    if msg:
        print(msg)
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)

def main():
    if len(sys.argv) != 4:
        usage_error()

    pid = sys.argv[1]
    search = sys.argv[2].encode("ascii")
    replace = sys.argv[3].encode("ascii")

    if len(replace) > len(search):
        usage_error("Error: replace_string cannot be longer than search_string")

    maps_path = f"/proc/{pid}/maps"
    mem_path = f"/proc/{pid}/mem"

    try:
        with open(maps_path, "r") as maps_file:
            heap_start = None
            heap_end = None

            for line in maps_file:
                if "[heap]" in line:
                    m = re.match(r"([0-9a-f]+)-([0-9a-f]+)", line)
                    if m:
                        heap_start = int(m.group(1), 16)
                        heap_end = int(m.group(2), 16)
                        break

        if heap_start is None:
            usage_error("Could not find heap region")

        print(f"[+] Heap region: {hex(heap_start)} - {hex(heap_end)}")

        with open(mem_path, "r+b", buffering=0) as mem_file:
            mem_file.seek(heap_start)
            heap = mem_file.read(heap_end - heap_start)

            idx = heap.find(search)
            if idx == -1:
                print("[-] String not found in heap")
                return

            print(f"[+] Found '{search.decode()}' at offset {hex(heap_start + idx)}")

            mem_file.seek(heap_start + idx)
            mem_file.write(replace + b"\x00" * (len(search) - len(replace)))

            print(f"[+] Replaced with '{replace.decode()}'")

    except FileNotFoundError:
        usage_error("Error: process does not exist")
    except PermissionError:
        usage_error("Permission denied (try sudo)")
    except Exception as e:
        usage_error(f"Unexpected error: {e}")

if __name__ == "__main__":
    main()

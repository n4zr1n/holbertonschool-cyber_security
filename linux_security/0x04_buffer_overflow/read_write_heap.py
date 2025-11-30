#!/usr/bin/python3
"""
read_write_heap.py - Replace a string in the heap of a running process.
"""

import sys

def usage_error():
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)

def main():
    if len(sys.argv) != 4:
        usage_error()

    pid = sys.argv[1]
    search = sys.argv[2].encode()
    replace = sys.argv[3].encode()

    if len(replace) > len(search):
        sys.exit(1)

    try:
        heap_start = heap_end = None
        with open("/proc/{}/maps".format(pid)) as maps:
            for line in maps:
                if "[heap]" in line:
                    start, end = line.split()[0].split("-")
                    heap_start = int(start, 16)
                    heap_end = int(end, 16)
                    break

        if heap_start is None:
            print("Heap not found.")
            sys.exit(1)

        with open("/proc/{}/mem".format(pid), "r+b") as mem:
            for offset in range(heap_end - heap_start - len(search) + 1):
                mem.seek(heap_start + offset)
                chunk = mem.read(len(search))
                if chunk == search:
                    mem.seek(heap_start + offset)
                    mem.write(replace)  # write only replacement bytes
                    print("String replaced.")
                    return

            print("String not found.")
            sys.exit(0)

    except Exception:
        sys.exit(1)

if __name__ == "__main__":
    main()

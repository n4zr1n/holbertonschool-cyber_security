#!/usr/bin/python3
"""
read_write_heap.py - Replace a string in the heap of a running process.
"""

import sys


def usage_error():
    """Print usage error and exit."""
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
        # Locate heap
        with open(f"/proc/{pid}/maps") as maps_file:
            heap_start = heap_end = None
            for line in maps_file:
                if "[heap]" in line:
                    start, end = line.split()[0].split("-")
                    heap_start, heap_end = int(start, 16), int(end, 16)
                    break

            if heap_start is None:
                print("Heap not found.")
                sys.exit(1)

        # Open process memory
        with open(f"/proc/{pid}/mem", "r+b") as mem_file:
            # Search the heap byte by byte
            mem_file.seek(heap_start)
            offset = 0
            chunk_size = len(search)
            while offset <= heap_end - heap_start - len(search):
                mem_file.seek(heap_start + offset)
                chunk = mem_file.read(len(search))
                if chunk == search:
                    mem_file.seek(heap_start + offset)
                    mem_file.write(replace)  # Only overwrite replacement bytes
                    print("String replaced.")
                    return
                offset += 1

            # Not found
            print("String not found.")
            sys.exit(0)

    except Exception:
        sys.exit(1)


if __name__ == "__main__":
    main()

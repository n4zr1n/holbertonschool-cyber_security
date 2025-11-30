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
    """Main program."""
    if len(sys.argv) != 4:
        usage_error()

    pid = sys.argv[1]
    search = sys.argv[2].encode()
    replace = sys.argv[3].encode()

    if len(replace) > len(search):
        sys.exit(1)

    maps_path = f"/proc/{pid}/maps"
    mem_path = f"/proc/{pid}/mem"

    try:
        heap_start = None
        heap_end = None

        # Find heap region
        with open(maps_path, "r") as maps_file:
            for line in maps_file:
                if "[heap]" in line:
                    addr = line.split()[0]
                    start, end = addr.split("-")
                    heap_start = int(start, 16)
                    heap_end = int(end, 16)
                    break

        if heap_start is None:
            print("Heap not found.")
            sys.exit(1)

        # Read and write heap
        with open(mem_path, "r+b") as mem_file:
            mem_file.seek(heap_start)
            heap = mem_file.read(heap_end - heap_start)

            index = heap.find(search)
            if index == -1:
                print("String not found.")
                sys.exit(0)

            # Replace exactly len(search) bytes
            mem_file.seek(heap_start + index)
            data = replace.ljust(len(search), b'\0')
            mem_file.write(data)

            print("String replaced.")

    except Exception:
        sys.exit(1)


if __name__ == "__main__":
    main()

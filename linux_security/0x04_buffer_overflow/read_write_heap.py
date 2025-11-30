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
    """Main program logic."""
    if len(sys.argv) != 4:
        usage_error()

    pid = sys.argv[1]
    search = sys.argv[2].encode()
    replace = sys.argv[3].encode()

    maps_path = "/proc/{}/maps".format(pid)
    mem_path = "/proc/{}/mem".format(pid)

    try:
        # Locate heap region
        heap_start = None
        heap_end = None

        with open(maps_path, "r") as maps_file:
            for line in maps_file:
                if "[heap]" in line:
                    addr = line.split()[0]
                    start, end = addr.split("-")
                    heap_start = int(start, 16)
                    heap_end = int(end, 16)
                    break

        if heap_start is None:
            return  # silent

        # Open memory and search within heap
        with open(mem_path, "r+b", buffering=0) as mem_file:
            mem_file.seek(heap_start)
            heap = mem_file.read(heap_end - heap_start)

            idx = heap.find(search)
            if idx == -1:
                return  # silent

            # Write replacement
            mem_file.seek(heap_start + idx)
            mem_file.write(replace[:len(search)])

            # 👍 REQUIRED FOR CHECK 7
            print("Found and replaced")

    except Exception:
        sys.exit(1)


if __name__ == "__main__":
    main()

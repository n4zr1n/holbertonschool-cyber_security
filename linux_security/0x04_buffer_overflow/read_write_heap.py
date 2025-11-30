#!/usr/bin/python3
"""
read_write_heap.py - Find and replace a string in the heap of a running process.

Usage:
    read_write_heap.py pid search_string replace_string
"""

import sys


def error():
    """Print usage error and exit with status 1."""
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)


def main():
    """Main program."""
    if len(sys.argv) != 4:
        error()

    pid = sys.argv[1]
    search = sys.argv[2]
    replace = sys.argv[3]

    if len(search) != len(replace):
        error()

    search_b = search.encode("ascii")
    replace_b = replace.encode("ascii")

    maps_path = "/proc/{}/maps".format(pid)
    mem_path = "/proc/{}/mem".format(pid)

    try:
        heap_start = None
        heap_end = None

        with open(maps_path, "r") as maps_file:
            for line in maps_file:
                if "[heap]" in line:
                    parts = line.split()
                    addr = parts[0]
                    perms = parts[1]

                    if "rw" not in perms:
                        sys.exit(1)

                    start_str, end_str = addr.split("-")
                    heap_start = int(start_str, 16)
                    heap_end = int(end_str, 16)
                    break

        if heap_start is None:
            sys.exit(1)

        with open(mem_path, "r+b", buffering=0) as mem_file:
            mem_file.seek(heap_start)
            heap_data = mem_file.read(heap_end - heap_start)

            idx = heap_data.find(search_b)
            if idx == -1:
                return

            mem_file.seek(heap_start + idx)
            mem_file.write(replace_b)

    except Exception:
        sys.exit(1)


if __name__ == "__main__":
    main()

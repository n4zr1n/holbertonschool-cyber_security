#!/usr/bin/python3
"""
read_write_heap.py - Find and replace strings in the heap memory
of a running Linux process.

Usage:
    read_write_heap.py pid search_string replace_string
"""

import sys
import os


def print_usage():
    """Print usage error message."""
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)


def main():
    """Main function: parse args, read heap, replace string."""
    if len(sys.argv) != 4:
        print_usage()

    pid = sys.argv[1]
    search = sys.argv[2].encode("ascii")
    replace = sys.argv[3].encode("ascii")

    # Replacement string must be same length or shorter
    if len(replace) > len(search):
        print("replace_string must not be longer than search_string")
        sys.exit(1)

    # Pad replacement to the same length (avoids corrupting heap)
    replace = replace.ljust(len(search), b'\x00')

    maps_path = "/proc/{}/maps".format(pid)
    mem_path = "/proc/{}/mem".format(pid)

    try:
        with open(maps_path, "r") as maps_file:
            heap_start = None
            heap_end = None

            for line in maps_file:
                if "[heap]" in line:
                    parts = line.split()
                    addresses = parts[0]
                    perms = parts[1]

                    if "rw" not in perms:
                        print("Heap is not writable.")
                        sys.exit(1)

                    heap_start, heap_end = [
                        int(x, 16) for x in addresses.split("-")
                    ]
                    break

        if heap_start is None or heap_end is None:
            print("Could not find heap segment")
            sys.exit(1)

        print("[*] Heap found from 0x{:x} to 0x{:x}".format(
            heap_start, heap_end))

        with open(mem_path, "r+b") as mem_file:
            mem_file.seek(heap_start)
            heap_data = mem_file.read(heap_end - heap_start)

            idx = heap_data.find(search)
            if idx == -1:
                print("Search string not found in heap")
                sys.exit(0)

            print("[*] Found string at offset:", idx)
            print("[*] Writing replacement...")

            mem_file.seek(heap_start + idx)
            mem_file.write(replace)

            print("[+] Replacement complete!")

    except FileNotFoundError:
        print("Process does not exist")
        sys.exit(1)
    except PermissionError:
        print("Permission denied: run with sudo")
        sys.exit(1)
    except Exception as exc:
        print("Error:", exc)
        sys.exit(1)


if __name__ == "__main__":
    main()

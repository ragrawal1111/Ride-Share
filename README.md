# Assignment 5: Ride Sharing System

## Overview
This repository contains a class-based Ride Sharing System implemented in **C++** and **GNU Smalltalk**. It demonstrates encapsulation, inheritance, and polymorphism.

## Files
- `main.cpp` — C++ implementation
- `RideSharing.gst` — GNU Smalltalk implementation (command-line)
- `RideSharing.st` — Smalltalk implementation (Squeak/Pharo IDE)
- `report.md` — APA 7 report
- `sample_output.txt` — Sample outputs from both languages

## Build and Run

### C++ (requires g++)
```bash
g++ -std=c++17 -O2 -Wall main.cpp -o ride_system
./ride_system
```

### GNU Smalltalk via Docker (recommended on Windows)
Make sure Docker Desktop is running, then from the project directory:
```bash
docker run --rm -v "${PWD}:/app" -w /app ubuntu:22.04 bash -c \
  "apt-get update -qq > /dev/null 2>&1 && \
   apt-get install -y -qq gnu-smalltalk > /dev/null 2>&1 && \
   gst /app/RideSharing.gst"
```

### GNU Smalltalk (Linux / macOS)
```bash
sudo apt-get install gnu-smalltalk   # Debian/Ubuntu
gst RideSharing.gst
```

## Deliverables Checklist
- [x] Code implementation in C++ and Smalltalk
- [ ] GitHub repository link added to report
- [x] Report (APA 7) with OOP principles explained
- [ ] Screenshots of code and sample output (both languages)
- [ ] Final submission as single .docx or .pdf

## GitHub Link
Add your repo URL here:
- https://github.com/your-username/your-repo
# Ride-Share

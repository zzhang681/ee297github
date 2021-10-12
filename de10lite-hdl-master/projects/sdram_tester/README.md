# SDRAM Tester
This project is from the SDRAM tester project made by Mark Hildebrand. https://github.com/hildebrandmw/de10lite-hdl We used this project to implement SDRAM data communication for our project.

This project implements a simple SDRAM testing infrastructure and Julia source
code to automate (slowly) the testing process. This serves as both validation
for the SDRAM module on the DE10-Lite board, validation of the timing parameters
for the SDRAM controller IP component outlined [here](https://github.com/hildebrandmw/de10lite-hdl/tree/master/components/dram),
and for the [USB-Blaster](https://github.com/hildebrandmw/de10lite-hdl/tree/master/components/usb-blaster)
connection mechanism.

Key Word Agruments
------------------
* `writesize_max = 2^14` - The maximum number of bytes to write in any single 
    write action.
* `writesize_min = 2` - The minimum number of bytes to write in any single write
    action.
* `readsize_max = 2^14` - The maximum number of bytes to read in any single read 
    action.
* `readsize_min = 1` - The minimum number of bytes to read in any single read 
    action.
* `start_address = 0` - The first memory mapped address of the DRAM. If the
    SDRAM is mapped to another address, change this.
* `end_address = 0x3ff_ffff` - The final memory mapped address of the DRAM.


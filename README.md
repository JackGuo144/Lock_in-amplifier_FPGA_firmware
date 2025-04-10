# Lock_in-amplifier_FPGA_firmware

This is the repository for the Lock_in-amplifier_FPGA_firmware

Source code files are available under the source_code folder.

The project file is available at here: 

https://livemanchesterac-my.sharepoint.com/:u:/g/personal/xinhang_guo_student_manchester_ac_uk/ESRG9-oFYYVLs-GzcVDvnDEB5z_VKL81eVPpH6OLPbXVag?e=ZlZIHY

To use the FPGA firmware on Red Pitaya, please follow the instructions below:

-1: Establish SSH connection with the Red Pitaya board as described here: 

https://redpitaya.readthedocs.io/en/latest/developerGuide/software/console/ssh/ssh.html

-2: copy the FPGA_Firmware.bit file to the Red Pitaya Linux OS using WinSCP

-3: type follow instructions on the Red Pitaya Linux OS: $[path of the FPGA_Firmware.bit file] > /dev/xdevcfg

-4: Connect the Red Pitaya board as follows: The IN 1 port of the Red Pitaya board is the input, the OUT 1 port is the restored signal output and OUT 2 port is the output phase measurement.

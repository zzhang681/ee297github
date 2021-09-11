set_global_assignment -entity "fptest" -library "lib_fptest" -name IP_TOOL_NAME "altera_fp_functions"
set_global_assignment -entity "fptest" -library "lib_fptest" -name IP_TOOL_VERSION "18.1"
set_global_assignment -entity "fptest" -library "lib_fptest" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_fptest" -name SPD_FILE [file join $::quartus(sip_path) "fptest.spd"]

set_global_assignment -library "lib_fptest" -name MISC_FILE [file join $::quartus(sip_path) "fptest_sim/fptest.vo"]
